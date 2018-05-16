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
@end
