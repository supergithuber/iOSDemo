//
//  WXSecondPresentedViewController.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/2/13.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSecondPresentedViewController.h"

@interface WXSecondPresentedViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation WXSecondPresentedViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //为什么要设置为Custom，在最后说明.
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

//MARK - delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return nil;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return nil;
}

@end
