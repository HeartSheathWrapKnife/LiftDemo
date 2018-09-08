//
//  AppDelegate.h
//  LiftDemo
//
//  Created by Lostifor on 2018/8/21.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 第一次完成安装回调
@property (nonatomic,   copy) void (^didFinishedFirstLaunchBlock)();

@end

