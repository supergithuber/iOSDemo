//
//  UIColor+Expanded.h
//  iOSDemo
//
//  Created by Wuxi on 2019/1/22.
//  Copyright © 2019年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLAMP(val,min,max)    MIN(MAX(val,min),max)

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Expanded)

+ (UIColor *)wx_randomColor;//随机颜色
+ (UIColor *)wx_colorWithRGBHex:(UInt32)hex; //0x430234
+ (UIColor *)wx_colorWithHexString:(NSString *)stringToConvert;//"#ffffff", "0xffffff"

/**
 取两个颜色之间的线性差值

 @param ratio 从第一个颜色到第二个的百分比，【0.0， 1.0】，大于1取toColor，小于0取fromcColor
 */
+ (UIColor *)wx_colorByLerpingFromColor:(UIColor *)fromColor
                                toColor:(UIColor *)toColor
                                  ratio:(CGFloat)ratio;
@end

NS_ASSUME_NONNULL_END
