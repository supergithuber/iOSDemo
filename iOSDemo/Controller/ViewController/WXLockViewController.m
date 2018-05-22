//
//  WXLockViewController.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXLockViewController.h"

@interface WXLockViewController ()

@property (nonatomic, strong)NSLock *lock;

@end

@implementation WXLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: NSLock
- (void)wx_lockUsage{
    [self.lock lock];
    //do something
    
    [self.lock unlock];
}

- (NSLock *)lock{
    if (_lock){
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}
@end
