//
//  NSDate+dateTools.h
//  iOSDemo
//
//  Created by wuxi on 2018/2/23.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (dateTools)

//格式是：yyyy-MM-dd HH:mm:ss
+ (NSString *)currentDateString;

//当前系统时间戳
+ (NSInteger)currentTimeStamp;

/**
 将某个时间戳转换成时间字符串

 @param timestamp 时间戳
 @param format 想要的输出格式，形如：YYYY-MM-dd hh:mm:ss
 @return 时间字符串
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 将某个时间转换成时间戳

 @param formatTime 时间字符串
 @param format 时间字符串对应的格式，形如：YYYY-MM-dd hh:mm:ss
 @return 时间戳
 */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 对比两个时间

 @param oneDay 一个时间字符串
 @param anotherDay 另一个时间字符串
 @param format 这两个时间字符串对应的时间格式
 */

+ (NSComparisonResult)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format;
@end
