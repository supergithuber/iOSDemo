//
//  UIViewController+Alert.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)wx_showSingleInputTexFieldWithTitle:(NSString *)title message:(NSString *)message sureBlock:(void(^)(NSString *))sureBlock cancelBlock:(void(^)())cancelBlock;

@end
