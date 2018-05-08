//
//  NSString+Encryption.m
//  iOSDemo
//
//  Created by HFY on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Encryption)

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

- (NSString *)md5_16{
    // 提取32位MD5散列的中间16位
    NSString *md5_32=[self md5];
    // 即9～25位
    NSString *result = [[md5_32 substringToIndex:24] substringFromIndex:8];
    return result;
}
@end
