//
//  WXUserDefaults.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXUserDefaults : NSObject

extern NSString *const kAppLaunchDateKey;


+ (void)setStringValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *)stringValueForKey:(NSString *)key;

@end
