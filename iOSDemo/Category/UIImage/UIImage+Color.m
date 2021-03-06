//
//  UIImage+Color.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/25.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+(UIImage*)imageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
