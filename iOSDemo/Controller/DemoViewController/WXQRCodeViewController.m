//
//  WXQRCodeViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/23.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WXQRCodeScanManager.h"

@interface WXQRCodeViewController ()<WXQRCodeScanDelegate>

@property (nonatomic, strong)WXQRCodeScanManager *scanManager;

@end

@implementation WXQRCodeViewController

- (void)dealloc{
    [self.scanManager cancelBrightnessOutput];
    [self.scanManager stopScanCode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self initScanManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initUI{
    self.view.backgroundColor = [UIColor clearColor];
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(0, 100, 50, 50);
    scanButton.backgroundColor = [UIColor greenColor];
    [scanButton setTitle:@"scan" forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
}
- (void)initScanManager{
    self.scanManager = [WXQRCodeScanManager sharedInstance];
    [self.scanManager setPreset:AVCaptureSessionPreset1920x1080 currentController:self];
    [self.scanManager resetBrightnessOutput];
    self.scanManager.delegate = self;
}

- (void)startScan{
    [self.scanManager startScanCode];
}
//扫描结果
- (void)WXQRCodeScanManager:(WXQRCodeScanManager *)manager outputMetadataObjects:(NSArray *)metadataObjects{
    if (metadataObjects != nil && metadataObjects.count > 0){
        
        [self.scanManager stopScanCode];
//        [self.scanManager removeScanPreviewLayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        [self LogToResultTextView:[NSString stringWithFormat:@"扫描到的码代表：%@",obj.stringValue]];
    }
}
//光线强度
- (void)WXQRCodeScanManager:(WXQRCodeScanManager *)manager brightnessValue:(CGFloat)brightness{
//    NSLog(@"现在光线强度%f", brightness);
}
@end
