//
//  WXBaseViewController.h
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXBaseViewController : UIViewController

//在这个页面，以及它的子类，都有一个控制台，可以用于打印到手机上可以看到
//摇一摇出现或者消失
- (void)LogToResultTextView:(NSString *)string;

@end
