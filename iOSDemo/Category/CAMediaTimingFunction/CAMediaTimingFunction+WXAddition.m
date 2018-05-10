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
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
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
@end
