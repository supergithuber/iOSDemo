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

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}
//MARK: - 类方法
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
+ (nullable UIColor *)wx_colorWithHexString:(NSString *)stringToConvert {
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

//MARK: - 对颜色的修改
//MARK: 工具方法
- (BOOL)wx_red:(CGFloat *)red
         green:(CGFloat *)green
          blue:(CGFloat *)blue
         alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:    // We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}
- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}
//MARK: 具体修改方法
- (nullable UIColor *)wx_colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r * red))
                           green:MAX(0.0, MIN(1.0, g * green))
                            blue:MAX(0.0, MIN(1.0, b * blue))
                           alpha:MAX(0.0, MIN(1.0, a * alpha))];
}
- (nullable UIColor *)       wx_colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r + red))
                           green:MAX(0.0, MIN(1.0, g + green))
                            blue:MAX(0.0, MIN(1.0, b + blue))
                           alpha:MAX(0.0, MIN(1.0, a + alpha))];
}
- (nullable UIColor *) wx_colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(r, red)
                           green:MAX(g, green)
                            blue:MAX(b, blue)
                           alpha:MAX(a, alpha)];
}
- (nullable UIColor *)  wx_colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MIN(r, red)
                           green:MIN(g, green)
                            blue:MIN(b, blue)
                           alpha:MIN(a, alpha)];
}
//MARK: 上面的便利方法
- (nullable UIColor *)wx_colorByMultiplyingBy:(CGFloat)f {
    return [self wx_colorByMultiplyingByRed:f green:f blue:f alpha:1.0f];
}
- (nullable UIColor *)       wx_colorByAdding:(CGFloat)f {
    return [self wx_colorByAddingRed:f green:f blue:f alpha:0.0f];
}
- (nullable UIColor *) wx_colorByLighteningTo:(CGFloat)f {
    return [self wx_colorByLighteningToRed:f green:f blue:f alpha:0.0f];
}
- (nullable UIColor *)  wx_colorByDarkeningTo:(CGFloat)f {
    return [self wx_colorByDarkeningToRed:f green:f blue:f alpha:1.0f];
}

- (nullable UIColor *)wx_colorByMultiplyingByColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self wx_colorByMultiplyingByRed:r green:g blue:b alpha:1.0f];
}
- (nullable UIColor *)       wx_colorByAddingColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self wx_colorByAddingRed:r green:g blue:b alpha:0.0f];
}
- (nullable UIColor *) wx_colorByLighteningToColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self wx_colorByLighteningToRed:r green:g blue:b alpha:0.0f];
}
- (nullable UIColor *)  wx_colorByDarkeningToColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self wx_red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self wx_colorByDarkeningToRed:r green:g blue:b alpha:1.0f];
}

//MARK: - private get
- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

@end
