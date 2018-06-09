//
//  UIScrollView+Snapshot.m
//  iOSDemo
//
//  Created by Wuxi on 2018/6/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIScrollView+Snapshot.h"

@implementation UIScrollView (Snapshot)

- (UIImage *)fullSnapshot{
    //先记录下自己的frame和contentoffset，然后扩大frame到contentSize，截图然后恢复
    CGRect currentFrame = self.frame;
    CGPoint currentContentOffset = self.contentOffset;

    self.contentOffset = CGPointZero;
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(self.contentSize, YES, 0);//默认缩放因子
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.contentOffset = currentContentOffset;
    self.frame = currentFrame;
    return image;
}
@end
