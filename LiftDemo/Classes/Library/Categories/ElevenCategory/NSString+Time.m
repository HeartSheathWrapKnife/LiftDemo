//
//  NSString+Time.m
//  XunChangApp
//
//  Created by Eleven on 16/9/13.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+ (NSString *)standardFormatTimeWithString:(NSString *)string {
    if (string == nil || [string isEqualToString:@""]) {
        return @"";
    } else {
        NSMutableString *timeStr = [NSMutableString stringWithString:string];
        if ([string rangeOfString:@"-"].location != NSNotFound) {
            NSArray *arr = [timeStr componentsSeparatedByString:@"-"];
            timeStr = @"".mutableCopy;
            for (NSString *str in arr) {
                [timeStr appendString:[NSString stringWithFormat:@"%@.",str]];
            }
            [timeStr deleteCharactersInRange:NSMakeRange(timeStr.length - 1, 1)];
        }
        return timeStr;
    }
}

+ (NSString *)formatTime:(NSString *)string deleteFirstLength:(NSInteger)length {
    if (string == nil || [string isEqualToString:@""]) {
        return @"";
    } else {
        NSMutableString *timeStr = [self standardFormatTimeWithString:string].mutableCopy;
        [timeStr deleteCharactersInRange:NSMakeRange(0, length)];
        return timeStr;
    }
}

+ (NSString *)formatTime:(NSString *)string deleteLastLength:(NSInteger)length; {
    if (string == nil || [string isEqualToString:@""]) {
        return @"";
    } else {
        NSMutableString *timeStr = [self standardFormatTimeWithString:string].mutableCopy;
        [timeStr deleteCharactersInRange:NSMakeRange(timeStr.length - length, length)];
        return timeStr;
    }
}

+ (NSString *)formatChineseTime:(NSString *)string deleteLastLength:(NSInteger)length {
    if (string == nil || [string isEqualToString:@""]) {
        return @"";
    } else {
        NSMutableString *timeStr = [self standardFormatTimeWithString:string].mutableCopy;
        [timeStr deleteCharactersInRange:NSMakeRange(timeStr.length - length, length)];

        [timeStr replaceCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        [timeStr replaceCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        [timeStr insertString:@"日" atIndex:10];
        return timeStr;
    }
}

+ (NSString *)formatTimeWithString:(NSString *)string {
    NSString *str = [NSString formatTime:[NSString formatTime:string deleteFirstLength:5] deleteLastLength:9];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    NSMutableString *timeStr = [NSMutableString string];
    for (NSString *s in arr) {
        if ([s hasPrefix:@"0"]) {
            NSMutableString *strM = [NSMutableString stringWithString:s];
            [strM deleteCharactersInRange:NSMakeRange(0, 1)];
            [timeStr appendString:[NSString stringWithFormat:@"%@.",strM]];
        } else {
            [timeStr appendString:[NSString stringWithFormat:@"%@.",s]];
        }
    }
    [timeStr deleteCharactersInRange:NSMakeRange(timeStr.length - 1, 1)];
    return timeStr;
}

@end
