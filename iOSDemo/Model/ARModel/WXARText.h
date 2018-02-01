//
//  WXARText.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface WXARText : SCNText

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color depth:(CGFloat)depth;

@end
