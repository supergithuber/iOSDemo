//
//  CAMediaTimingFunction+WXAddition.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "CAMediaTimingFunction+WXAddition.h"

@implementation CAMediaTimingFunction (WXAddition)

#pragma mark - Circ

+(CAMediaTimingFunction *)wx_easeInCirc{
    return [CAMediaTimingFunction functionWithControlPoints: 0.6 : 0.04 : 0.98 : 0.335];
}
+(CAMediaTimingFunction *)wx_easeOutCirc{
    return [CAMediaTimingFunction functionWithControlPoints: 0.075 : 0.82 : 0.165 : 1.0];
}
+(CAMediaTimingFunction *)wx_easeInOutCirc{
    return [CAMediaTimingFunction functionWithControlPoints: 0.785 : 0.135 : 0.15 : 0.86];
}
#pragma mark - Cubic

+ (CAMediaTimingFunction *)wx_easeInCubic{
    return [CAMediaTimingFunction functionWithControlPoints:0.55 :0.55 :0.675 :0.19];
}
+ (CAMediaTimingFunction *)wx_easeOutCubic{
    return [CAMediaTimingFunction functionWithControlPoints:0.215 :0.61 :0.355 :1];
}
+ (CAMediaTimingFunction *)wx_easeInOutCubic{
    return [CAMediaTimingFunction functionWithControlPoints:0.645 :0.045 :0.355 :1];
}

#pragma mark - Quad

+ (CAMediaTimingFunction *)wx_easeInQuad{
    return [CAMediaTimingFunction functionWithControlPoints:0.55 :0.085 :0.68 :0.53];
}
+ (CAMediaTimingFunction *)wx_easeOutQuad{
    return [CAMediaTimingFunction functionWithControlPoints:0.25 :0.46 :0.45 :0.94];
}
+ (CAMediaTimingFunction *)wx_easeInOutQuad{
    return [CAMediaTimingFunction functionWithControlPoints:0.455 : 0.03 : 0.515 : 0.955];
}

#pragma mark - Expo
+ (CAMediaTimingFunction *)wx_easeInExpo{
    return [CAMediaTimingFunction functionWithControlPoints:0.55 :0.085 :0.68 :0.53];
}
+ (CAMediaTimingFunction *)wx_easeOutExpo{
    return [CAMediaTimingFunction functionWithControlPoints:0.25 :0.46 :0.45 :0.94];
}
+ (CAMediaTimingFunction *)wx_easeInOutExpo{
    return [CAMediaTimingFunction functionWithControlPoints:0.455 :0.03 :0.515 :0.955];
}

#pragma mark - Sine
+ (CAMediaTimingFunction *)wx_easeInSine{
    return [CAMediaTimingFunction functionWithControlPoints:0.47 :0.0 :0.745 :0.715];
}
+ (CAMediaTimingFunction *)wx_easeOutSine{
    return [CAMediaTimingFunction functionWithControlPoints:0.39 :0.575 :0.565 :1.0];
}
+ (CAMediaTimingFunction *)wx_easeInOutSine{
    return [CAMediaTimingFunction functionWithControlPoints:0.445 :0.05 :0.55 :0.95];
}

#pragma mark - Quart
+ (CAMediaTimingFunction *)wx_easeInQuart{
    return [CAMediaTimingFunction functionWithControlPoints:0.895 :0.03 :0.685 :0.22];
}
+ (CAMediaTimingFunction *)wx_easeOutQuart{
    return [CAMediaTimingFunction functionWithControlPoints:0.165 :0.84 :0.44 :1.0];
}
+ (CAMediaTimingFunction *)wx_easeInOutQuart{
    return [CAMediaTimingFunction functionWithControlPoints:0.77 :0.0 :0.175 :1.0];
}

#pragma mark - Quint
+ (CAMediaTimingFunction *)wx_easeInQuint{
    return [CAMediaTimingFunction functionWithControlPoints:0.755 :0.05 :0.855 :0.06];
}
+ (CAMediaTimingFunction *)wx_easeOutQuint{
    return [CAMediaTimingFunction functionWithControlPoints:0.23 :1.0 :0.320 :1.0];
}
+ (CAMediaTimingFunction *)wx_easeInOutQuint{
    return [CAMediaTimingFunction functionWithControlPoints:0.86 :0.0 :0.07 :1.0];
}

#pragma mark - Back
+ (CAMediaTimingFunction *)wx_easeInBack{
    return [CAMediaTimingFunction functionWithControlPoints:0.6 :-0.28 :0.735 :0.045];
}
+ (CAMediaTimingFunction *)wx_easeOutBack{
    return [CAMediaTimingFunction functionWithControlPoints:0.175 :0.885 :0.320 :1.275];
}
+ (CAMediaTimingFunction *)wx_easeInOutBack{
    return [CAMediaTimingFunction functionWithControlPoints:0.68 :-0.55 :0.265 :1.55];
}
@end
