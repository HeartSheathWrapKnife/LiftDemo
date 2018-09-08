//
//  BaseViewController.h
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCNavigationBar.h"

@interface BaseViewController : UIViewController <XCNavigationBarDelegate>

@property (nonatomic, copy) void (^vBlock)();

///  设置初始化数据
- (void)setupInitializeData;
///  初始化子控件
- (void)setupSubViews;
///  设置自定义导航条
- (void)setupNavigationBar;
///  设置状态栏颜色
- (void)setStatusBarSytle:(BOOL)isLight;

//- (void)didClickButtonAtIndex:(NSInteger)index;

extern void makePhoneCall(NSString *phone);

@end
