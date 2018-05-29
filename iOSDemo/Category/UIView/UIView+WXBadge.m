//
//  UIView+WXBadge.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/28.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIView+WXBadge.h"
//https://github.com/Minitour/EasyNotificationBadge
static int kBadgeTagNumber = 9898;

@implementation UIView (WXBadge)

- (void)wx_showBadge:(NSString *)badgeText{
    
}
- (void)wx_showBadge:(NSString *)badgeText appearance:(nonnull WXBadgeAppearance *)appearance{
    
}
- (void)wx_showBadge:(NSString *)badgeText appearance:(nonnull WXBadgeAppearance *)appearance edgeInset:(UIEdgeInsets)inset{
    UILabel *badgeLabel = nil;
    BOOL isBadgeExist = NO;
    
    //有可能已经有了badge
    for (UIView * view in self.subviews) {
        if (view.tag == kBadgeTagNumber && [view isKindOfClass:[UILabel class]]){
            badgeLabel = (UILabel *)view;
        }
    }
    if (badgeLabel != nil && badgeText == nil){
        if (appearance.animated){
            [UIView animateWithDuration:appearance.duration animations:^{
                badgeLabel.alpha = 0.0;
                badgeLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [badgeLabel removeFromSuperview];
            }];
        }else{
            [badgeLabel removeFromSuperview];
        }
        return;
    }else if (badgeText == nil && badgeLabel == nil){
        //没有text, 没有之前的label
        return;
    }
    //没有就创建一个
    if (badgeLabel == nil){
        badgeLabel = [[UILabel alloc] init];
        badgeLabel.tag = kBadgeTagNumber;
    }else{
        isBadgeExist = YES;
    }
    //之前有label
    CGFloat oldWidth = 0;
    if (isBadgeExist){
        oldWidth = badgeLabel.frame.size.width;
    }
    //设置属性
    badgeLabel.text = badgeText;
    badgeLabel.font = [UIFont systemFontOfSize:appearance.textSize];
    [badgeLabel sizeToFit];
    badgeLabel.textAlignment = appearance.textAlignment;
    badgeLabel.layer.backgroundColor = appearance.backgroundColor.CGColor;
    badgeLabel.textColor = appearance.textColor;
    //调整尺寸
    CGSize badgeSize = badgeLabel.frame.size;
    CGFloat height = MAX(18.0, badgeSize.height + 5.0);
    CGFloat width = MAX(height, badgeSize.width + 10.0);
    
    CGRect originFrame = badgeLabel.frame;
    originFrame.size = CGSizeMake(width, height);
    badgeLabel.frame = originFrame;
}
@end



@implementation WXBadgeAppearance

- (instancetype)init{
    if (self = [super init]){
        _textSize = 12;
        _textColor = [UIColor whiteColor];
        _textAlignment = NSTextAlignmentCenter;
        _duration = 0.2;
        _borderWidth = 0;
        _backgroundColor = [UIColor redColor];
        _animated = true;
        _allowShadow = false;
        _distanceFromCenterX = 0;
        _distanceFromCenterY = 0;
    }
    return self;
}
@end
