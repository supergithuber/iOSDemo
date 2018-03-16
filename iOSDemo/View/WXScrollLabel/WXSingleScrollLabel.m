//
//  WXSingleScrollLabel.m
//  iOSDemo
//
//  Created by wuxi on 2018/3/15.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSingleScrollLabel.h"

@implementation WXSingleScrollLabel

- (instancetype)init{
    if (self = [super init]){
        _edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

+ (instancetype)singleScrollLabel{
    WXSingleScrollLabel *label = [[WXSingleScrollLabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _edgeInsets)];
}
@end
