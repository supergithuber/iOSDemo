//
//  WXCyclicScrollLabel.h
//  iOSDemo
//
//  Created by 吴浠 on 2018/3/15.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WXScrollType){
    WXScrollTypeLeftRight = 0,
    WXScrollTypeUpDown,
    WXScrollTypeFlipRepeat,
    WXScrollTypeFlipNoRepeat
};
@class WXCyclicScrollLabel;

@protocol WXCyclicScrollLabelDelegate <NSObject>
@optional
- (void)scrollLabel:(WXCyclicScrollLabel *)scrollLabel didClickWithText:(NSString *)text atIndex:(NSInteger)index;
@end

@interface WXCyclicScrollLabel : UIScrollView

@property (nonatomic, assign)WXScrollType scrollType;
@property (nonatomic, weak)id<WXCyclicScrollLabelDelegate> scrollLabelDelegate;

@property (nonatomic, strong)UIFont *scrollTextFont;
@property (nonatomic, assign)NSTextAlignment textAliment;

@property (nonatomic, assign)CGFloat scrollVelocity; //越大越慢，就是定时器的timeInterval 【0.1， 5】
@property (nonatomic, copy) NSString *scrollTitle;
@property (nonatomic, strong)UIColor *scrollTitleColor;

@property (assign, nonatomic)UIEdgeInsets scrollInsets;
//循环滚动的间距
@property (assign, nonatomic) CGFloat scrollSpace;
//初始化
+ (instancetype)scrollLabelWithTitle:(NSString *)title
                                type:(WXScrollType)type
                            velocity:(CGFloat)velocity
                             options:(UIViewAnimationOptions)animationOptions
                                font:(UIFont *)font
                        scrolllSpace:(CGFloat)scrollSpace
                              insets:(UIEdgeInsets)insets;

//开始滚动
- (void)beginScrolling;
//结束滚动
- (void)endScrolling;

@end
