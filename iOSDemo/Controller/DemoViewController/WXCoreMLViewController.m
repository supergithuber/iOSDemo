//
//  WXCoreMLViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/3/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXCoreMLViewController.h"
#import "UIImage+Scale.h"
#import "UIImage+Convert.h"
#import <CoreML/CoreML.h>
#import "GoogLeNetPlaces.h"

@interface WXCoreMLViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIButton *albumButton;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation WXCoreMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setupView {
    UIButton *openAlbum = [UIButton buttonWithType: UIButtonTypeCustom];
    openAlbum.frame = CGRectMake(20, 80, 200, 40);
    [openAlbum setBackgroundColor:[UIColor redColor]];
    [openAlbum setTitle:@"打开相册" forState:UIControlStateNormal];
    [openAlbum addTarget:self action:@selector(openAlbum:) forControlEvents:UIControlEventTouchUpInside];
    self.albumButton = openAlbum;
    [self.view addSubview:openAlbum];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 130, 300, 300)];
    [imageView setBackgroundColor:[UIColor lightTextColor]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
}

- (void)openAlbum:(UIButton *)sender {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:YES completion:nil];
}
//不使用vision，只使用coreML
- (void)analyseImageWithoutVision:(UIImage *)image{
    if (image == nil) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //1. 转换到输入指定的224大小
        UIImage *scaleImage = [image scaleToSize:CGSizeMake(224, 224)];
        //2. 转换成CVPixelBufferRef对象
        CVPixelBufferRef pixelBuffer = [scaleImage convertToPixelBufferRef];
        //3. GoogLeNetPlaces
        NSError *error = nil;
        GoogLeNetPlacesOutput *output = [[[GoogLeNetPlaces alloc] init] predictionFromSceneImage:pixelBuffer error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self LogToResultTextView:[NSString stringWithFormat:@"%@", output.sceneLabelProbs]];
        });
        
    });
    
}

//使用vision+coreML
- (void)analysisImageWithVision:(UIImage *)image {
    if (image == nil) return;
}

//MARK: - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.imageView.image = image;
    [self analyseImageWithoutVision:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
