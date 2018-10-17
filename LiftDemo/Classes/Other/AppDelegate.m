//
//  AppDelegate.m
//  LiftDemo
//
//  Created by Lostifor on 2018/8/21.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "GuideController.h"
#import "IQKeyboardManager.h"
#import "BackGroundMaskView.h"
#import "BackGroundCustomMask.h"

@interface AppDelegate ()
@property (nonatomic,   weak) UIView *bgMask;//多任务缩略图模糊遮罩
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [User configUser];
    
    [self _setupRootVC];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    //    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    //    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    //    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

    return YES;
}

- (BOOL)_setupRootVC {
    NSString * key = @"_isFirstLaunchApp";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [defaults objectForKey:key];
    if (!num) {
        num = @(YES);
        [defaults setObject:num forKey:key];
    }
    BOOL y = [User sharedUser].isLogin;
    
    if (num.boolValue) {
        self.window.rootViewController = [GuideController new];
    } else {
//        if (y) { // 已登录
            MainViewController * main = [[MainViewController alloc] init];
            self.window.rootViewController = main;
//        } else { // 未登录
//            self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[LoginViewController new]];
//        }
        
    }
    
    
    //        MainViewController * main = [MainViewController new];
    //        self.window.rootViewController = main;
    //        if ([User sharedUser].isLogin == NO) {
    //            LoginViewController * controller = [[LoginViewController alloc] init];
    //            [self.window.rootViewController presentViewController:[BaseNavigationController navWithRootViewController:controller] animated:YES completion:nil];
    //        }
    return [num boolValue];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    SLLog(@"background");
    //后台模式遮罩层 多任务缩略图
    if (USER.backGroundMaskType != 0) {
        if (USER.backGroundMaskType == 1) {//模糊当前截图模式
            BackGroundMaskView *view = [[BackGroundMaskView alloc] initWithFrame:self.window.frame];
            self.bgMask = view;
            //添加mask视图
            for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
                if (window.windowLevel == UIWindowLevelNormal) {
                    [window addSubview:self.bgMask];
                }
            }
        } else {//(USER.backGroundMaskType == 2) //显示自定义视图
            UIView *view = [BackGroundCustomMask creatViewFromNib];
            view.frame = self.window.frame;
            self.bgMask = view;
            //添加mask视图
            for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
                if (window.windowLevel == UIWindowLevelNormal) {
                    [window addSubview:self.bgMask];
                }
            }
        }
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    SLLog(@"enterforeground");
    //移除 多任务缩略图模糊
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [self.bgMask removeFromSuperview];
        }
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
