//
//  UIView+Badge.m
//  iOSTest
//
//  Created by wuxi on 2018/1/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIView+Badge.h"
static CGFloat const kCornerRadius = 4;
static NSInteger const kTagValue = 3215; // 尽量随机

static CGFloat const kLabelCornerRadius = 8;
static NSInteger const kLabelTagValue = 3243;

@implementation UIView (Badge)

#pragma mark - interface

- (void)showBadge {
    if ([self isKindOfClass:[UILabel class]]) {
        [self showLabelBadge];
    }else if ([self isKindOfClass:[UIButton class]]){
        [self showButtonBadge];
    }else if ([self isKindOfClass:[UIView class]]) {
        [self showViewBadge];
    }
}

- (void)hideBadge {
    UIView *badgeView = [self viewWithTag:kTagValue];
    [badgeView removeFromSuperview];
}

//MARK:label
- (void)showCountBadge:(int)num {
    if ([self isKindOfClass:[UILabel class]]) {
        [self showCountLabelBadge:num];
    }else if ([self isKindOfClass:[UIButton class]]){
        [self showCountButtonBadge:num];
    }else if ([self isKindOfClass:[UIView class]]) {
        [self showCountViewBadge:num];
    }
    
}
- (void)hideCountBadge {
    UIView *labelBadgeView =[self viewWithTag:kLabelTagValue];
    [labelBadgeView removeFromSuperview];
}


// tab bar
- (void)showBadgeAtIndex:(int)index {
    if ([self isKindOfClass:[UITabBar class]]) {
        UIView *badgeView = [self viewWithTag:kTagValue + index];
        if (!badgeView) {
            UITabBar *currentObject = (UITabBar *)self;
            NSInteger count = currentObject.items.count;
            badgeView = [self normalBadgeView];
            badgeView.tag = kTagValue + index;
            CGRect frame = currentObject.frame;
            
            float percentX = (index +0.6) / count;
            CGFloat x = ceilf(percentX * frame.size.width);
            CGFloat y = ceilf(0.1 * frame.size.height);
            badgeView.frame = CGRectMake(x, y, kCornerRadius * 2, kCornerRadius * 2);
            [currentObject addSubview:badgeView];
        }
    }
}

- (void)hideBadgeAtIndex:(int)index {
    if ([self isKindOfClass:[UITabBar class]]) {
        UIView *badgeView = [self viewWithTag:kTagValue + index];
        [badgeView removeFromSuperview];
    }
}

#pragma mark - inner

// label
- (void)showLabelBadge {
    UIView *badgeView = [self viewWithTag:kTagValue];
    if (!badgeView) {
        UILabel *currentObject = (UILabel *)self;
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = currentObject.textAlignment;
        label.font = currentObject.font;
        label.text = currentObject.text;
        label.numberOfLines = currentObject.numberOfLines;
        label.adjustsFontSizeToFitWidth = currentObject.adjustsFontSizeToFitWidth;
        label.baselineAdjustment = currentObject.baselineAdjustment;
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_2_0 && __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_6_0
        label.minimumFontSize = currentObject.minimumFontSize;
#endif
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0 && __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_7_0
        label.adjustsLetterSpacingToFitWidth = currentObject.adjustsLetterSpacingToFitWidth;
#endif
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        label.preferredMaxLayoutWidth = currentObject.preferredMaxLayoutWidth;
        label.minimumScaleFactor = currentObject.minimumScaleFactor;
        label.attributedText = currentObject.attributedText;
#endif
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
        label.allowsDefaultTighteningForTruncation = currentObject.allowsDefaultTighteningForTruncation;
#endif
        
        [label sizeToFit];
        CGFloat labelWidth = label.frame.size.width;
        
        badgeView = [self normalBadgeView];
        [currentObject addSubview:badgeView];
        CGRect labelFrame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMinX(labelFrame) + labelWidth - kCornerRadius, CGRectGetHeight(labelFrame) / 2.0 - kCornerRadius, kCornerRadius * 2, kCornerRadius * 2);
    }
}


// button
- (void)showButtonBadge {
    UIView *badgeView = [self viewWithTag:kTagValue];
    if (!badgeView) {
        UIButton *currentObject = (UIButton *)self;
        badgeView = [self normalBadgeView];
        [currentObject addSubview:badgeView];
        CGRect frame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMaxX(frame) + kCornerRadius * 2, CGRectGetHeight(frame) / 2.0 - kCornerRadius, kCornerRadius * 2, kCornerRadius * 2);
    }
}

// view
- (void)showViewBadge {
    UIView *badgeView = [self viewWithTag:kTagValue];
    if (!badgeView) {
        UIView *currentObject = self;
        badgeView = [self normalBadgeView];
        [currentObject addSubview:badgeView];
        CGRect frame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMaxX(frame) + kCornerRadius * 2, CGRectGetHeight(frame) / 2.0 - kCornerRadius, kCornerRadius * 2, kCornerRadius * 2);
    }
}
#pragma mark - Countlabel

// label
- (void)showCountLabelBadge:(int)num {
    UIView *badgeView = [self viewWithTag:kLabelTagValue];
    if (!badgeView) {
        UILabel *currentObject = (UILabel *)self;
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = currentObject.textAlignment;
        label.font = currentObject.font;
        label.text = currentObject.text;
        label.numberOfLines = currentObject.numberOfLines;
        label.adjustsFontSizeToFitWidth = currentObject.adjustsFontSizeToFitWidth;
        label.baselineAdjustment = currentObject.baselineAdjustment;
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_2_0 && __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_6_0
        label.minimumFontSize = currentObject.minimumFontSize;
#endif
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0 && __IPHONE_OS_VERSION_MIN_REQUIRED <= __IPHONE_7_0
        label.adjustsLetterSpacingToFitWidth = currentObject.adjustsLetterSpacingToFitWidth;
#endif
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        label.preferredMaxLayoutWidth = currentObject.preferredMaxLayoutWidth;
        label.minimumScaleFactor = currentObject.minimumScaleFactor;
        label.attributedText = currentObject.attributedText;
#endif
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
        label.allowsDefaultTighteningForTruncation = currentObject.allowsDefaultTighteningForTruncation;
#endif
        
        [label sizeToFit];
        CGFloat labelWidth = label.frame.size.width;
        
        badgeView = [self normalBadgeLabelWithNum:num];
        [currentObject addSubview:badgeView];
        CGRect labelFrame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMinX(labelFrame) + labelWidth - kLabelCornerRadius, CGRectGetHeight(labelFrame) / 2.0 - kLabelCornerRadius, kLabelCornerRadius * 2, kLabelCornerRadius * 2);
    }
}


// button
- (void)showCountButtonBadge:(int) num {
    UIView *badgeView = [self viewWithTag:kLabelTagValue];
    if (!badgeView) {
        UIButton *currentObject = (UIButton *)self;
        badgeView = [self normalBadgeLabelWithNum:num];
        [currentObject addSubview:badgeView];
        CGRect frame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMaxX(frame) + kLabelCornerRadius * 2, CGRectGetHeight(frame) / 2.0 - kLabelCornerRadius, kLabelCornerRadius * 2, kLabelCornerRadius * 2);
    }
}

// view
- (void)showCountViewBadge:(int) num {
    UIView *badgeView = [self viewWithTag:kLabelTagValue];
    if (!badgeView) {
        UIView *currentObject = self;
        badgeView = [self normalBadgeLabelWithNum:num];
        [currentObject addSubview:badgeView];
        CGRect frame = currentObject.frame;
        badgeView.frame = CGRectMake(CGRectGetMaxX(frame) + kLabelCornerRadius * 2, CGRectGetHeight(frame) / 2.0 - kLabelCornerRadius, kLabelCornerRadius * 2, kLabelCornerRadius * 2);
    }
}

#pragma mark - helps

- (UIView *)normalBadgeView {
    UIView *badgeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCornerRadius * 2, kCornerRadius * 2)];
    badgeView.tag = kTagValue;
    badgeView.backgroundColor = [UIColor redColor];
    badgeView.layer.cornerRadius = kCornerRadius;
    badgeView.layer.masksToBounds = YES;
    return badgeView;
}

- (UILabel *)normalBadgeLabelWithNum:(int) number{
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelCornerRadius * 2, kLabelCornerRadius * 2)];
    labelView.tag = kLabelTagValue;
    labelView.text = [NSString stringWithFormat:@"%i", number];
    labelView.textColor = [UIColor whiteColor];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.font = [UIFont systemFontOfSize:12];
    labelView.backgroundColor = [UIColor redColor];
    labelView.layer.cornerRadius = kLabelCornerRadius;
    labelView.layer.masksToBounds = YES;
    return labelView;
}

@end
