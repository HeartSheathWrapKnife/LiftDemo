//
//  DBManager.m
//  LiftDemo
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "DBManager.h"
#define kArchiver_DBManager        @"kArchiver_DBManager"

@implementation DBManager

+ (instancetype)sharedManager {
    static DBManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [JYUtils unArchiveObjectWithIdentifier:kArchiver_DBManager];
        if(!manage){
            manage = [[DBManager alloc] init];
        }
    });
    return manage;
}

+ (void)save {
    [JYUtils archiveObject:[DBManager sharedManager] archiveIdentifier:kArchiver_DBManager];
}

+ (void)clean {
//    [DBManager sharedManager].rechargeData = nil;
    [DBManager save];
}

@end
