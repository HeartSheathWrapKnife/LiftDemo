//
//  UINavigationController+StatusBarStyle.h
//  XinCai
//
//  Created by Lostifor on 2017/11/13.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//只要UIViewController重写的childViewControllerForStatusBarStyle返回值不是nil，那么UIViewcontroller的
//preferredStatusBarStyle方法不会被系统的Container（NavigationController或者UITabBarController）调用，而
//是调用childViewControllerForStatusBarStyle返回的UIViewController的preferredStatusBarStyle来控制
//StatuBar的颜色

#import <UIKit/UIKit.h>

@interface UINavigationController (StatusBarStyle)

@end
