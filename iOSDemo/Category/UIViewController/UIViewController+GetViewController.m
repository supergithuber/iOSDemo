//
//  UIViewController+GetViewController.m
//  iOSTest
//
//  Created by wuxi on 2018/1/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIViewController+GetViewController.h"

@implementation UIViewController (GetViewController)

+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

+ (UIViewController *)rootViewController {
    return self.applicationDelegate.window.rootViewController;
}

+ (UINavigationController*)currentNavigationViewController {
    return self.currentViewController.navigationController;
}

+ (UIViewController *)currentViewController {
    return [self currentViewControllerFrom:self.rootViewController];
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end
