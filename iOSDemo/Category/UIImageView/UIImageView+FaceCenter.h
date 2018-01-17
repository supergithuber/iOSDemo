//
//  UIImageView+FaceCenter.h
//  iOSDemo
//
//  Created by 吴浠 on 2018/1/17.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FaceCenter)

/**
 *  首先识别头像，然后使得头像居中摆放
 */
- (void) faceAwareFill;


/**
 @param rect 使指定的rect居中摆放
 */
- (void)faceAwareFillWithRect:(CGRect)rect;


@end
