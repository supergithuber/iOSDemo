//
//  WXLocalLanguage.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/26.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXLocalLanguage.h"

@interface WXLocalLanguage()
//系统UI显示的语言
@property (nonatomic, copy)NSString* currentLanguage;

@end
@implementation WXLocalLanguage

- (NSString *)currentLanguage{
    return [[NSLocale preferredLanguages] firstObject];
}

- (BOOL)isChinese{
    return [self.currentLanguage containsString:@"zh"];
}
@end
