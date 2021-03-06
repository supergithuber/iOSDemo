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
#import "WXQRCodeAlbumManager.h"

@interface WXQRCodeViewController ()<WXQRCodeScanDelegate, WXQRCodeAlbumDelegate>

@property (nonatomic, strong)WXQRCodeScanManager *scanManager;

@end

@implementation WXQRCodeViewController

- (void)dealloc{
    [self.scanManager cancelBrightnessOutput];
    [self.scanManager stopScanCode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initUI];
    
    [self initScanManager];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)initNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Album" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButtonItem:)];
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

- (void)clickRightBarButtonItem:(UIBarButtonItem *)button{
    WXQRCodeAlbumManager *albumManager = [WXQRCodeAlbumManager sharedInstance];
    albumManager.delegate = self;
    [albumManager openAlbumPickerViewController:self];
}
//MARK: - WXQRCodeScanDelegate
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

//MARK: - WXQRCodeAlbumDelegate
- (void)WXQRCodeAlbumManagerDidCancelPickPhoto:(WXQRCodeAlbumManager *)manager{
    
}
- (void)WXQRCodeAlbumManagerDidReadFailed:(WXQRCodeAlbumManager *)manager{
    [self LogToResultTextView:@"没有识别到二维码"];
}
- (void)WXQRCodeAlbumManager:(WXQRCodeAlbumManager *)manager resultString:(NSString *)resultString{
    [self LogToResultTextView:[NSString stringWithFormat:@"图片二维码的内容:%@", resultString]];
}
@end
