//
//  UIColor+Expanded.h
//  iOSDemo
//
//  Created by HFY on 2019/1/22.
//  Copyright © 2019年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLAMP(val,min,max)    MIN(MAX(val,min),max)

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Expanded)

+ (UIColor *)wx_randomColor;//随机颜色
+ (UIColor *)wx_colorWithRGBHex:(UInt32)hex; //0x430234
+ (UIColor *)wx_colorWithHexString:(NSString *)stringToConvert;//"#ffffff", "0xffffff"

@end

NS_ASSUME_NONNULL_END
