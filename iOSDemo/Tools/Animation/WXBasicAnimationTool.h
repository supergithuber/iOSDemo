//
//  WXBasicAnimationTool.h
//  iOSDemo
//
//  Created by Wuxi on 2019/7/18.
//  Copyright © 2019 Wuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AnimationFinisnBlock)(BOOL);

NS_ASSUME_NONNULL_BEGIN

@interface WXBasicAnimationTool : NSObject

+ (instancetype)sharedInstance;

/**
 抛物线函数

 @param view 动画的view
 @param rect view的frame
 @param finishRect 结束点
 @param completion 结束回调
 */
- (void)startAnimationandView:(UIView *)view
                      andRect:(CGRect)rect
                andFinisnRect:(CGRect)finishRect
               andFinishBlock:(AnimationFinisnBlock)completion;

@end

NS_ASSUME_NONNULL_END
