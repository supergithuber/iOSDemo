//
//  UIView+WXBadge.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/28.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXBadgeAppearance;

@interface UIView (WXBadge)

- (void)wx_showBadge:(NSString *)badgeText;
- (void)wx_showBadge:(NSString *)badgeText appearance:(nonnull WXBadgeAppearance *)appearance;
- (void)wx_showBadge:(NSString *)badgeText appearance:(nonnull WXBadgeAppearance *)appearance edgeInset:(UIEdgeInsets)inset;

@end


@interface WXBadgeAppearance: NSObject

@property (nonatomic, strong)UIColor* backgroundColor;
@property (nonatomic, assign)CGFloat textSize;
@property (nonatomic, strong)UIColor* textColor;
@property (nonatomic, assign)CGFloat borderWidth;
@property (nonatomic, assign)NSTextAlignment textAlignment;
@property (nonatomic, assign)BOOL animated;
@property (nonatomic, assign)NSTimeInterval duration;
@property (nonatomic, assign)BOOL allowShadow;
@property (nonatomic, assign)CGFloat distanceFromCenterX;
@property (nonatomic, assign)CGFloat distanceFromCenterY;

@end
