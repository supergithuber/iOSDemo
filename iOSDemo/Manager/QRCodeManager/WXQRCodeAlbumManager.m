//
//  WXQRCodeAlbumManager.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/24.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXQRCodeAlbumManager.h"
#import <Photos/Photos.h>

@interface WXQRCodeAlbumManager()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIViewController *currentViewController;

@end

@implementation WXQRCodeAlbumManager

static WXQRCodeAlbumManager *_instance;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

- (void)openAlbumPickerViewController:(UIViewController *)currentViewController{
    self.currentViewController = currentViewController;
    
    NSAssert(currentViewController != nil, @"controller can not be nil");
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){
                self.isAuthorizedPhoto = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self openImagePickerViewController];
                });
            }else{
                NSLog(@"拒绝访问相册");
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized){
        self.isAuthorizedPhoto = YES;
        [self openImagePickerViewController];
    }else if (status == PHAuthorizationStatusDenied){
        NSLog(@"请去设置打开相册权限");
    }else if (status == PHAuthorizationStatusRestricted){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于系统原因, 无法访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self.currentViewController presentViewController:alertC animated:YES completion:nil];
    }
}
- (void)openImagePickerViewController{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self.currentViewController presentViewController:controller animated:YES completion:nil];
}

//MARK: delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WXQRCodeAlbumManagerDidCancelPickPhoto:)]){
        [self.delegate WXQRCodeAlbumManagerDidCancelPickPhoto:self];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *originImage = info[UIImagePickerControllerOriginalImage];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:originImage.CGImage]];
    
    if (features.count == 0){
        if (self.delegate && [self.delegate respondsToSelector:@selector(WXQRCodeAlbumManagerDidReadFailed:)]){
            [self.delegate WXQRCodeAlbumManagerDidReadFailed:self];
        }
    }
}
@end
