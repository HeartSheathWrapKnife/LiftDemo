//
//  BaseNavigationController.h
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  base nav

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

+ (instancetype)navWithRootViewController:(UIViewController *)vc;

@end
