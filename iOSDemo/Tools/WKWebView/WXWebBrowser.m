//
//  WXWebBrowser.m
//  iOSDemo
//
//  Created by Wuxi on 2018/4/9.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXWebBrowser.h"
#import <WebKit/WebKit.h>

static NSString *const kScriptMessageHandlerFirstKey = @"com.iOSDemo.scriptMessageHandlerFirstKey";
static void *kProgressViewContext = &kProgressViewContext;

@interface WXWebBrowser ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *wkWebView;
@property (nonatomic)UIBarButtonItem *backBarButtonItem;
@property (nonatomic)UIBarButtonItem *closeBarButtonItem;

//进度条
@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation WXWebBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isNavigationHidden){
        self.navigationController.navigationBarHidden = NO;
        //加一个自定义的状态栏
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height)];
        statusBarView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:statusBarView];
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)closeWebview {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backWebview {
    if (self.wkWebView.canGoBack){
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//MARK: - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}
//MARK: - 一些懒加载
- (WKWebView *)wkWebView{
    if (!_wkWebView){
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.allowsInlineMediaPlayback = YES;  //允许在线播放视频
        configuration.allowsAirPlayForMediaPlayback = YES;  //是否允许AirPlay
        configuration.selectionGranularity = WKSelectionGranularityCharacter;  //选择粒度
        configuration.processPool = [WKProcessPool new];  //https://developer.apple.com/documentation/webkit/wkprocesspool
        configuration.suppressesIncrementalRendering = YES;  //（压制增量渲染）是否全部加载到内存里，才会去渲染
        //添加脚本信息处理者，需要实现WKScriptMessageHandler这个协议
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        [contentController addScriptMessageHandler:self name:kScriptMessageHandlerFirstKey];
        configuration.userContentController = contentController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES; //允许手势滑动前进后退
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:kProgressViewContext];
        
    }
    return _wkWebView;
}
- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem){
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigation-back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backWebview) forControlEvents:UIControlEventTouchUpInside];
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _backBarButtonItem;
}
- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem){
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-close"] style:UIBarButtonItemStylePlain target:self action:@selector(closeWebview)];
    }
    return _closeBarButtonItem;
}
- (UIProgressView *)progressView{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (_isNavigationHidden){
            _progressView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + 44, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
@end
