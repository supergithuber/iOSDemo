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


/**
 加载远程链接

 @param URLString 远程URLString
 */
- (void)loadRemoteURLString:(NSString *)URLString;

/**
 加载本地html文件

 @param fileName 本地html文件名
 */
- (void)loadLocalHTMLString:(NSString *)fileName;

@end
