//
//  NSString+Adaptive.h
//  XunChangApp
//
//  Created by Eleven on 16/8/31.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Adaptive)

/** 计算字符串宽度 */
+ (CGSize)calculateSizeWithString:(NSString *)string font:(CGFloat)font;
/** 计算字符串高度 */
+ (CGFloat)calculateStringHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)font;

@end
