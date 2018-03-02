//
//  WXQRCodeManager.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXQRCodeScanManager.h"
#import <AVFoundation/AVFoundation.h>

@interface WXQRCodeScanManager()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong)AVCaptureSession *captureSession;
@property (nonatomic, strong)AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation WXQRCodeScanManager

static WXQRCodeScanManager *_instance = nil;

+ (instancetype)sharedInstance{
    //单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

- (void)setPreset:(NSString *)preset currentController:(UIViewController *)controller{
    NSAssert(preset != nil, @"preset cannot be nil");
    NSAssert(controller != nil, @"contriller cannot be nil");
    
    AVCaptureSession *captureSession = [AVCaptureSession new];
    [captureSession setSessionPreset:preset];
    self.captureSession = captureSession;
    //1.初始化输入
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error){
        NSLog(@"初始化输入设备失败%@", error);
        return;
    }
    
    //2.初始化二维码输出数据
    AVCaptureMetadataOutput *metadataOutput = [AVCaptureMetadataOutput new];
//    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);    //设置读取区域，坐标和UIView不同
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];   //AVCaptureMetadataOutputObjectsDelegate
    
    //3.初始化输出流
    AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];    //AVCaptureVideoDataOutputSampleBufferDelegate
    self.videoDataOutput = videoDataOutput;
    
    //4.把输入输出加入session
    if ([captureSession canAddInput:deviceInput]) {
        [captureSession addInput:deviceInput];
    }
    if ([captureSession canAddOutput:metadataOutput]){
        [captureSession addOutput:metadataOutput];
    }
    if ([captureSession canAddOutput:videoDataOutput]){
        [captureSession addOutput:videoDataOutput];
    }
    //支持的码类型，这里包括了条形码
    //这里有个坑：设置types必须在session add了这个output之后
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    //5.初始化预览流
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [controller.view.layer insertSublayer:previewLayer atIndex:0];
    self.videoPreviewLayer = previewLayer;
    
    //6.开启
    [captureSession startRunning];
    
}

- (void)startScanCode {
    [self.captureSession startRunning];
}

- (void)stopScanCode {
    [self.captureSession stopRunning];
}

- (void)removeScanPreviewLayer {
    [self.videoPreviewLayer removeFromSuperlayer];
}

- (void)resetBrightnessOutput {
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
}

- (void)cancelBrightnessOutput {
    [self.videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
}

- (void)playSoundFileName:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    
}
- (void)lightJarDevice{
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [generator prepare];
    [generator impactOccurred];
}

- (void)strongJarDevice{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

//MARK: - AVCaptureVideoDataOutputSampleBufferDelegate，输出光线强度
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WXQRCodeScanManager:brightnessValue:)]){
        [self.delegate WXQRCodeScanManager:self brightnessValue:brightnessValue];
    }
}
//MARK: - AVCaptureMetadataOutputObjectsDelegate，输出扫描数据
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WXQRCodeScanManager:outputMetadataObjects:)]){
        [self.delegate WXQRCodeScanManager:self outputMetadataObjects:metadataObjects];
    }
}

@end
