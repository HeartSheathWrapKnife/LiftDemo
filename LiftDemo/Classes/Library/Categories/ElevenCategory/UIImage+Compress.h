//
//  UIImage+Compress.h
//  KCWC
//
//  Created by Eleven on 2017/4/18.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

/**
 *  图片压缩:将图片压缩成以640为宽，高度以图片自己的高度比例缩放
 *
 *  @param targetWidth    要压缩到的尺寸
 *  @param maxFileSize 最大图片数据大小
 *
 *  @return 压缩后的图片数据
 */
- (UIImage *)compressionImageToDataTargetWidth:(CGFloat)targetWidth maxFileSize:(NSInteger)maxFileSize;


- (UIImage *)compressImageToScaleWidth:(CGFloat)width;
- (UIImage *)compressImageToScaleSize:(CGSize)size;

/// 将图片压缩成以640为宽，高度以图片自己的高度比例缩放
/// 比如图片size == 1280 * 2000, 压缩之后---> 640 * 1000; size == 1280 * 1000, 压缩之后---> 640 * 500
- (NSData *)compressToData;

@end
