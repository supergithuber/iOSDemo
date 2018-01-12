//
//  UIViewController+GetViewController.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GetViewController)

/**
 *  获取根控制器
 *
 *  @return 根控制器
 */
+ (__kindof UIViewController *)rootViewController;

/**
 *  获取当前导航控制器
 *
 *  @return 当前导航控制器
 */
+ (__kindof UINavigationController*)currentNavigationViewController;

/**
 *  获取当前控制器
 *
 *  @return 当前控制器
 */
+ (__kindof UIViewController *)currentViewController;

@end
