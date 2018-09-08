//
//  NSString+Property.m
//  RideMoto
//
//  Created by Eleven on 17/1/17.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "NSString+Property.h"
#import <objc/runtime.h>

static NSString * const kIDKey = @"idKey";

@implementation NSString (Property)

- (void)setID:(NSString *)ID {
    objc_setAssociatedObject(self, &kIDKey, ID, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)ID {
    return objc_getAssociatedObject(self, &kIDKey);;
}

@end
