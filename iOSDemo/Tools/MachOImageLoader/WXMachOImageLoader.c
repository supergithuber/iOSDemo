//
//  WXMachOImageLoader.c
//  iOSDemo
//
//  Created by SivanWu on 2020/3/31.
//  Copyright © 2020 Wuxi. All rights reserved.
//

#include "WXMachOImageLoader.h"
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

typedef struct symtab_command symtab_command;
typedef struct dysymtab_command dysymtab_command;
typedef struct load_command load_command;

// relocation_info.r_length field has value 3 for 64-bit executables and value 2 for 32-bit executables
#if __LP64__
#define LC_SEGMENT_COMMAND        LC_SEGMENT_64
#define LC_ROUTINES_COMMAND        LC_ROUTINES_64
#define LC_SEGMENT_COMMAND_WRONG LC_SEGMENT
typedef struct mach_header_64 mach_header;
typedef struct segment_command_64 macho_segment_command;
typedef struct section_64 section;
typedef struct routines_command_64 routines_command;
typedef struct nlist_64 macho_nlist;
#else
#define LC_SEGMENT_COMMAND        LC_SEGMENT
#define LC_ROUTINES_COMMAND        LC_ROUTINES
#define LC_SEGMENT_COMMAND_WRONG LC_SEGMENT_64
typedef struct mach_header mach_header;
typedef struct segment_command macho_segment_command;
typedef struct section section;
typedef struct routines_command routines_command;
typedef struct nlist macho_nlist;
#endif

int wxmacho_findInfoForSymbolAndImageIfCheckLocalSymbol(const struct mach_header* mh,
                                                        const char *symbol,
                                                        WXMachOImageInfo *info,
                                                        int ifCheckLocalSymbol)
{
    const dysymtab_command* dynSymbolTable = NULL;
    const symtab_command* symtab = NULL;
    const macho_segment_command* seg;
    const uint8_t* unslidLinkEditBase = NULL;
    bool linkEditBaseFound = false;
    intptr_t slide = 0;
    const uint32_t cmd_count = mh->ncmds;
    const load_command* const cmds = (load_command*)((char*)mh + sizeof(mach_header));
    const load_command* cmd = cmds;
    for (uint32_t i = 0; i < cmd_count; ++i) {
        switch (cmd->cmd) {
            case LC_SEGMENT_COMMAND:
                seg = (macho_segment_command*)cmd;
                if ( strcmp(seg->segname, "__LINKEDIT") == 0 ) {
                    unslidLinkEditBase = (uint8_t*)(seg->vmaddr - seg->fileoff);
                    linkEditBaseFound = true;
                }
                else if ( strcmp(seg->segname, "__TEXT") == 0 ) {
                    slide = (uintptr_t)mh - seg->vmaddr;
                }
                break;
            case LC_SYMTAB:
                symtab = (symtab_command*)cmd;
                break;
            case LC_DYSYMTAB:
                dynSymbolTable = (dysymtab_command*)cmd;
                break;
        }
        cmd = (const struct load_command*)(((char*)cmd)+cmd->cmdsize);
    }
    
    // no symbol table => no lookup by address
    if ( (symtab == NULL) || (dynSymbolTable == NULL) || !linkEditBaseFound )
        return 0;
    
    const uint8_t* linkEditBase = unslidLinkEditBase + slide;
    const char* symbolTableStrings = (const char*)&linkEditBase[symtab->stroff];
    const macho_nlist* symbolTable = (macho_nlist*)(&linkEditBase[symtab->symoff]);
    
        //global symbols is sort by string key, so use binary search here!!!
    const macho_nlist* base = &symbolTable[dynSymbolTable->iextdefsym];
    uint32_t symbolCount = dynSymbolTable->nextdefsym;
    for (uint32_t n = symbolCount; n > 0; n /= 2) {
        const macho_nlist* pivot = &base[n/2];
        const char* pivotStr = &symbolTableStrings[pivot->n_un.n_strx];
        
        int cmp = strcmp(symbol, pivotStr);
        if ( cmp == 0 ) {
            info->dli_saddr = (const void *)(pivot->n_value + slide);
            info->dli_sname = symbol;
            return 1;
        }
        else if ( cmp > 0 ) {
            // key > pivot
            // move base to symbol after pivot
            base = &pivot[1];
            --n;
        }
        else {
            // key < pivot
            // keep same base
        }
    }
    
    if (ifCheckLocalSymbol) {
        const macho_nlist* localBase = &symbolTable[dynSymbolTable->ilocalsym];
        uint32_t localSymbolCount = dynSymbolTable->nlocalsym;
        for (uint32_t n = 0; n < localSymbolCount; n++) {
            const macho_nlist* pivot = &localBase[n];
            const char* pivotStr = &symbolTableStrings[pivot->n_un.n_strx];
            
            int cmp = strcmp(symbol, pivotStr);
            if ( cmp == 0 ) {
                info->dli_saddr = (const void *)(pivot->n_value + slide);
                info->dli_sname = symbol;
                return 1;
            }
        }
    }
    
    return 0;
}
