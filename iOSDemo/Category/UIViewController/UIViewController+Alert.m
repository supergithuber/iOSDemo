//
//  UIViewController+Alert.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)wx_showSingleInputTexFieldWithTitle:(NSString *)title message:(NSString *)message sureBlock:(void (^)(NSString *))sureBlock cancelBlock:(void (^)())cancelBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (UITextField *textField in alertController.textFields) {
            if (sureBlock){
                sureBlock(textField.text);
            }
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock){
            cancelBlock();
        }
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)wx_showAlertWithTitle:(NSString *)title message:(NSString *)message sureBlock:(void (^)())sureBlock cancelBlock:(void (^)())cancelBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (sureBlock){
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            sureBlock();
        }];
        [alert addAction:action];
    }
    if (cancelBlock){
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cancelBlock();
        }];
        [alert addAction:cancelAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)wx_showAlertWithTitle:(NSString *)title message:(NSString *)message suerBlock:(void (^)())sureBlock{
    [self wx_showAlertWithTitle:title message:message sureBlock:sureBlock cancelBlock:nil];
}
@end
