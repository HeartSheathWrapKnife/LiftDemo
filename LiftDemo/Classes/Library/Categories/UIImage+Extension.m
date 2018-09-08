//
//  UIImage+Extension.h
//
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 Seven Lv All rights reserved.
//  UIImage分类

#import "UIImage+Extension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Extension)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
//    CGFloat w = normal.size.width * 0.5;
//    CGFloat h = normal.size.height * 0.5;
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.75;
    CGFloat h2 = normal.size.height * 0.25;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h2, w)];
}

+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)captureWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGFloat)fitHeight:(CGFloat)h {
    CGSize size = self.size;
    return size.width * h / size.height;
}

- (CGFloat)fitWidth:(CGFloat)w {
    CGSize size = self.size;
    return size.height * w / size.width;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)rm_imageNamed:(NSString *)name {
    UIImage * image = [self imageNamed:name];
    if (!name) return nil;
    CGFloat width = image.size.width;
    CGFloat height=  image.size.height;
    if (width == height) return image;
    
    CGFloat max = MAX(width, height);
    CGRect rect = CGRectMake(0, 0, max, max);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextAddRect(context, rect);
    CGRect r = CGRectZero;
    if (width > height) {
        r = (CGRect){{0, (width - height) / 2.0}, image.size};
    } else {
        r = (CGRect){{(height - width) / 2.0, 0}, image.size};
    }
    [image drawInRect:r];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors size:(CGSize)size separatedDirection:(SeparatedDirection)dir {
    
    if (!colors.count) return nil;
    CGRect rect = (CGRect){{0, 0}, size};
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (dir) {
        case SeparatedDirectionVertical: {
            CGFloat width = rect.size.width / colors.count;
            for (int i = 0; i < colors.count; i++) {
                UIColor * color = colors[i];
                CGContextSetFillColorWithColor(context, color.CGColor);
                CGContextFillRect(context, CGRectMake(i * width, 0, width, rect.size.height));
            }
        }
            break;
            
        case SeparatedDirationHorizontal:{
            CGFloat height = rect.size.height / colors.count;
            for (int i = 0; i < colors.count; i++) {
                UIColor * color = colors[i];
                CGContextSetFillColorWithColor(context, color.CGColor);
                CGContextFillRect(context, CGRectMake(0, i * height, size.width, height));
            }
        }
            break;
            
        default:
            break;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


////////////////////gif

+ (UIImage *)imageWithGIFData:(NSData *)data

{
    
    if (!data) return nil;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        
        animatedImage = [[UIImage alloc] initWithData:data];
        
    } else {
        
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            // 拿出了Gif的每一帧图片
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            //Learning... 设置动画时长 算出每一帧显示的时长(帧时长)
            
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            
            duration += frameDuration;
            
            // 将每帧图片添加到数组中
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            // 释放真图片对象
            
            CFRelease(image);
            
        }
        
        // 设置动画时长
        
        if (!duration) {
            
            duration = (1.0f / 10.0f) * count;
            
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
        
    }
    
    // 释放源Gif图片
    
    CFRelease(source);
    
    return animatedImage;
    
}

+ (UIImage *)imageWithGIFNamed:(NSString *)name

{
    
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    
    return [self GIFName:name scale:scale];
    
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale

{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    
    if (!imagePath) {
        
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
        
    }
    
    if (imagePath) {
        
        // 传入图片名(不包含@Nx)
        
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        
        return [UIImage imageWithGIFData:imageData];
        
    } else {
        
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        if (imagePath) {
            
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            
            return [UIImage imageWithGIFData:imageData];
            
        } else {
            
            // 不是一张GIF图片(后缀不是gif)
            
            return [UIImage imageNamed:name];
            
        }
        
    }
    
}

+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock

{
    
    NSURL *GIFUrl = [NSURL URLWithString:url];
    
    if (!GIFUrl) return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *CIFData = [NSData dataWithContentsOfURL:GIFUrl];
        
        // 刷新UI在主线程
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            gifImageBlock([UIImage imageWithGIFData:CIFData]);
            
        });
        
    });
    
}

#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    
    if (delayTimeUnclampedProp) {
        
        frameDuration = [delayTimeUnclampedProp floatValue];
        
    }
    
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        
        if (delayTimeProp) {
            
            frameDuration = [delayTimeProp floatValue];
            
        }
        
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    
    // a duration of <= 10 ms. See and
    
    // for more information.
    
    if (frameDuration < 0.011f) {
        
        frameDuration = 0.100f;
        
    }
    
    CFRelease(cfFrameProperties);
    
    return frameDuration;
    
}
@end
