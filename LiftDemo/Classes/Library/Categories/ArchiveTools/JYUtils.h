//
//  JYUtils.h
//  LiftDemo
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYUtils : JYObject

+ (id)unArchiveObjectWithIdentifier:(NSString *)archiveIdentifier;

+ (BOOL)archiveObject:(id)object archiveIdentifier:(NSString *)archiveIdentifier;

+ (BOOL)removeObjectWithIdentifier:(NSString *)archiveIdentifier;

@end

NS_ASSUME_NONNULL_END
