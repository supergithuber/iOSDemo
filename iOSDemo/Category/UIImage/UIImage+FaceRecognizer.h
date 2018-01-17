//
//  UIImage+FaceRecognizer.h
//  iOSDemo
//
//  Created by 吴浠 on 2018/1/17.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FaceRecognizer)

/**

 @return 使用CIDetector识别，返回图片中人脸的个数
 */
- (NSInteger)totalNumberOfFacesByFaceRecognition;

/**

 @return 返回人脸的框，如果有多个人脸，返回它们的union
 */
- (CGRect)rectOfFace;
@end
