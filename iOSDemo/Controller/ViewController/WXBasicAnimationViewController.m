//
//  WXBasicAnimationViewController.m
//  iOSDemo
//
//  Created by HFY on 2019/7/18.
//  Copyright © 2019 Wuxi. All rights reserved.
//

#import "WXBasicAnimationViewController.h"
#import "WXBasicAnimationTool.h"

@interface WXBasicAnimationViewController ()

@property (nonatomic, strong)UIView *redView;
@property (nonatomic, strong)UIView *secondRedView;

@end

@implementation WXBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(50, 100, 80, 80);
    redView.layer.backgroundColor = [UIColor redColor].CGColor;
    _redView = redView;
    
    UIView *secondRedView = [[UIView alloc] init];
    secondRedView.frame = CGRectMake(280, 100, 80, 80);
    secondRedView.layer.backgroundColor = [UIColor redColor].CGColor;
    _secondRedView = secondRedView;
    
    [self.view addSubview:redView];
    [self.view addSubview:secondRedView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRedView:)];
    [redView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondTapRedView:)];
    [secondRedView addGestureRecognizer:secondTap];
}


- (void)tapRedView:(UITapGestureRecognizer *)tapGesture{
    
    [[WXBasicAnimationTool sharedInstance] startAnimationandView:self.redView
                                                         andRect:self.redView.frame
                                                   andFinisnRect:CGRectMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-100, 20, 20)
                                                  andFinishBlock:^(BOOL finish) {
                                                      
                                                  }];
}

- (void)secondTapRedView:(UITapGestureRecognizer *)tapGesture{
    [[WXBasicAnimationTool sharedInstance] startAnimationandView:self.secondRedView
                                                         andRect:self.secondRedView.frame
                                                   andFinisnRect:CGRectMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-100, 20, 20)
                                                  andFinishBlock:^(BOOL finish) {
                                                      
                                                  }];
}
@end
