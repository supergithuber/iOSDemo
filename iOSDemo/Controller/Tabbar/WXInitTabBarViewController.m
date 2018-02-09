//
//  WXInitTabBarViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXInitTabBarViewController.h"
#import "WXBaseNavigationViewController.h"
#import "ViewController.h"
#import "WXSettingsViewController.h"

@interface WXInitTabBarViewController ()

@end

@implementation WXInitTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubController {
    UIViewController *viewController = [[WXBaseNavigationViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    viewController.tabBarItem.title = @"首页";
    
    UIViewController *settingsController = [[WXBaseNavigationViewController alloc] initWithRootViewController:[[WXSettingsViewController alloc] init]];
    settingsController.tabBarItem.title = @"设置";
    
    [self addChildViewController:viewController];
    [self addChildViewController:settingsController];
}

@end
