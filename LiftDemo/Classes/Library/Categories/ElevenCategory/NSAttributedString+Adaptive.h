//
//  NSAttributedString+Adaptive.h
//  XunChangApp
//
//  Created by Eleven on 16/9/20.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Adaptive)

+ (NSMutableAttributedString *)attrForText:(NSString *)text
                                     color:(UIColor *)color
                                      font:(CGFloat)font;
/**
 *  数字文本，1为数字，2为文本
 */
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
                                                   number:(NSString *)number
                                                   color1:(UIColor *)color1
                                                    font1:(CGFloat)font1
                                                   color2:(UIColor *)color2
                                                    font2:(CGFloat)font2;

@end
