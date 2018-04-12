//
//  WXWebBrowser.m
//  iOSDemo
//
//  Created by Wuxi on 2018/4/9.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXWebBrowser.h"
#import <WebKit/WebKit.h>
#import "WXWebBrowserScriptMeaasgeDelegate.h"

static NSString *const kScriptMessageHandlerFirstKey = @"com.iOSDemo.scriptMessageHandlerFirstKey";
static void *kProgressViewContext = &kProgressViewContext;

@interface WXWebBrowser ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *wkWebView;
@property (nonatomic)UIBarButtonItem *backBarButtonItem;
@property (nonatomic)UIBarButtonItem *closeBarButtonItem;

@property (nonatomic, copy)NSString *remoteURL;

//进度条
@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation WXWebBrowser

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    //移除代理
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate = nil;
    //移除usercontent
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kScriptMessageHandlerFirstKey];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
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
- (void)setupView {
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
    self.navigationItem.rightBarButtonItem = roadLoad;
}
- (void)updateNavigationItems {
    if ([self.wkWebView canGoBack]){
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.backBarButtonItem,self.closeBarButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.backBarButtonItem]];
    }
}
//MARK: - Action
- (void)roadLoadClicked {
    [self.wkWebView reload];
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
//MARK: - public
- (void)loadRemoteURLString:(NSString *)URLString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [self.wkWebView loadRequest:request];
}
//MARK: - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]){
        [self.progressView setAlpha:1.0];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        //加载完成消失
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//MARK: - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}
//MARK: - WKNavigationDelegate
//页面开始加载时
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    self.progressView.hidden = NO;
}
//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"内容开始返回");
}
//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成");
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    NSLog(@"页面加载失败%@", error);
}
//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"收到服务器跳转请求");
}
//在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"在发送请求之前，决定是否跳转");
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
            break;
        default:
            break;
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}
//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"跳转失败%@", error);
}
//进度条结束
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
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
        //添加脚本信息处理者，需要实现WKScriptMessageHandler这个协议,另外一个类主要是解决wkwebkit的bug，不会释放的问题
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        [contentController addScriptMessageHandler:[[WXWebBrowserScriptMeaasgeDelegate alloc] initWithDelegate:self] name:kScriptMessageHandlerFirstKey];
        configuration.userContentController = contentController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES; //允许手势滑动前进后退
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:kProgressViewContext];
        _wkWebView.allowsBackForwardNavigationGestures = YES;  //手势触摸
        [_wkWebView sizeToFit];
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
