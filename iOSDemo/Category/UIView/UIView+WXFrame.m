//
//  UIView+WXFrame.m
//  iOSDemo
//
//  Created by wuxi on 2018/3/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIView+WXFrame.h"

@implementation UIView (WXFrame)

- (void)setWx_originX:(CGFloat)wx_originX{
    CGRect frame = self.frame;
    frame.origin.x = wx_originX;
    self.frame = frame;
}
- (CGFloat)wx_originX{
    return self.frame.origin.x;
}
@end
