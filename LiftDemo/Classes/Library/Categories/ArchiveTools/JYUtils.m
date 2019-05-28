//
//  JYUtils.m
//  LiftDemo
//
//  Created by apple on 2019/5/28.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYUtils.h"

@implementation JYUtils

+ (NSString *)archivePath:(NSString *)identifier {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dir = [dirs firstObject];
    
    return [dir stringByAppendingString:[NSString stringWithFormat:@"/%@", identifier]];
}

+ (id)unArchiveObjectWithIdentifier:(NSString *)archiveIdentifier{
    NSString *file = [JYUtils archivePath:archiveIdentifier];
    NSLog(@"########unarchive to file:%@", file);
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

+ (BOOL)archiveObject:(id)object archiveIdentifier:(NSString *)archiveIdentifier{
    
    NSString *file = [JYUtils archivePath:archiveIdentifier];
    
    if(object != nil){
        NSLog(@"########archive to file:%@", file);
        return [NSKeyedArchiver archiveRootObject:object toFile:file];
    }
    return NO;
}

+ (BOOL)removeObjectWithIdentifier:(NSString *)archiveIdentifier{
    
    NSString *file = [JYUtils archivePath:archiveIdentifier];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:file]) {
        return [defaultManager removeItemAtPath:file error:nil];
    }
    return NO;
}

@end
