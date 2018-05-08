//
//  NSString+Encryption.h
//  iOSDemo
//
//  Created by HFY on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//
//https://www.jianshu.com/p/c059463f80cb
#import <Foundation/Foundation.h>

@interface NSString (Encryption)


/**
 @return 常规32位MD5码
 */
- (NSString *)md5;

/**
 @return 16位的MD5码
 */
- (NSString *)md5_16;
@end
