//
//  UIImage+Extension.h
//
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 Seven Lv All rights reserved.
//  UIImage分类

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SeparatedDirection) {
    SeparatedDirationHorizontal = 0,
    SeparatedDirectionVertical,
};

typedef void (^GIFimageBlock)(UIImage *GIFImage);

@interface UIImage (Extension)
/**
 *  拉伸图片:(传入一张图片,返回一张可随意拉伸的图片)
 *
 *  @param name 图片名
 */
+ (UIImage *)resizableImage:(NSString *)name;
/**
 *  为图片加相框
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  截图
 *
 *  @param view 需要截图的View
 */
+ (instancetype)captureWithView:(UIView *)view;

/**
 *  旋转图片
 *
 *  @param degrees 角度(正数为顺时针，负数为逆时针)
 *
 *  @return 旋转之后的图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


///  给定宽度或高度，根据自己的高度比算高度
- (CGFloat)fitWidth:(CGFloat)w;
- (CGFloat)fitHeight:(CGFloat)h;

/**
 用颜色生成一张图片

 @param color 颜色
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 用一组颜色拼接生成一张组合图片

 @param colors 颜色值
 @param size 图片最终大小
 @param dir 颜色分割方向
 @return 图片
 */
+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size separatedDirection:(SeparatedDirection)dir;

/**
 生成一张以原图最长边大小的正方形图片，内容居中
 如果原图是正方形，直接返回原图
 @param name 图片名
 @return 图片
 */
+ (UIImage *)rm_imageNamed:(NSString *)name;


//gif图片

/** 根据本地GIF图片名 获得GIF image对象 */

+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */

+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */

+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;

@end


