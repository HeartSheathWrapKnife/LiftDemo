//
//  NSAttributedString+Adaptive.m
//  XunChangApp
//
//  Created by Eleven on 16/9/20.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "NSAttributedString+Adaptive.h"

@implementation NSAttributedString (Adaptive)

+ (NSMutableAttributedString *)attrForText:(NSString *)text color:(UIColor *)color font:(CGFloat)font {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                              NSForegroundColorAttributeName:color} range:NSMakeRange(0, text.length)];
    return attr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
                                                   number:(NSString *)number
                                                   color1:(UIColor *)color1
                                                    font1:(CGFloat)font1
                                                   color2:(UIColor *)color2
                                                    font2:(CGFloat)font2 {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font2],
                          NSForegroundColorAttributeName:color2} range:NSMakeRange(0, string.length)];
    NSRange range = [string rangeOfString:number];
    [attributed addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font2],
                                NSForegroundColorAttributeName:color1} range:range];
    
    return attributed;
}

@end
