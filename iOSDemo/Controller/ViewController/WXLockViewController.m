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
@property (nonatomic, strong)NSRecursiveLock *recursiveLock;

@end

@implementation WXLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wx_recursiveLock:5];
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

- (void)wx_recursiveLock:(int)value{
    [self.recursiveLock lock];
    if (value != 0){
        --value;
        NSLog(@"当前的value:%i", value);
        [self wx_recursiveLock:value];
    }
    [self.recursiveLock unlock];
}

//MARK: GET
- (NSLock *)lock{
    if (_lock){
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}
- (NSRecursiveLock *)recursiveLock{
    if (_recursiveLock){
        _recursiveLock = [[NSRecursiveLock alloc] init];
    }
    return _recursiveLock;
}

@end
