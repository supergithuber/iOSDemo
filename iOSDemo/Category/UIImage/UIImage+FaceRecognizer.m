//
//  UIImage+FaceRecognizer.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/1/17.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIImage+FaceRecognizer.h"

@implementation UIImage (FaceRecognizer)

- (NSInteger)totalNumberOfFacesByFaceRecognition{
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:self.CGImage];
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    
    return detectResult.count;
}

- (CGRect)rectOfFace
{
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:self.CGImage];
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    CGRect faceRects = CGRectZero;
    if (detectResult.count == 0)
    {
        return CGRectNull;
    }
    faceRects = ((CIFaceFeature*)[detectResult objectAtIndex:0]).bounds;
    for (CIFaceFeature* faceFeature in detectResult) {
        faceRects = CGRectUnion(faceRects, faceFeature.bounds);
    }
    return faceRects;
}
@end
