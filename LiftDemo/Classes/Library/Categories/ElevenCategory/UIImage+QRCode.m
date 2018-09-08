//
//  UIImage+QRCode.m
//  RideMoto
//
//  Created by Eleven on 17/1/3.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "UIImage+QRCode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (QRCode)

+ (UIImage *)creatQRCodeWithData:(NSString *)dataStr imageViewWidth:(CGFloat)size {
    // 1.创建过滤器 -- 苹果没有将这个字符封装成常量
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.过滤器恢复默认设置
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *image = [filter outputImage];
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}

+ (UIImage *)creatBarCodeWithData:(NSString *)dataStr imageViewSize:(CGSize)size; {
    if (!dataStr.length) {
        return nil;
    } else {
        // 生成条形码图片
//        CIImage *barcodeImage;
        NSData *data = [dataStr dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
        CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [filter setValue:data forKey:@"inputMessage"];
        //设置条形码颜色和背景颜色
        CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
        [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
        //条形码颜色
    //    UIColor *color = nil;
    //    UIColor *backGroundColor = nil;
    //    if (color == nil) {
    //        color = [UIColor blackColor];
    //    }
    //    if (backGroundColor == nil) {
    //        backGroundColor = [UIColor whiteColor];
    //    }
    //    [colorFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //    //背景颜色
    //    [colorFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    //    
    //    barcodeImage = [colorFilter outputImage];
    //    
    //    // 消除模糊
    //    CGFloat scaleX = size.width / barcodeImage.extent.size.width; // extent 返回图片的frame
    //    CGFloat scaleY = size.height / barcodeImage.extent.size.height;
    //    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    //    
    //    return [UIImage imageWithCIImage:transformedImage];
        
        // 设置生成的条形码的上，下，左，右的margins的值
        [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
        return [UIImage imageWithCIImage:filter.outputImage];
    }
}

@end
