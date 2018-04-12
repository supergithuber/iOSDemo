//
//  WXWebBrowserScriptMeaasgeDelegate.m
//  iOSDemo
//
//  Created by Wuxi on 2018/4/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXWebBrowserScriptMeaasgeDelegate.h"

@interface WXWebBrowserScriptMeaasgeDelegate()

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation WXWebBrowserScriptMeaasgeDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
//MARK: - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
