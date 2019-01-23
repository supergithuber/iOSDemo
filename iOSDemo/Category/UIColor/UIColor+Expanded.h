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
+ (nullable UIColor *)wx_colorWithHexString:(NSString *)stringToConvert;//"#ffffff", "0xffffff"

/**
 取两个颜色之间的线性差值

 @param ratio 从第一个颜色到第二个的百分比，【0.0， 1.0】，大于1取toColor，小于0取fromcColor
 */
+ (UIColor *)wx_colorByLerpingFromColor:(UIColor *)fromColor
                                toColor:(UIColor *)toColor
                                  ratio:(CGFloat)ratio;

/**
 取出颜色对应的rgba值
 @return 取出成功返回yes
 */
- (BOOL)wx_red:(CGFloat *)red
         green:(CGFloat *)green
          blue:(CGFloat *)blue
         alpha:(CGFloat *)alpha;


/**
 两个颜色是否相等
 只比较RGB颜色
 */
- (BOOL)isColorEqualToColor:(UIColor *)color;

/**
 4个函数分别对应：
 颜色四个分量分别乘以，加上，取最大值，取最小值
 初始颜色空间不是RGB时返回nil
 
 */
- (nullable UIColor *)wx_colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *)       wx_colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *) wx_colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (nullable UIColor *)  wx_colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 上面四个方法的遍历操作，rgb都使用f值，不改变alpha值

 */
- (nullable UIColor *)wx_colorByMultiplyingBy:(CGFloat)f;
- (nullable UIColor *)       wx_colorByAdding:(CGFloat)f;
- (nullable UIColor *) wx_colorByLighteningTo:(CGFloat)f;
- (nullable UIColor *)  wx_colorByDarkeningTo:(CGFloat)f;

/**
 从一种颜色到另一种颜色的渐变，对应RGB的乘，加，取较小，取较大, alpla不变

 */
- (nullable UIColor *)wx_colorByMultiplyingByColor:(UIColor *)color;
- (nullable UIColor *)       wx_colorByAddingColor:(UIColor *)color;
- (nullable UIColor *) wx_colorByLighteningToColor:(UIColor *)color;
- (nullable UIColor *)  wx_colorByDarkeningToColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
