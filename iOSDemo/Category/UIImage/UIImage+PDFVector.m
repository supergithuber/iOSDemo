//
//  UIImage+PDFVector.m
//  iOSDemo
//
//  Created by Wuxi on 2018/10/30.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIImage+PDFVector.h"

@implementation UIImage (PDFVector)

+ (UIImage *)wx_vectorImageWithName:(NSString *)imageName size:(CGSize)size{
    return [self wx_vectorImageWithName:imageName size:size stretch:NO];
}

+ (UIImage *)wx_vectorImageWithName:(NSString *)imageName size:(CGSize)size stretch:(BOOL)stretch{
    if (![[imageName pathExtension] isEqualToString:@"pdf"]) {
        imageName = [imageName stringByAppendingString:@".pdf"];
    }
    NSString *path = [NSBundle.mainBundle pathForResource:imageName ofType:nil];
    NSAssert(path, @"can't not find this image");
    if (!path) return nil;
    return [self wx_vectorImageWithPath:[NSURL fileURLWithPath:path] size:size stretch:stretch page:1];
}

+ (UIImage *)wx_vectorImageWithPath:(NSURL *)imagePath size:(CGSize)size stretch:(BOOL)stretch page:(NSUInteger)page{
    
    CGFloat screenScale = UIScreen.mainScreen.scale;
    // PDF源文件
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)imagePath);
    // PDF中的一页
    CGPDFPageRef imagePage = CGPDFDocumentGetPage(pdfRef, page);
    // PDF这一页显示出来的 CGRect
    CGRect pdfRect = CGPDFPageGetBoxRect(imagePage, kCGPDFCropBox);
    CGSize contextSize = (size.width <= 0 || size.height <= 0) ? pdfRect.size : size;
    
    // RGB 颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 位图上下文
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 contextSize.width * screenScale,
                                                 contextSize.height * screenScale,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    // 坐标缩放，增加清晰度
    CGContextScaleCTM(context, screenScale, screenScale);
    if (size.width > 0 && size.height > 0) {
        // 指定图片大小，需要缩放图片
        // 计算宽高缩放比
        CGFloat widthScale = size.width / pdfRect.size.width;
        CGFloat heightScale = size.height / pdfRect.size.height;
        if (!stretch) {
            // 保持原图宽高比
            heightScale = MIN(widthScale, heightScale);
            widthScale = heightScale;
            // 坐标平移，使图片居中
            CGFloat currentRatio = size.width / size.height;
            CGFloat realRatio = pdfRect.size.width / pdfRect.size.height;
            if (currentRatio < realRatio) {
                CGContextTranslateCTM(context, 0, (size.height - size.width / realRatio) / 2);
            } else {
                CGContextTranslateCTM(context, (size.width - size.height * realRatio) / 2, 0);
            }
        }
        // 用以上宽高缩放比缩放坐标
        CGContextScaleCTM(context, widthScale, heightScale);
    }else{
        // 使用原图大小
        // 获取原图坐标转换矩阵，用于位图上下文
        CGAffineTransform drawingTransform = CGPDFPageGetDrawingTransform(imagePage, kCGPDFCropBox, pdfRect, 0, true);
        CGContextConcatCTM(context, drawingTransform);
    }
    // 把 PDF 中的一页绘制到位图
    CGContextDrawPDFPage(context, imagePage);
    CGPDFDocumentRelease(pdfRef);
    // 创建 UIImage
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *pdfImage = [[UIImage alloc] initWithCGImage:image scale:screenScale orientation:UIImageOrientationUp];
    CGImageRelease(image);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return pdfImage;
}
@end
