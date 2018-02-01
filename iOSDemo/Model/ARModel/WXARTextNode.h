//
//  WXARTextNode.h
//  iOSDemo
//
//  Created by wuxi on 2018/2/1.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface WXARTextNode : SCNNode

- (instancetype)initWithDistance:(CGFloat)distance scnText:(SCNText *)scnText scnView:(SCNView *)scnView scale:(CGFloat)scale;

@end
