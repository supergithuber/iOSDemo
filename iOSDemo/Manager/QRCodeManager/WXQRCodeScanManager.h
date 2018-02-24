//
//  WXQRCodeManager.h
//  iOSDemo
//
//  Created by wuxi on 2018/2/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
//MARK: - WXQRCodeScanDelegate
@class WXQRCodeScanManager;
@protocol WXQRCodeScanDelegate <NSObject>

@required
//扫码的输出结果，数组中包含的都是：AVMetadataMachineReadableCodeObject若干个对象
- (void)WXQRCodeScanManager:(WXQRCodeScanManager *)manager outputMetadataObjects:(NSArray *)metadataObjects;
@optional
//输出光线强度，数值在大约在：-5~~12之间，越大越亮
- (void)WXQRCodeScanManager:(WXQRCodeScanManager *)manager brightnessValue:(CGFloat)brightness;
@end


//MARK: - WXQRCodeScanManager
@interface WXQRCodeScanManager : NSObject

@property (nonatomic, weak)id<WXQRCodeScanDelegate>delegate;

+ (instancetype)sharedInstance;
/**
 设置manager的必须属性

 @param preset 识别码预览流的分辨率
 @param controller 当前的controller，用来承载预览流
 */
- (void)setPreset:(NSString *)preset currentController:(UIViewController *)controller;

- (void)startScanCode;
- (void)stopScanCode;
//移除扫描预览流，方便在当前界面做一些其他事
- (void)removeScanPreviewLayer;

//根据预览的sampleBuffer来输出光线强度，重置了下面的代理后，可以重新输出光线强度，或者取消输出光线强度
- (void)resetBrightnessOutput;
- (void)cancelBrightnessOutput;
@end
