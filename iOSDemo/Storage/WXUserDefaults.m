//
//  WXUserDefaults.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXUserDefaults.h"

NSString *const kAppLaunchDateKey = @"com.iOSDemo.launchDate";

@interface WXUserDefaults()


@end
@implementation WXUserDefaults


+ (void)setStringValue:(NSString *)value forKey:(NSString *)key{
    if (key && value){
        [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+ (NSString *)stringValueForKey:(NSString *)key{
    if (key){
        return [[NSUserDefaults standardUserDefaults] stringForKey:key];
    }else{
        return nil;
    }
}


@end
