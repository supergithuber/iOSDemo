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
#import <Vision/Vision.h>
#import "GoogLeNetPlaces.h"

@interface WXCoreMLViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIButton *albumButton;
@property (nonatomic, strong)UIButton *coreMLButton;
@property (nonatomic, strong)UIButton *visionButton;
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
    openAlbum.frame = CGRectMake(20, 80, 100, 40);
    [openAlbum setBackgroundColor:[UIColor redColor]];
    [openAlbum setTitle:@"打开相册" forState:UIControlStateNormal];
    [openAlbum addTarget:self action:@selector(openAlbum:) forControlEvents:UIControlEventTouchUpInside];
    self.albumButton = openAlbum;
    [self.view addSubview:openAlbum];
    
    UIButton *coreMLButton = [UIButton buttonWithType:UIButtonTypeCustom];
    coreMLButton.frame = CGRectMake(120, 80, 100, 40);
    [coreMLButton setBackgroundColor:[UIColor blueColor]];
    [coreMLButton setTitle:@"coreML" forState:UIControlStateNormal];
    [coreMLButton addTarget:self action:@selector(analyseImageWithoutVision:) forControlEvents:UIControlEventTouchUpInside];
    self.coreMLButton = coreMLButton;
    [self.view addSubview:coreMLButton];
    
    UIButton *visionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visionButton.frame = CGRectMake(220, 80, 100, 40);
    [visionButton setBackgroundColor:[UIColor blackColor]];
    [visionButton setTitle:@"vision" forState:UIControlStateNormal];
    [visionButton addTarget:self action:@selector(analysisImageWithVision:) forControlEvents:UIControlEventTouchUpInside];
    self.visionButton = visionButton;
    [self.view addSubview:visionButton];
    
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
- (void)analyseImageWithoutVision:(UIButton *)button{
    UIImage *image = self.imageView.image;
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
            if (error){
                [self LogToResultTextView:[NSString stringWithFormat:@"识别出错%@", error]];
            }else{
                NSString *label = output.sceneLabel;
                NSNumber *probability = output.sceneLabelProbs[label];
                [self LogToResultTextView:[NSString stringWithFormat:@"最有可能%@，可能性%@", label, probability]];
            }
        });
        
    });
    
}
//https://developer.apple.com/documentation/vision/classifying_images_with_vision_and_core_ml?language=objc
//使用vision+coreML
- (void)analysisImageWithVision:(UIButton *)button {
    UIImage *image = self.imageView.image;
    if (image == nil) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MLModel *model = [[[GoogLeNetPlaces alloc] init] model];
        
        NSError *error = nil;
        VNCoreMLModel *visionModel = [VNCoreMLModel modelForMLModel:model error:&error];
        WS(weakSelf);
        if (error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self LogToResultTextView:[NSString stringWithFormat:@"转换模型出错%@", error]];
            });
        }else {
            VNCoreMLRequest *request = [[VNCoreMLRequest alloc] initWithModel:visionModel completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
                if (error){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf LogToResultTextView:[NSString stringWithFormat:@"识别失败%@", error]];
                        return;
                    });
                }else {
                    NSArray<VNClassificationObservation *> *result = request.results;
                    VNClassificationObservation *observation = [result firstObject];
                    NSString *resultObject = [observation identifier];
                    VNConfidence probability = [observation confidence];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self LogToResultTextView:[NSString stringWithFormat:@"最有可能%@，可能性%f", resultObject, probability]];
                    });
                }
            }];
            VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image.CGImage options:@{}];
            [handler performRequests:@[request] error:&error];
        }
    });
    
    
}

//MARK: - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
