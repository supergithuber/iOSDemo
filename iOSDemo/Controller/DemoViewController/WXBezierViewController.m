//
//  WXBezierViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/3/5.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXBezierViewController.h"

@interface WXBezierViewController ()

@end

@implementation WXBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawLine];
    [self drawShape];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawLine{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(20, 120)];
    [linePath addLineToPoint:CGPointMake(120, 120)];
    [linePath addLineToPoint:CGPointMake(70, 180)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = linePath.CGPath;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = nil;
    
    [self.view.layer addSublayer:shapeLayer];//带上颜色
//    self.view.layer.mask = shapeLayer;
    
}
- (void)drawShape{
    
}
@end
