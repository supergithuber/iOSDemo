//
//  WXTabbar.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/16.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXTabbar.h"

NSInteger kButtonSize = 50;
@implementation WXTabBar

- (instancetype)init{
    if (self = [super init]){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_centerButton setImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateNormal];
    _centerButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - kButtonSize)/2.0, - kButtonSize/2.0, kButtonSize, kButtonSize);
    _centerButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:_centerButton];
}

//处理超出区域点击无效的问题

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil){
        //转换坐标
        CGPoint tempPoint = [self.centerButton convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerButton.bounds, tempPoint)){
            //返回按钮
            return _centerButton;
        }
    }
    return view;
}
@end
