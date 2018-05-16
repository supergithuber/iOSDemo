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
#import "WXCenterViewController.h"
#import "WXTabbar.h"

@interface WXInitTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong)WXTabBar *wxTabBar;
@end

@implementation WXInitTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTabBar{
    _wxTabBar = [[WXTabBar alloc] init];
    _wxTabBar.tintColor = [UIColor purpleColor];
    _wxTabBar.unselectedItemTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self setValue:_wxTabBar forKeyPath:@"tabBar"];
    self.delegate = self;
    [self initSubController];
}
- (void)initSubController {
    
//    self.tabBar.tintColor = [UIColor purpleColor];
//    self.tabBar.unselectedItemTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self addChildTabWithController:[[ViewController alloc] init] image:@"tab_ic_explore_a" selectedImage:@"" title:@"首页"];
    [self addChildTabWithController:[[WXCenterViewController alloc] init] image:@"" selectedImage:@"" title:@"空"];
    [self addChildTabWithController:[[WXSettingsViewController alloc] init] image:@"tab_ic_setting_a" selectedImage:@"" title:@"设置"];
    
}

- (void)addChildTabWithController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    UIViewController *viewController = [[WXBaseNavigationViewController alloc] initWithRootViewController:controller];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:viewController];
}

@end
