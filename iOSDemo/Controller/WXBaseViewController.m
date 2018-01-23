//
//  WXBaseViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXBaseViewController.h"
#import <Masonry/Masonry.h>

@interface WXBaseViewController ()

@property (nonatomic, strong)UITextView *resultTextView;

@end

@implementation WXBaseViewController

- (void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonControllerViewSet];
    [self setupTextView];
    [self setupConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonControllerViewSet{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTextView{
    self.resultTextView = [[UITextView alloc] init];
    self.resultTextView.backgroundColor = [UIColor yellowColor];
    self.resultTextView.alpha = 0.5;
    self.resultTextView.textColor = [UIColor blueColor];
    [self.resultTextView setEditable:NO];
    self.resultTextView.font = [UIFont systemFontOfSize:12];
    self.resultTextView.text = @"shake to appear or disappear myself";
    [self.view addSubview:self.resultTextView];
    
}
- (void)setupConstraints{
    [self.resultTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(100);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)LogToResultTextView:(NSString *)string{
    NSLog(@"%@", string);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableString * beforString = [self.resultTextView.text mutableCopy];
        [beforString appendFormat:@"\n%@", string];
        self.resultTextView.text = [beforString copy];
        [self.resultTextView scrollRangeToVisible:NSMakeRange([self.resultTextView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding], 1)];
    });
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake){
        self.resultTextView.hidden = !self.resultTextView.hidden;
    }else{
        [super motionBegan:motion withEvent:event];
    }
}
@end
