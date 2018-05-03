//
//  UIViewController+Alert.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

//一个alert，带有输入框
//点击确定回调输入结果，取消关闭
- (void)wx_showSingleInputTexFieldWithTitle:(NSString *)title message:(NSString *)message sureBlock:(void(^)(NSString *))sureBlock cancelBlock:(void(^)())cancelBlock;

//一个alert，带有确定和取消按钮
- (void)wx_showAlertWithTitle:(NSString *)title message:(NSString *)message sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancelBlock;

- (void)wx_showAlertWithTitle:(NSString *)title message:(NSString *)message suerBlock:(void(^)())sureBlock;
@end
