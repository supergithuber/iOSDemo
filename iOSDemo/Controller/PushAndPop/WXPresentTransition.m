//
//  WXPresentTransition.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/2/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXPresentTransition.h"

@interface WXPresentTransition()
@property (nonatomic, assign)WXPresentedTransitionType type;
@end

@implementation WXPresentTransition

//MARK: - init
- (instancetype)initWithPresentedTransitionType:(WXPresentedTransitionType)type{
    if (self = [super init]){
        _type = type;
    }
    return self;
}

+ (instancetype)transitionWithPresentedTransitionType:(WXPresentedTransitionType)type{
    return [[self alloc] initWithPresentedTransitionType:type];
}

//MARK: - delegate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case WXPresentedTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case WXPresentedTransitionTypeDismiss:
            [self dismissAnimated:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

//MARK: - private
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}
- (void)dismissAnimated:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}
@end
