//
//  UIImage+Convert.h
//  iOSDemo
//
//  Created by Wuxi on 2018/5/3.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreVideo/CoreVideo.h>

@interface UIImage (Convert)

- (CVPixelBufferRef)convertToPixelBufferRef;

@end
