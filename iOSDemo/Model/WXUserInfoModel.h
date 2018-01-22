//
//  WXUserInfoModel.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

//使用runtime来序列化和反序列化的一个object demo
@interface WXUserInfoModel : NSObject<NSCoding>

@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)NSInteger *age;
@property (nonatomic, copy)NSString *country;
@property (nonatomic, assign)NSInteger phoneNumber;

@end
