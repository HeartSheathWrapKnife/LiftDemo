//
//  FloorModel.h
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloorModel : NSObject
//控制器名
@property (nonatomic,   copy) NSString * className;
//标题
@property (nonatomic,   copy) NSString * title;
//详情描述
@property (nonatomic,   copy) NSString * desc;
//详情控制器
@property (nonatomic, assign) Class descVC;
//显示单元
+ (FloorModel *)modelWithTitle:(NSString *)title
                          desc:(NSString *)desc
                     className:(NSString *)className;

@end
