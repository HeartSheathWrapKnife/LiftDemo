//
//  NSString+Time.h
//  XunChangApp
//
//  Created by Eleven on 16/9/13.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

/** 时间格式2016-09-12 20:09:28 --> 2016.09.12 20:09:28 */
+ (NSString *)standardFormatTimeWithString:(NSString *)string;

+ (NSString *)formatTime:(NSString *)string deleteFirstLength:(NSInteger)length;
+ (NSString *)formatTime:(NSString *)string deleteLastLength:(NSInteger)length;

+ (NSString *)formatChineseTime:(NSString *)string deleteLastLength:(NSInteger)length;

/** 时间格式2016-09-12 --> 9.12 */
+ (NSString *)formatTimeWithString:(NSString *)string;

@end
