//
//  MainViewController.h
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController

@end


@interface RMTabBar : UITabBar

///  点击加号
@property (nonatomic,   copy) void (^didClickPlusBtnBlock)();

@end
