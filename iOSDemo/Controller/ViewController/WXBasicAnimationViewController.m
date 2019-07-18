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

@end

@implementation WXBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 50, 50);
    redView.layer.backgroundColor = [UIColor redColor].CGColor;
    _redView = redView;
    [self.view addSubview:redView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRedView:)];
    [redView addGestureRecognizer:tap];
}


- (void)tapRedView:(UITapGestureRecognizer *)tapGesture{
    [[WXBasicAnimationTool sharedInstance] startAnimationandView:self.redView
                                                         andRect:self.redView.frame
                                                   andFinisnRect:CGPointMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 50)
                                                  andFinishBlock:^(BOOL finish) {
                                                      
                                                  }];
}


@end
