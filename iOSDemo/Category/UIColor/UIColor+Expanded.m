//
//  UIColor+Expanded.m
//  iOSDemo
//
//  Created by Wuxi on 2019/1/22.
//  Copyright © 2019年 Wuxi. All rights reserved.
//

#import "UIColor+Expanded.h"

/*
 FOR REFERENCE:
 Color Space Models:
 enum CGColorSpaceModel {
 kCGColorSpaceModelUnknown = -1,
 kCGColorSpaceModelMonochrome,
 kCGColorSpaceModelRGB,
 kCGColorSpaceModelCMYK,
 kCGColorSpaceModelLab,
 kCGColorSpaceModelDeviceN,
 kCGColorSpaceModelIndexed,
 kCGColorSpaceModelPattern
 };
 */

@implementation UIColor (Expanded)

+ (UIColor *)wx_randomColor {
    return [UIColor colorWithRed:arc4random() / 0x100000000
                           green:arc4random() / 0x100000000
                            blue:arc4random() / 0x100000000
                           alpha:1.0f];
}

+ (UIColor *)wx_colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
+ (UIColor *)wx_colorWithHexString:(NSString *)stringToConvert {
    NSString *strippedString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:strippedString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor wx_colorWithRGBHex:hexNum];
}

+ (UIColor *)wx_colorByLerpingFromColor:(UIColor *)fromColor
                                toColor:(UIColor *)toColor
                                  ratio:(CGFloat)ratio {
    ratio = CLAMP(ratio, 0.f, 1.f);
    const CGFloat *fromComponents = CGColorGetComponents(fromColor.CGColor);
    const CGFloat *toComponents = CGColorGetComponents(toColor.CGColor);
    float r = fromComponents[0] + ((toComponents[0] - fromComponents[0]) * ratio);
    float g = fromComponents[1] + ((toComponents[1] - fromComponents[1]) * ratio);
    float b = fromComponents[2] + ((toComponents[2] - fromComponents[2]) * ratio);
    float a = fromComponents[3] + ((toComponents[3] - fromComponents[3]) * ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
@end
