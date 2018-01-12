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
    
}

- (void)start{
    
}

- (BOOL)performOperation:(NSOperation *)operation{
    return YES;
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
