//
//  FloorModel.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "FloorModel.h"

@implementation FloorModel

+ (FloorModel *)modelWithTitle:(NSString *)title
                          desc:(NSString *)desc
                     className:(NSString *)className {
    FloorModel *item = [FloorModel new];
    item.title = title;
    item.desc = desc;
    item.className = className;
    if (className.length) {
        BaseViewController *vc = [[NSClassFromString(className)  alloc] init];
        if ([vc isKindOfClass:[UIViewController class]]) {
            item.descVC = [vc class];
        }
    }
    return item;
}

@end
