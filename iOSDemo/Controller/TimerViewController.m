//
//  FirstViewController.m
//  iOSDemo
//
//  Created by Wuxi on 2017/10/12.
//  Copyright © 2017年 Wuxi. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic, weak)NSTimer *timer;

@end

@implementation TimerViewController

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFunction:) userInfo:nil repeats:true];
    NSLog(@"%@", self.timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerFunction:(NSTimer *)timer {
    NSLog(@"调用timerfunction");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
