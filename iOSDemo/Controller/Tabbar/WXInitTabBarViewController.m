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
    self.tabBar.tintColor = [UIColor purpleColor];
    self.tabBar.unselectedItemTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    UIViewController *viewController = [[WXBaseNavigationViewController alloc] initWithRootViewController:[[ViewController alloc] init]];
    viewController.tabBarItem.title = @"首页";
    viewController.tabBarItem.image = [UIImage imageNamed:@"tab_ic_explore_a"];
    
    UIViewController *settingsController = [[WXBaseNavigationViewController alloc] initWithRootViewController:[[WXSettingsViewController alloc] init]];
    settingsController.tabBarItem.title = @"设置";
    settingsController.tabBarItem.image = [UIImage imageNamed:@"tab_ic_setting_a"];
    
    [self addChildViewController:viewController];
    [self addChildViewController:settingsController];
}

@end
