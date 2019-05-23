//
//  HUMCrashHelper.m
//  Insta360Pro
//
//  Created by Wuxi on 2019/4/2.
//  Copyright © 2019年 Insta360. All rights reserved.
//

/**
    Code reference: https://github.com/kstenerud/KSCrash
    File:
        1. KSCrash-iOS > KSCrash > Crash Recording > Tools > KSDynamicLinker.c => ksdl_getBinaryImage[function]
        2. KSCrash-iOS > KSCrash > Crash Recording > KSCrashReport.c => addUUIDElement[function]
 */

#import "WXCrashHelper.h"
#include <mach-o/dyld.h>

static uintptr_t firstCmdAfterHeader(const struct mach_header* const header) {
    switch (header->magic) {
        case MH_MAGIC:
        case MH_CIGAM:
            return (uintptr_t)(header + 1);
        case MH_MAGIC_64:
        case MH_CIGAM_64:
            return (uintptr_t)(((struct mach_header_64*)header) + 1);
        default:
            // Header is corrupt
            return 0;
    }
}

static const char hum_hexConvertTable[] = {
    '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
};

static NSString* convertToUUIDElement(const unsigned char* const value) {
    char uuidBuffer[37];
    const unsigned char* src = value;
    char* dst = uuidBuffer;
    for(int i = 0; i < 4; i++)
    {
        *dst++ = hum_hexConvertTable[(*src>>4)&15];
        *dst++ = hum_hexConvertTable[(*src++)&15];
    }
    *dst++ = '-';
    for(int i = 0; i < 2; i++)
    {
        *dst++ = hum_hexConvertTable[(*src>>4)&15];
        *dst++ = hum_hexConvertTable[(*src++)&15];
    }
    *dst++ = '-';
    for(int i = 0; i < 2; i++)
    {
        *dst++ = hum_hexConvertTable[(*src>>4)&15];
        *dst++ = hum_hexConvertTable[(*src++)&15];
    }
    *dst++ = '-';
    for(int i = 0; i < 2; i++)
    {
        *dst++ = hum_hexConvertTable[(*src>>4)&15];
        *dst++ = hum_hexConvertTable[(*src++)&15];
    }
    *dst++ = '-';
    for(int i = 0; i < 6; i++)
    {
        *dst++ = hum_hexConvertTable[(*src>>4)&15];
        *dst++ = hum_hexConvertTable[(*src++)&15];
    }
    
    NSString* uuid = [[NSString alloc] initWithCString:uuidBuffer encoding:NSUTF8StringEncoding];
    return uuid;
}

@implementation WXCrashHelper

+ (NSString *)getMainExecutableBinaryImageUUID {
    uint32_t imageCount = _dyld_image_count();
    for (uint32_t i = 0; i < imageCount; i++) {
        const struct mach_header* header = _dyld_get_image_header(i);
        if (header && header->filetype == MH_EXECUTE) {
            uintptr_t cmdPtr = firstCmdAfterHeader(header);
            if (cmdPtr == 0) {
                break;
            } else {
                uint64_t imageSize = 0;
                uint64_t imageVmAddr = 0;
                uint64_t version = 0;
                uint8_t* uuid = NULL;
                for (uint32_t iCmd = 0; iCmd < header->ncmds; iCmd++) {
                    struct load_command* loadCmd = (struct load_command*)cmdPtr;
                    switch (loadCmd->cmd) {
                        case LC_SEGMENT: {
                            struct segment_command* segCmd = (struct segment_command*)cmdPtr;
                            if (strcmp(segCmd->segname, SEG_TEXT) == 0) {
                                imageSize = segCmd->vmsize;
                                imageVmAddr = segCmd->vmaddr;
                            }
                            break;
                        }
                        case LC_SEGMENT_64: {
                            struct segment_command_64* segCmd = (struct segment_command_64*)cmdPtr;
                            if (strcmp(segCmd->segname, SEG_TEXT) == 0) {
                                imageSize = segCmd->vmsize;
                                imageVmAddr = segCmd->vmaddr;
                            }
                            break;
                        }
                        case LC_UUID: {
                            struct uuid_command* uuidCmd = (struct uuid_command*)cmdPtr;
                            uuid = uuidCmd->uuid;
                            break;
                        }
                        case LC_ID_DYLIB: {
                            struct dylib_command* dc = (struct dylib_command*)cmdPtr;
                            version = dc->dylib.current_version;
                            break;
                        }
                    }
                    cmdPtr += loadCmd->cmdsize;
                }
                if (uuid) {
                    NSString* UUID = convertToUUIDElement(uuid);
                    return UUID;
                }
            }
        }
    }
    return nil;
}

@end
