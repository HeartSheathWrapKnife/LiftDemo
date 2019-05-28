//
//  DBManager.h
//  LiftDemo
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : JYObject
+ (instancetype)sharedManager;
+ (void)save;
+ (void)clean;

@end

NS_ASSUME_NONNULL_END
