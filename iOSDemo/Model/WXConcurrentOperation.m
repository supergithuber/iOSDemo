//
//  WXConcurrentOperation.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXConcurrentOperation.h"

@interface WXConcurrentOperation (){
    BOOL executing;
    BOOL finished;
}
@end

@implementation WXConcurrentOperation

- (instancetype)init{
    self = [super init];
    if (self){
        executing = NO;
        finished = NO;
    }
    return self;
}
- (void)main{
    NSLog(@"并行线程开始");
    @try{
        //无法访问主线程的自动释放池，这里用完后也需要销毁
        @autoreleasepool{
            BOOL isFinished = NO;
            while (!isFinished && ![self isCancelled]) {
                sleep(5);
                NSLog(@"当前线程%@", [NSThread currentThread]);
                isFinished = YES;
            }
            
        }
    }
    @catch (NSException *e){
        NSLog(@"并行线程出错 - %@", e);
    }
    NSLog(@"并行线程结束");
}

- (void)start{
    //先问问有没有取消
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    //调用main，比较关键
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}
//外部需要调用的函数
- (BOOL)performOperation:(NSOperation *)operation{
    BOOL everRun = NO;
    if ([operation isCancelled]){
        [self willChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        
        executing = NO;
        finished = YES;
        
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        everRun = YES;
    }else if ([operation isReady]){
        if([operation isAsynchronous]){
            //异步的
            [NSThread detachNewThreadSelector:@selector(start) toTarget:operation withObject:nil];
        }else{
            //同步的就直接start
            [operation start];
        }
        everRun = YES;
    }
    return everRun;
}
- (void)completeOperation{
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

//MARK: - private
- (BOOL)isFinished{
    return finished;
}
- (BOOL)isExecuting{
    return executing;
}
- (BOOL)isAsynchronous{
    return YES;
}
@end
