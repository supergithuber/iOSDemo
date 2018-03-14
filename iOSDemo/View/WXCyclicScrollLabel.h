//
//  WXCyclicScrollLabel.h
//  iOSDemo
//
//  Created by 吴浠 on 2018/3/15.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXCyclicScrollLabelDelegate <NSObject>

@end

@interface WXCyclicScrollLabel : UIScrollView

@property (nonatomic, strong)UIFont *font;
@property (nonatomic, assign)NSTextAlignment textAliment;
@property (nonatomic, assign)CGFloat scrollVelocity;

@end
