//
//  AppDelegate.m
//  iOSDemo
//
//  Created by Wuxi on 17/3/7.
//  Copyright © 2017年 Wuxi. All rights reserved.
//

#import "AppDelegate.h"
#import "WXInitTabBarViewController.h"
#import "iOSDemo-Swift.h"

NSString *const kAppVersionKey = @"iOSDemo.appVersion";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //是不是当前版本首次启动
    if ([self isCurrentVersionLaunchFirstTime]){
        NSLog(@"当前版本%@：首次启动",kAppVersion);
    }else{
        NSLog(@"当前版本%@：不是首次启动",kAppVersion);
    }
    
    //决定root
    WXInitTabBarViewController *tabBarController = [[WXInitTabBarViewController alloc] init];
    self.window.rootViewController = tabBarController;
    
    //记录启动时间
    [self registerLaunchDateString];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//记录启动时间
- (void)registerLaunchDateString{
    NSLog(@"last launch app time: %@", DiskStorage.shared.appConfiguration.lastLaunchDateString);
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd,HH:mm:ss";
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    DiskStorage.shared.appConfiguration.lastLaunchDateString = currentDateString;
}
//是否当前版本首次启动
- (BOOL)isCurrentVersionLaunchFirstTime{
    NSString * appVersion = [NSUserDefaults.standardUserDefaults stringForKey:kAppVersionKey];
    if (appVersion == nil || appVersion != kAppVersion ){
        [NSUserDefaults.standardUserDefaults setValue:kAppVersion forKey:kAppVersionKey];
        [NSUserDefaults.standardUserDefaults synchronize];
        return YES;
    }else{
        return NO;
    }
}

@end
