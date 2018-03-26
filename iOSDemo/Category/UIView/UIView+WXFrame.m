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

- (void)setWx_originY:(CGFloat)wx_originY{
    CGRect frame = self.frame;
    frame.origin.y = wx_originY;
    self.frame = frame;
}
- (CGFloat)wx_originY{
    return self.frame.origin.y;
}

- (void)setWx_height:(CGFloat)wx_height{
    CGRect frame = self.frame;
    frame.size.height = wx_height;
    self.frame = frame;
}
- (CGFloat)wx_height{
    return self.frame.size.height;
}
- (void)setWx_width:(CGFloat)wx_width{
    CGRect frame = self.frame;
    frame.size.width = wx_width;
    self.frame = frame;
}
- (CGFloat)wx_width{
    return self.frame.size.width;
}

- (void)setWx_size:(CGSize)wx_size{
    CGRect frame = self.frame;
    frame.size = wx_size;
    self.frame = frame;
}
- (CGSize)wx_size{
    return self.frame.size;
}

- (void)setWx_origin:(CGPoint)wx_origin{
    CGRect frame = self.frame;
    frame.origin = wx_origin;
    self.frame = frame;
}
- (CGPoint)wx_origin{
    return self.frame.origin;
}
- (void)setWx_center:(CGPoint)wx_center{
    CGPoint center = self.center;
    center = wx_center;
    self.center = center;
}
- (CGPoint)wx_center{
    return self.center;
}
- (void)setWx_centerX:(CGFloat)wx_centerX{
    CGPoint center = self.center;
    center.x = wx_centerX;
    self.center = center;
}
- (CGFloat)wx_centerX{
    return self.center.x;
}
- (void)setWx_centerY:(CGFloat)wx_centerY{
    CGPoint center = self.center;
    center.y = wx_centerY;
    self.center = center;
}
- (CGFloat)wx_centerY{
    return self.center.y;
}
- (void)setWx_bottom:(CGFloat)wx_bottom{
    CGRect frame = self.frame;
    frame.origin.y = wx_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)wx_bottom{
    return CGRectGetMaxY(self.frame);
}
@end
