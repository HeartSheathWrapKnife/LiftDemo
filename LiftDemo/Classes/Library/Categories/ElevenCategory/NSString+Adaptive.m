//
//  NSString+Adaptive.m
//  XunChangApp
//
//  Created by Eleven on 16/8/31.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "NSString+Adaptive.h"

@implementation NSString (Adaptive)

+ (CGSize)calculateSizeWithString:(NSString *)string font:(CGFloat)font {
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:font]
                     constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                         lineBreakMode:NSLineBreakByWordWrapping];
    
    return size;
}

+ (CGFloat)calculateStringHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)font {
    CGFloat height = [title boundingRectWithSize:CGSizeMake(width, 2000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    return height;
}

@end
