//
//  UIView+Badge.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (Badge)

/**
 *  针对 label button view，都是将 badge view 放置到当前对象的最右边中点的位置
 *
 *  1. label，将 badge view 增加到 label.subviews 中，显示在文字的后面，而不是整个 label 的末尾
 *
 *  2. button，将 badge view 增加到 button.subviews 中，显示在整个 button 的末尾
 *
 *  3. view，将 badge view 增加到 view.subviews 中，显示在整个 view 的末尾
 *
 */
- (void)showBadge;
- (void)hideBadge;

- (void)showCountBadge:(int) num;
- (void)hideCountBadge;


/**
 *  针对 tabbar
 */
- (void)showBadgeAtIndex:(int)index;
- (void)hideBadgeAtIndex:(int)index;

@end
