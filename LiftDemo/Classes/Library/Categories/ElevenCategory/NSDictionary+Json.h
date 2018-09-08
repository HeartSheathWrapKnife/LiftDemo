//
//  NSDictionary+Json.h
//  RideMoto
//
//  Created by Eleven on 17/3/1.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
