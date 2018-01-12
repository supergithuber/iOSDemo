//
//  WXConcurrentOperation.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXConcurrentOperation.h"

@interface WXConcurrentOperation ()

@property (nonatomic, assign)BOOL isExecuting;
@property (nonatomic, assign)BOOL isFinished;

@end

@implementation WXConcurrentOperation

- (instancetype)init{
    self = [super init];
    if (self){
        
    }
    return self;
}
- (void)main{
    
}

- (BOOL)performOperation:(NSOperation *)operation{
    return YES;
}


@end
