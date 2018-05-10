//
//  CAMediaTimingFunction+WXAddition.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//提供系统默认的5种，这个分类做了拓展，提供了CSS上常用的
// kCAMediaTimingFunctionLinear
// kCAMediaTimingFunctionEaseIn
// kCAMediaTimingFunctionEaseOut
// kCAMediaTimingFunctionEaseInEaseOut
// kCAMediaTimingFunctionDefault
@interface CAMediaTimingFunction (WXAddition)

///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------
+ (CAMediaTimingFunction *)wx_easeInCirc;
+ (CAMediaTimingFunction *)wx_easeOutCirc;
+ (CAMediaTimingFunction *)wx_easeInOutCirc;
///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------
+ (CAMediaTimingFunction *)wx_easeInCubic;
+ (CAMediaTimingFunction *)wx_easeOutCubic;
+ (CAMediaTimingFunction *)wx_easeInOutCubic;
///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------
+ (CAMediaTimingFunction *)wx_easeInQuad;
+ (CAMediaTimingFunction *)wx_easeOutQuad;
+ (CAMediaTimingFunction *)wx_easeInOutQuad;
///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------
+(CAMediaTimingFunction *)wx_easeInExpo;
+(CAMediaTimingFunction *)wx_easeOutExpo;
+(CAMediaTimingFunction *)wx_easeInOutExpo;
///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------
+(CAMediaTimingFunction *)wx_easeInSine;
+(CAMediaTimingFunction *)wx_easeOutSine;
+(CAMediaTimingFunction *)wx_easeInOutSine;
///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------
+(CAMediaTimingFunction *)wx_easeInQuart;
+(CAMediaTimingFunction *)wx_easeOutQuart;
+(CAMediaTimingFunction *)wx_easeInOutQuart;
///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------
+(CAMediaTimingFunction *)wx_easeInQuint;
+(CAMediaTimingFunction *)wx_easeOutQuint;
+(CAMediaTimingFunction *)wx_easeInOutQuint;
///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------
+(CAMediaTimingFunction *)wx_easeInBack;
+(CAMediaTimingFunction *)wx_easeOutBack;
+(CAMediaTimingFunction *)wx_easeInOutBack;
@end
