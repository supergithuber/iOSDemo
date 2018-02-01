//
//  WXARText.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXARText.h"

@implementation WXARText

- (instancetype)initWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color depth:(CGFloat)depth{
    if (self = [super init]){
        self.string = string;
        self.font = font;
        self.extrusionDepth = depth;
        self.alignmentMode = kCAAlignmentCenter;
        self.truncationMode = kCATruncationMiddle;
        self.firstMaterial.doubleSided = YES;
        self.firstMaterial.diffuse.contents = color;
        self.flatness = 0.3;
    }
    return self;
}
@end
