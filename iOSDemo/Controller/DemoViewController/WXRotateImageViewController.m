//
//  WXRotateImageViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/25.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXRotateImageViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "UIImage+Color.h"

@interface WXRotateImageViewController ()

@property (nonatomic, strong)CMMotionManager *motionManager;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation WXRotateImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImageView];
    [self staticImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupImageView{
    CGFloat width = 100;
    CGPoint center = self.view.center;
    CGRect rect = CGRectMake(center.x - width, center.y - width, width * 2, width * 2);
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor redColor]]];
    self.imageView.frame = rect;
    [self.view addSubview:self.imageView];
}
- (void)staticImageView{
    //这里用陀螺仪数据，也可以用加速计
    if (self.motionManager.isGyroAvailable){
        self.motionManager.gyroUpdateInterval = 0.1f;
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            double rotation = atan2(gyroData.rotationRate.x, gyroData.rotationRate.y) - M_PI;
            self.imageView.transform = CGAffineTransformMakeRotation(rotation);
        }];
    }
}
//MARK: - 两种获取加速计数据的方式

- (void)pullToGetAccelerateData{
    if (self.motionManager.accelerometerAvailable){
        //设置加速计多久采样一次
        self.motionManager.accelerometerUpdateInterval = 0.1;
        //开始更新，后台线程开始运行。这是Pull方式
        [self.motionManager startAccelerometerUpdates];
        //接下来，可以获得陀螺仪数据
        
    }
}
//这个比pull更消耗性能
- (void)pushToGetAccelerateData{
    if (self.motionManager.accelerometerAvailable){
        self.motionManager.accelerometerUpdateInterval = 0.1;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSLog(@"X = %f,Y = %f,Z = %f",self.motionManager.accelerometerData.acceleration.x,self.motionManager.accelerometerData.acceleration.y,self.motionManager.accelerometerData.acceleration.z);
        }];
    }
}
//MARK: - 获取陀螺仪数据
- (void)getGyroDate{
    if (self.motionManager.gyroActive){
        self.motionManager.gyroUpdateInterval = 0.1;
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
        }];
    }
}
//MARK: - 获取磁力计数据
- (void)Magnetometer{
    //1.判断磁力计是否可用
    if (![self.motionManager isMagnetometerAvailable]) {
        return;
    }
    //2.设置采样间隔
    self.motionManager.magnetometerUpdateInterval =1.0;
    //3开始获取
    [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        CMMagneticField filed = magnetometerData.magneticField;
        NSLog(@"磁力计 %f,%f,%f",filed.x,filed.y,filed.z);
    }];
    
}
- (CMMotionManager *)motionManager{
    if (!_motionManager){
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
@end
