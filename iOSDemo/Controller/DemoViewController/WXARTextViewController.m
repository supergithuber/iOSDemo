//
//  WXARTextViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXARTextViewController.h"
#import "UIViewController+Alert.h"

@implementation WXARTextViewController

- (void)dealloc{
    NSLog(@"artextViewcontroller释放");
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self wx_showSingleInputTexFieldWithTitle:@"请输入文字" message:@"文字将以artext的方式显示" sureBlock:^(NSString *text) {
        NSLog(@"输入的文字%@", text);
    } cancelBlock:^{
        
    }];
}
@end
