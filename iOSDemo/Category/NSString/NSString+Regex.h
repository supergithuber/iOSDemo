//
//  NSString+Regex.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)


/**
 基本函数，用谓词表达式
 
 @param regex 一段正则表达式
 @return 是否符合匹配
 */
- (BOOL)regexMatchWithPattern:(NSString *)regex;

@end
