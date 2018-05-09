//
//  UIButton+CountDown.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/9.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 这个倒计时可以用在很多地方，功能和view都可以，一分钟内，具体时间可以去源码里调整
 根据需求自己改改代码
 
 @param seconds 倒计时秒数
 @param waittingTitle 在等待时的显示
 @param finishTitle 在等待结束时的显示
 */
- (void)wx_countDownSeconds:(NSUInteger)seconds
              waittingTitle:(NSString *)waittingTitle
                finishTitle:(NSString *)finishTitle;

@end
