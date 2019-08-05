//
//  WXMenuAction.h
//  Demo
//
//  Created by Sivanwu on 2019/5/28.
//  Copyright © 2019年 HFY All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMenuAction : NSObject
@property (nonatomic, readonly) NSString      *title;
@property (nonatomic, readonly) UIImage       *image;
@property (nonatomic, readonly) UIImage       *highlightImage;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)BOOL isHighlighted;
@property (nonatomic,copy, readonly) void (^handler)(WXMenuAction *action, NSInteger index);
+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                 highlightImage:(UIImage *)highlightImage
                          count:(NSInteger)count
                        handler:(void (^)(WXMenuAction *, NSInteger))handler;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
