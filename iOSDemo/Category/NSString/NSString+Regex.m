//
//  NSString+Regex.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "NSString+Regex.h"

NSString *const WXPhoneNumberRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[01678])\\d{8}$";
NSString *const WXIDNumberRegex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
NSString *const WXEmailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";

@implementation NSString (Regex)

//MARK: - public

- (BOOL)regexMatchWithWXRegexType:(WXRegexType)type{
    if (type == WXRegexTypeNone) {
        return NO;
    }
    if (self.length == 0){
        return NO;
    }
    NSString *regexString = [self wx_regexStringWithWXRegexType:type];
    return [self regexMatchWithPattern:regexString];
}

- (BOOL)regexMatchWithWXRegexType:(WXRegexType)type minLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength{
    if (self.length < minLength){
        return NO;
    }
    if (self.length > maxLength){
        return NO;
    }
    return [self regexMatchWithWXRegexType:type];
}

- (BOOL)regexMatchWithPattern:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

//MARK: - private
- (NSString *)wx_regexStringWithWXRegexType:(WXRegexType)type{
    NSString *regex = @"";
    if (type & WXRegexTypeCharacter){
        regex = [NSString stringWithFormat:@"%@a-zA-Z", regex];
    }
    if (type & WXRegexTypeDigital){
        regex = [NSString stringWithFormat:@"%@\\d", regex];
    }
    if (type & WXRegexTypeUnderline){
        regex = [NSString stringWithFormat:@"%@_", regex];
    }
    if (type & WXRegexTypeChinese){
        regex = [NSString stringWithFormat:@"❶➋➌➍➎➏➐➑➒❿%@\u4e00-\u9fa5", regex];
    }
    if (type & WXRegexTypeSpace){
        regex = [NSString stringWithFormat:@"%@ ", regex];
    }
    if (type & WXRegexTypeDot){
        regex = [NSString stringWithFormat:@"%@.", regex];
    }
    if (type & WXRegexTypeAt){
        regex = [NSString stringWithFormat:@"%@@", regex];
    }
    regex = [NSString stringWithFormat:@"^[%@]+$", regex];
    return regex;
}
@end
