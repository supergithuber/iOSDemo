//
//  HUMCrashHelper.h
//  Insta360Pro
//
//  Created by Wuxi on 2019/4/2.
//  Copyright © 2019年 Insta360. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXCrashHelper : NSObject

+ (NSString *)getMainExecutableBinaryImageUUID;

@end

NS_ASSUME_NONNULL_END
