//
//  UIImage+Color.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/25.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
//给定颜色，生成一张image
+(UIImage*)imageWithColor:(UIColor*) color;

@end
