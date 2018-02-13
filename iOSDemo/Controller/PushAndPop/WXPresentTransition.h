//
//  WXPresentTransition.h
//  iOSDemo
//
//  Created by 吴浠 on 2018/2/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WXPresentedTransitionType) {
    WXPresentedTransitionTypePresent = 0,//管理present动画
    WXPresentedTransitionTypeDismiss//管理dismiss动画
};

@interface WXPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPresentedTransitionType:(WXPresentedTransitionType)type;
+ (instancetype)transitionWithPresentedTransitionType:(WXPresentedTransitionType)type;

@end
