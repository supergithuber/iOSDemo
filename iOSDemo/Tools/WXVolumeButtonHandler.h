//
//  WXVolumeButtonHandler.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/18.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WXVolumeButtonBlock)(void);
@interface WXVolumeButtonHandler : NSObject

- (instancetype)initWithUpBlock:(WXVolumeButtonBlock)upBlock downBlock:(WXVolumeButtonBlock)downBlock;
+ (instancetype)volumnButtonHandlerWithUpBlock:(WXVolumeButtonBlock)upBlock downBlock:(WXVolumeButtonBlock)downBlock;

@end
