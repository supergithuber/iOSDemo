//
//  UIImage+Convert.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/3.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "UIImage+Convert.h"

@implementation UIImage (Convert)

//let frameSize = CGSize(width: image.width, height: image.height)
//
//var pixelBuffer:CVPixelBuffer? = nil
//let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
//
//if status != kCVReturnSuccess {
//    return nil
//
//}
//
//CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
//let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
//let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
//let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
//
//
//context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
//
//CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//
//return pixelBuffer
@end
