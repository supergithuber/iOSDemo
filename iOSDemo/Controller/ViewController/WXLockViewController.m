//
//  WXLockViewController.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXLockViewController.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>

@interface WXLockViewController ()

@property (nonatomic, strong)NSLock *lock;
@property (nonatomic, strong)NSRecursiveLock *recursiveLock;

@property (nonatomic, strong)NSCondition *condition;
@property (nonatomic, strong)NSMutableArray *conditionArray;

@property (nonatomic, strong)NSConditionLock *conditionLock;


@end

@implementation WXLockViewController{
    pthread_rwlock_t _rwLock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pthread_rwlock_init(&_rwLock, NULL);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - NSLock
- (void)wx_lockUsage{
    [self.lock lock];
    //do something
    
    [self.lock unlock];
}
//MARK: - NSRecursiveLock
- (void)wx_recursiveLock:(int)value{
    [self.recursiveLock lock];
    if (value != 0){
        --value;
        NSLog(@"当前的value:%i", value);
        [self wx_recursiveLock:value];
    }
    [self.recursiveLock unlock];
}
//MARK: - semaphore
- (void)wx_semaphore{
    //参考SemaphoreViewController
}
//MARK: - NSConditionLock
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
//MARK: - pthread_mutex
- (void)wx_pthreadMutex{
    pthread_mutex_t lock;
    pthread_mutex_init(&lock,NULL);    //初始化锁变量&lock。第二个参数为锁属性，NULL值为默认属性。
    pthread_mutex_lock(&lock);      //加锁
    
    //your code here......
    
    pthread_mutex_unlock(&lock);     //解锁
    pthread_mutex_destroy(&lock);     //使用完后释放
}
//MARK: - pthread_rwlock
//1. 当读写锁被一个线程以读模式占用的时候，写操作的其他线程会被阻塞，读操作的其他线程还可以继续进行。
//2. 当读写锁被一个线程以写模式占用的时候，写操作的其他线程会被阻塞，读操作的其他线程也被阻塞。
- (void)wx_pthreadRwlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wx_readBookWithTag:1];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wx_readBookWithTag:2];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wx_writeBook:3];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wx_writeBook:4];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wx_readBookWithTag:5];
    });
}
- (void)wx_readBookWithTag:(NSInteger)tag {
    pthread_rwlock_rdlock(&_rwLock);
    NSLog(@"%ld号开始读书", tag);
    
    NSLog(@"%ld号停止读书", tag);
    pthread_rwlock_unlock(&_rwLock);
}
- (void)wx_writeBook:(NSInteger)tag {
    pthread_rwlock_wrlock(&_rwLock);
    NSLog(@"%ld号开始写书",tag);
    
    NSLog(@"%ld号停止写书",tag);
    pthread_rwlock_unlock(&_rwLock);
}
//MARK: - OSSpinLock
- (void)wx_spinLock{
    //这个锁由于可能会造成优先级反转，不安全已经被苹果抛弃。https://blog.ibireme.com/2016/01/16/spinlock_is_unsafe_in_ios/?utm_source=tuicool&utm_medium=referral
//    OSSpinLock spinLock = OS_SPINLOCK_INIT;
//    OSSpinLockLock(&spinLock);   // 加锁
//
//    //你自己的逻辑......
//
//    OSSpinLockUnlock(&spinLock);   // 解锁
}
//MARK: - GET
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
