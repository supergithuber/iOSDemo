//
//  WXVolumeButtonHandler.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/18.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WXVolumnButtonBlock)(void);
@interface WXVolumeButtonHandler : NSObject

- (instancetype)initWithUpBlock:(WXVolumnButtonBlock)upBlock downBlock:(WXVolumnButtonBlock)downBlock;
+ (instancetype)volumnButtonHandlerWithUpBlock:(WXVolumnButtonBlock)upBlock downBlock:(WXVolumnButtonBlock)downBlock;

@end
