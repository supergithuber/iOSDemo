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

@property (nonatomic, strong)NSCondition *condition;
@property (nonatomic, strong)NSMutableArray *conditionArray;

@property (nonatomic, strong)NSConditionLock *conditionLock;

@end

@implementation WXLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
//MARK: NSRecursiveLock
- (void)wx_recursiveLock:(int)value{
    [self.recursiveLock lock];
    if (value != 0){
        --value;
        NSLog(@"当前的value:%i", value);
        [self wx_recursiveLock:value];
    }
    [self.recursiveLock unlock];
}
//MARK: semaphore
- (void)wx_semaphore{
    //参考SemaphoreViewController
}
//MARK: semaphore
- (void)wx_condition{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.conditionLock lock];
        while (self.conditionArray.count == 0) {
            [self.condition wait]; //在等待其他线程来的信号
            
        }
        [self.conditionArray removeObjectAtIndex:0];
        [self.conditionLock unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.conditionLock lock];
        [self.conditionArray addObject:[NSObject new]];
        NSLog(@"添加了一个东西");
        [self.condition signal];  //通知其他线程
        [self.conditionLock unlock];
    });
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
- (NSCondition *)condition{
    if (_condition){
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}
- (NSMutableArray *)conditionArray{
    if (_conditionArray){
        _conditionArray = [NSMutableArray array];
    }
    return _conditionArray;
}
- (NSConditionLock *)conditionLock{
    if (_conditionLock){
        _conditionLock = [[NSConditionLock alloc] init];
    }
    return _conditionLock;
}

@end
