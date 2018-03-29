//
//  WXFingerPrintViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/3/29.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXFingerPrintViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

static NSString *const kOpenTouchIDKey = @"com.iOSDemo.openTouchIDKey";

@interface WXFingerPrintViewController ()

@property (nonatomic, strong)UILabel *resultLabel;

@end

@implementation WXFingerPrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    label.text = @"从来没有识别过指纹";
    self.resultLabel = label;
    [self.view addSubview:label];
    [self updateResultLable];
    
    UIButton *authenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [authenButton setBackgroundColor:[UIColor redColor]];
    [authenButton setTitle:@"认证指纹" forState:UIControlStateNormal];
    [authenButton addTarget:self action:@selector(authorizeFinger:) forControlEvents:UIControlEventTouchUpInside];
    authenButton.frame = CGRectMake(0, 0, 100, 100);
    authenButton.center = self.view.center;
    [self.view addSubview:authenButton];
}

- (void)authorizeFinger:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        //支持生物识别
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"看看指纹" reply:^(BOOL success, NSError * _Nullable error) {
                if (success){
                    [self LogToResultTextView:@"指纹识别成功"];
                    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kOpenTouchIDKey];
                }else{
                    
                }
                [self updateResultLable];
            }];
        }
    });
}
- (void)updateResultLable{
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL openTouchID = [[[NSUserDefaults standardUserDefaults] objectForKey:kOpenTouchIDKey] boolValue];
        if (openTouchID){
            self.resultLabel.text = @"识别过正确过指纹";
        }else{
            self.resultLabel.text = @"从来没有识别过指纹";
        }
    });
    
}
@end
