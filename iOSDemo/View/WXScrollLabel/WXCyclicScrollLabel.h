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

@property (nonatomic, strong)UIFont *font;
@property (nonatomic, assign)NSTextAlignment textAliment;
@property (nonatomic, assign)CGFloat scrollVelocity;
@property (nonatomic, copy) NSString *scrollTitle;
@property (assign, nonatomic)UIEdgeInsets scrollInsets;
//开始滚动
- (void)beginScrolling;
//结束滚动
- (void)endScrolling;

@end
