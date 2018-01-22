//
//  WXUserInfoModel.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXUserInfoModel.h"
#import <objc/runtime.h>

@interface WXUserInfoModel()

@property (nonatomic, copy)NSString *familyAddress;
@property (nonatomic, assign)NSInteger cardNumber;

@end

@implementation WXUserInfoModel

//MARK: encode
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self.class, &count);
    for (int i  = 0; i< count; i++) {
        //取出Ivar
        Ivar ivar = ivarList[i];
        //属性名称  ivar_getName:获取类实例成员变量，只能取到本类的，父类的访问不到
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //归档  通过KVC取的 就没有int类型了
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    //但凡在C语言里面 看到New Creat Copy 都需要释放
    free(ivarList); //释放
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList(self.class, &count);
        
        for (int i  = 0; i< count; i++) {
            //取出Ivar
            Ivar ivar = ivarList[i];
            //属性名称
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            //解档    设置到成员变量上
            [self setValue: [aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(ivarList); //释放
    }
    return self;
}

@end
