//
//  WXWebBrowser.h
//  iOSDemo
//
//  Created by Wuxi on 2018/4/9.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXWebBrowser : UIViewController

@property (nonatomic, assign)BOOL isNavigationHidden;

- (void)loadRemoteURLString:(NSString *)URLString;

@end
