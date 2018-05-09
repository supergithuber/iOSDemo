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
 @return 常规MD5码（32位）
 */
- (NSString *)md5;

/**
 @return 取中间部分的MD5码（16位）
 */
- (NSString *)md5_16;

/**
 @return 40位
 */
- (NSString *)sha1;

/**
 @return 64位
 */
- (NSString *)sha256;

- (NSString *)sha384;   //96位
- (NSString *)sha512;   //128位

//base64加密和解密
- (NSString *)base64Encode;
- (nullable NSString *)base64Decode;

//DES对称加密和解密
- (NSString *)encryptWithKey:(NSString *)key;
- (NSString *)decryptWithKey:(NSString *)key;

@end
