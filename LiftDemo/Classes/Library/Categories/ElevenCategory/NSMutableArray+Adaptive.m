//
//  NSMutableArray+Adaptive.m
//  XunChangApp
//
//  Created by Eleven on 16/9/8.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "NSMutableArray+Adaptive.h"

@implementation NSMutableArray (Adaptive)

- (NSString *)arrayToStringWithCharacter:(NSString *)character {
    if (self.count) {
        NSMutableString *strM = [NSMutableString string];
        for (NSString *str in self) {
            [strM appendString:[NSString stringWithFormat:@"%@%@",str,character]];
        }
        [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
        return strM;
    } else {
        return @"";
    }
}

@end
