//
//  NSString+Regex.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
//预先定义好的一些正则，都是指包含一个或者多个
typedef NS_OPTIONS(NSUInteger, WXRegexType) {
    WXRegexTypeNone        = 0 << 0,
    WXRegexTypeCharacter   = 1 << 0,  //字母
    WXRegexTypeDigital     = 1 << 1,  //数字
    WXRegexTypeUnderline   = 1 << 2,  //下划线
    WXRegexTypeChinese     = 1 << 3,  //汉字
    WXRegexTypeSpace       = 1 << 4,  //空格
    WXRegexTypeDot         = 1 << 5,  //点
    WXRegexTypeAt          = 1 << 6,  //@
};

@interface NSString (Regex)


/**
 空字符串返回false
 @param type 类型
 @return 是否符合
 */
- (BOOL)regexMatchWithWXRegexType:(WXRegexType)type;


/**
 空字符串返回false，限制最大最小长度常常会在密码限制这种需求里用到，如果要穿最大，就用：NSUIntegerMax

 @param type WXRegexType
 @param minLength 最小长度
 @param maxLength 最大长度
 @return 是否符合
 */
- (BOOL)regexMatchWithWXRegexType:(WXRegexType)type minLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength;
/**
 基本函数，用谓词表达式
 
 @param regex 一段正则表达式
 @return 是否符合匹配
 */
- (BOOL)regexMatchWithPattern:(NSString *)regex;

@end
