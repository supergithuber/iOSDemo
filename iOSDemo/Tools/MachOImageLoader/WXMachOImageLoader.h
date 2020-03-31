//
//  WXMachOImageLoader.h
//  iOSDemo
//
//  Created by SivanWu on 2020/3/31.
//  Copyright © 2020 Wuxi. All rights reserved.
//

#ifndef WXMachOImageLoader_h
#define WXMachOImageLoader_h

#include <stdio.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

typedef struct WXMachOImageInfo {
    const char      *dli_fname;     /* Pathname of shared object */
    const void            *dli_fbase;     /* Base address of shared object */
    const char      *dli_sname;     /* Name of nearest symbol */
    const void            *dli_saddr;     /* Address of nearest symbol */
} WXMachOImageInfo;

typedef struct
{
    uint64_t address;
    uint64_t vmAddress;
    uint64_t size;
    const char* name;
    const uint8_t* uuid;
    int cpuType;
    int cpuSubType;
    uint64_t majorVersion;
    uint64_t minorVersion;
    uint64_t revisionVersion;
} WXMachOBinaryImage;

#ifdef __cplusplus
extern "C" {
#endif
int wxmacho_findInfoForSymbol(const char *symbol, WXMachOImageInfo *info);
int wxmacho_findInfoForAddress(const void *address, WXMachOImageInfo *info);

int wxmacho_findInfoForSymbolAndImage(const struct mach_header* mh,
                                      const char *symbol,
                                      WXMachOImageInfo *info);
    
int wxmacho_findInfoForSymbolAndImageIfCheckLocalSymbol(const struct mach_header* mh,
                                                        const char *symbol,
                                                        WXMachOImageInfo *info,
                                                        int ifCheckLocalSymbol);

//通过_dyld_image_count()可以得到当前ipa中有多少macho文件，例如主一个，每个动态库一个
//然后初始化WXMachOBinaryImage image = {0}，通过for循环把每个macho文件信息加载进来
int wxmacho_getBinaryImage(int index, WXMachOBinaryImage* buffer);

#ifdef __cplusplus
}
#endif

#endif /* WXMachOImageLoader_h */
