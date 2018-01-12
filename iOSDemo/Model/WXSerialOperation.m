//
//  WXConcurrentOperation.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSerialOperation.h"

@implementation WXSerialOperation

- (void)main{
    //如果是在其他线程，是无法访问主线程的autoreleasepool
    NSLog(@"concurrent operation begin");
    @try {
        BOOL isFinished = NO;
        while (!isFinished && ![self isCancelled]) {
            sleep(5); //休息5秒
            NSLog(@"current thread - %@", [NSThread currentThread]);
            isFinished = YES;
        }
    }
    
    @catch (NSException * e){
        NSLog(@"Exception: %@", e);
    }
    NSLog(@"concurrent operation end");
}
@end
