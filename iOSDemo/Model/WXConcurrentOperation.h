//
//  WXConcurrentOperation.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
start: 所有并行的 Operations 都必须重写这个方法，然后在你想要执行的线程中手动调用这个方法。注意：任何时候都不能调用父类的start方法。
main: 在start方法中调用，但是注意要定义独立的自动释放池与别的线程区分开。
isExecuting: 是否执行中，需要实现KVO通知机制。
isFinished: 是否已完成，需要实现KVO通知机制。
isConcurrent: 该方法现在已经由isAsynchronous方法代替，并且 NSOperationQueue 也已经忽略这个方法的值。
isAsynchronous: 该方法默认返回 NO ，表示非并发执行。并发执行需要自定义并且返回 YES。后面会根据这个返回值来决定是否并发。
*/
@interface WXConcurrentOperation : NSOperation

- (BOOL)performOperation:(NSOperation *)operation;

@end
