//
//  WXSecondPresentedViewController.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/2/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSecondPresentedViewController.h"
#import "WXPresentTransition.h"

@interface WXSecondPresentedViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation WXSecondPresentedViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //设置为Custom
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK - UIViewControllerTransitioningDelegate
//确定谁负责消失动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [WXPresentTransition transitionWithPresentedTransitionType:WXPresentedTransitionTypeDismiss];
}
//确定谁负责弹出
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [WXPresentTransition transitionWithPresentedTransitionType:WXPresentedTransitionTypePresent];
}

@end
