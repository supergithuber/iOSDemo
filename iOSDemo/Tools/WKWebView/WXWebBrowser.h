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
@property (nonatomic, strong)UIColor *progressColor;

- (void)loadRemoteURLString:(NSString *)URLString;

@end
