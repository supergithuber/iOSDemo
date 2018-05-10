//
//  UIApplication+Size.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIApplication+Size.h"

@implementation UIApplication (Size)

- (NSString *)applicationSize{
    unsigned long long docSize   =  [self wx_sizeOfFolder:[self wx_documentPath]];
    unsigned long long libSize   =  [self wx_sizeOfFolder:[self wx_libraryPath]];
    unsigned long long cacheSize =  [self wx_sizeOfFolder:[self wx_cachePath]];
    
    unsigned long long total = docSize + libSize + cacheSize;
    //用于计算byte大小的类
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
    return @"";
}

//MARK: - private
//document文件夹
- (NSString *)wx_documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
//library文件夹
- (NSString *)wx_libraryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
//cache文件夹
- (NSString *)wx_cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}
//MARK: 返回对应文件夹，遍历目录，得到总size
-(unsigned long long)wx_sizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}
@end
