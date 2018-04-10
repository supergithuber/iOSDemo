//
//  WXWebBrowser.m
//  iOSDemo
//
//  Created by Wuxi on 2018/4/9.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXWebBrowser.h"
#import <WebKit/WebKit.h>

@interface WXWebBrowser ()

@property (nonatomic, strong)WKWebView *wkWebView;
//进度条
@property (nonatomic, strong)UIProgressView *progressView;

@end

@implementation WXWebBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//MARK: - 一些懒加载
- (WKWebView *)wkWebView{
    if (!_wkWebView){
        
    }
    return _wkWebView;
}
- (UIProgressView *)progressView{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (_isNavigationHidden){
            //FIXME: 先不考虑iPhone X
            _progressView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
@end
