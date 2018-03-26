//
//  UIView+WXFrame.h
//  iOSDemo
//
//  Created by wuxi on 2018/3/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

//就是为了简单设置和获取，不用再view.bound.size.width这样获取，直接view.with
//其他的属性也是

@interface UIView (WXFrame)

@property (nonatomic, assign)CGFloat wx_originX;
@property (nonatomic, assign)CGFloat wx_originY;

@property (nonatomic, assign)CGFloat wx_height;
@property (nonatomic, assign)CGFloat wx_width;

@property (nonatomic, assign)CGSize wx_size;

@property (nonatomic, assign)CGPoint wx_origin;
@property (nonatomic, assign)CGPoint wx_center;
@property (nonatomic, assign)CGFloat wx_centerY;
@property (nonatomic, assign)CGFloat wx_centerX;

@property (nonatomic, assign)CGFloat wx_bottom;

@end
