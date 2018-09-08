//
//  NSDictionary+Json.m
//  RideMoto
//
//  Created by Eleven on 17/3/1.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

@end
