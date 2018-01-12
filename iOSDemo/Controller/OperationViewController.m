//
//  OperationViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBlockOperation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - NSInvocationOperation
- (void)createInvocationOperation{
    //在没有使用NSOperationQueue、单独使用NSInvocationOperation的情况下，NSInvocationOperation在主线程执行操作，并没有开启新线程
    NSInvocationOperation * operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationFunction) object:nil];
    [operation start];
}
- (void)invocationFunction{
    //打印
    NSLog(@"you are in invocation function - %@", [NSThread currentThread]);
}

//MARK: - NSBlockOperation
- (void)createBlockOperation{
    //在没有使用NSOperationQueue、单独使用NSBlockOperation的情况下，NSBlockOperation也是在主线程执行操作
    //addExecutionBlock会在其他线程执行,可能同一个其他线程，也可能不同(也有可能是主线程)
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"you are in block - %@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"second block function - %@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"third block function - %@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"fourth block function - %@", [NSThread currentThread]);
    }];
    [operation start];
}
@end
