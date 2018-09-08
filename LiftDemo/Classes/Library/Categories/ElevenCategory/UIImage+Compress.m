//
//  UIImage+Compress.m
//  KCWC
//
//  Created by Eleven on 2017/4/18.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)

- (UIImage *)compressionImageToDataTargetWidth:(CGFloat)targetWidth maxFileSize:(NSInteger)maxFileSize {
    if (targetWidth <= 0) {
        targetWidth = 1024;
    }
    
    //缩
    CGSize newSize = CGSizeMake(self.size.width, self.size.height);
    CGFloat tempHeight = newSize.height / targetWidth;
    CGFloat tempWidth = newSize.width / targetWidth;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(self.size.width / tempWidth, self.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(self.size.width / tempHeight, self.size.height / tempHeight);
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //压
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
    while (imageData.length / 1000 > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

- (UIImage *)compressImageToScaleSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)compressImageToScaleWidth:(CGFloat)newwidth {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat newHeight = newwidth * height / width;
    return [self compressImageToScaleSize:CGSizeMake(newwidth, newHeight)];
}

- (NSData *)compressToData {
    if (self.size.width < 640) {
        return UIImageJPEGRepresentation(self, 0.9);
    }
    // 将图片尺寸缩到640 * xxx, `xxx`由图片自身高度决定
    UIImage * image = [self compressImageToScaleWidth:640];
    return UIImageJPEGRepresentation(image, 0.9);
}

@end
