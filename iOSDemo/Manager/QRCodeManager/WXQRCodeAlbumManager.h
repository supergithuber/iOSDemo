//
//  WXQRCodeAlbumManager.h
//  iOSDemo
//
//  Created by wuxi on 2018/2/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXQRCodeAlbumManager;
@protocol WXQRCodeAlbumDelegate<NSObject>
//不选择图片
- (void)WXQRCodeAlbumManagerDidCancelPickPhoto:(WXQRCodeAlbumManager *)manager;
//读到二维码信息
- (void)WXQRCodeAlbumManager:(WXQRCodeAlbumManager *)manager resultString:(NSString *)resultString;
//读取二维码信息失败
- (void)WXQRCodeAlbumManagerDidReadFailed:(WXQRCodeAlbumManager *)manager;
@end

@interface WXQRCodeAlbumManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak)id<WXQRCodeAlbumDelegate> delegate;
@property (nonatomic, assign)BOOL isAuthorizedPhoto;
//打开相册
- (void)openAlbumPickerViewController:(UIViewController *)currentViewController;

@end
