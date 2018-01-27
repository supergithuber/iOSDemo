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
- (BOOL)isChineseSimplified{
    return [self.currentLanguage containsString:@"zh-Hant"];
}
- (BOOL)isChineseTraditional{
    NSString *language = self.currentLanguage;
    return [language containsString:@"zh-Hant"] || [language containsString:@"zh-HK"] || [language containsString:@"zh-TW"] || [language containsString:@"zh-MO"];
}

- (BOOL)isJapanese{
    return [self.currentLanguage containsString:@"ja"];
}
- (BOOL)isKorean{
    return [self.currentLanguage containsString:@"ko"];
}
- (BOOL)isIndonesian{
    return [self.currentLanguage containsString:@"id"];
}

- (BOOL)isEnglish{
    return [self.currentLanguage containsString:@"en"];
}
- (BOOL)isFrench{
    return [self.currentLanguage containsString:@"fr"];
}
- (BOOL)isGerman{
    return [self.currentLanguage containsString:@"de"];
}
- (BOOL)isSpainish{
    return [self.currentLanguage containsString:@"es"];
}
- (BOOL)isItalian{
    return [self.currentLanguage containsString:@"it"];
}
- (BOOL)isPolish{
    return [self.currentLanguage containsString:@"pl"];
}
- (BOOL)isPortuguese{
    return [self.currentLanguage containsString:@"pt"];
}
- (BOOL)isRussian{
    return [self.currentLanguage containsString:@"ru"];
}
@end
