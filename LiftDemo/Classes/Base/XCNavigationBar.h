//
//  XCNavigationBar.h
//  XinCai
//
//  Created by Lostifor on 16/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  navigationBar


#import <Foundation/Foundation.h>

@class XCNavigationBar;
@protocol XCNavigationBarDelegate <NSObject>
@optional
- (void)navigationBar:(XCNavigationBar *)nav didClickButtonAtIndex:(NSInteger)index;
@end

@interface XCNavigationBar : UIView
///  标题Label
@property (nonatomic,   weak) UILabel * titleLabel;
///  右侧按钮
@property (nonatomic,   weak) UIButton * rightButton;

@property (nonatomic,   weak) UIButton * leftButton;

@property (nonatomic,   weak) UIView * diveder;

///  设置成白色主题
- (void)setupToWhiteTheme;

///  只有标题
///
///  @param title 标题
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title;

///  只有标题和返回键
///
///  @param title      标题
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                  backAction:(void(^)(void))backAction;


/// 标题 + 右边item(图片或文字都行)（没有返回按钮）
/// @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                   rightItem:(NSString *)rightItem
                 rightAction:(void(^)(void))action;


///  标题 + 右边item(图片或文字都行) + 返回按钮
///
///  @param title      标题
///  @param rightItem  右侧图片/文字
///  @param action     右侧点击事件
///  @param backAction 返回事件
///
///  @return 导航栏
+ (instancetype)navWithTitle:(NSString *)title
                   rightItem:(NSString *)rightItem
                 rightAction:(void(^)(void))action
                  backAction:(void(^)(void))backAction;

/// 删除分隔线
- (void)removeDivider;

@end


@interface UIViewController (NavigationBar)

@property (nonatomic, strong) XCNavigationBar * xc_navgationBar;

@end
