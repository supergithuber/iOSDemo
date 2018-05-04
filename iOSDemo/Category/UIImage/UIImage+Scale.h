//
//  UIImage+Scale.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/11.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

//裁剪图像的指定区域
- (UIImage *)getSubImage:(CGRect)rect;

//将图像压缩到指定大小
- (UIImage *)scaleToSize:(CGSize)size;
@end
