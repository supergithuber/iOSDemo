//
//  WXVolumeButtonHandler.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/18.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXVolumeButtonHandler.h"

@interface WXVolumeButtonHandler()

@property (nonatomic, copy)WXVolumnButtonBlock upBlock;
@property (nonatomic, copy)WXVolumnButtonBlock downBlock;

@end

@implementation WXVolumeButtonHandler

//MARK: - init
- (instancetype)initWithUpBlock:(WXVolumnButtonBlock)upBlock downBlock:(WXVolumnButtonBlock)downBlock {
    if (self = [super init]){
        _upBlock = upBlock;
        _downBlock = downBlock;
    }
    return self;
}

+ (instancetype)volumnButtonHandlerWithUpBlock:(WXVolumnButtonBlock)upBlock downBlock:(WXVolumnButtonBlock)downBlock {
    return [[WXVolumeButtonHandler alloc] initWithUpBlock:upBlock downBlock:downBlock];
}

@end
