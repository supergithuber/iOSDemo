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
    [self drawOvalInRect];
    [self getOvalOfRect];
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
    
    [self.view.layer addSublayer:shapeLayer];//这样会带上颜色
//    self.view.layer.mask = shapeLayer;
    
}
- (void)drawShape{
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    linePath.lineCapStyle = kCGLineCapRound;
    linePath.lineJoinStyle = kCGLineJoinRound;
    [linePath moveToPoint:CGPointMake(200, 120)];
    [linePath addLineToPoint:CGPointMake(300, 120)];
    [linePath addLineToPoint:CGPointMake(250, 180)];
    [linePath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = linePath.CGPath;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = nil;
    
    [self.view.layer addSublayer:shapeLayer];
}
- (void)drawOvalInRect{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 320, 150, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 8;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = nil;
    
    [view.layer addSublayer:shapeLayer];
}
- (void)getOvalOfRect{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 320, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = nil;
    
    view.layer.mask = shapeLayer;
}
@end
