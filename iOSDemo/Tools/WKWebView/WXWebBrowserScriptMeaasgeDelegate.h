//
//  WXWebBrowserScriptMeaasgeDelegate.h
//  iOSDemo
//
//  Created by Wuxi on 2018/4/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WXWebBrowserScriptMeaasgeDelegate : NSObject<WKScriptMessageHandler>

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
