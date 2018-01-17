//
//  UIImageView+FaceCenter.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/1/17.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIImageView+FaceCenter.h"

static CIDetector* _faceDetector;

@implementation UIImageView (FaceCenter)

+ (void)initialize
{
    _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                       context:nil
                                       options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
}
//MARK: - public
- (void)faceAwareFill
{
    if (self.image == nil)
    {
        return;
    }
    CGRect facesRect = [self rectWithFaces];
    if (facesRect.size.height + facesRect.size.width == 0)
        return;
    self.contentMode = UIViewContentModeTopLeft;
    [self scaleImageFocusingOnRect:facesRect];
}
- (void)faceAwareFillWithRect:(CGRect)rect
{
    if (self.image == nil)
    {
        return;
    }
    if (rect.size.height + rect.size.width == 0)
        return;
    self.contentMode = UIViewContentModeTopLeft;
    [self scaleImageFocusingOnRect:rect];
}

//MARK: - tool
- (CGRect)rectWithFaces
{
    CIImage *image = self.image.CIImage;
    if (!image) {
        image = [CIImage imageWithCGImage:self.image.CGImage];
    }
    CIDetector *detector = _faceDetector;
    NSArray *features = [detector featuresInImage:image];
    CGRect totalFaceRects = CGRectZero;
    if (features.count > 0)
    {
        //第一张人脸
        totalFaceRects = ((CIFaceFeature *)[features objectAtIndex:0]).bounds;
        //所有脸取并集
        for (CIFaceFeature* faceFeature in features) {
            totalFaceRects = CGRectUnion(totalFaceRects, faceFeature.bounds);
        }
    }
    return totalFaceRects;
}
- (void)scaleImageFocusingOnRect:(CGRect) facesRect
{
    CGFloat multi1 = self.frame.size.width / self.image.size.width;
    CGFloat multi2 = self.frame.size.height / self.image.size.height;
    CGFloat multi = MAX(multi1, multi2);
    //翻转坐标系
    facesRect.origin.y = self.image.size.height - facesRect.origin.y - facesRect.size.height;
    
    facesRect = CGRectMake(facesRect.origin.x*multi, facesRect.origin.y*multi, facesRect.size.width*multi, facesRect.size.height*multi);
    
    CGRect imageRect = CGRectZero;
    imageRect.size.width = self.image.size.width * multi;
    imageRect.size.height = self.image.size.height * multi;
    imageRect.origin.x = MIN(0.0, MAX(-facesRect.origin.x + self.frame.size.width/2.0 - facesRect.size.width/2.0, -imageRect.size.width + self.frame.size.width));
    imageRect.origin.y = MIN(0.0, MAX(-facesRect.origin.y + self.frame.size.height/2.0 -facesRect.size.height/2.0, -imageRect.size.height + self.frame.size.height));
    
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 2.0);
    [self.image drawInRect:imageRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newImage;
}
@end
