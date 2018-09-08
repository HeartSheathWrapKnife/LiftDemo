//
//  GuideController.m
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "GuideController.h"
#import "MainViewController.h"
#import "AppDelegate.h"


@interface GuideController ()

@end

@implementation GuideController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubViews];
}

#pragma mark - 初始化UI

/// 初始化view
- (void)setupSubViews {
    
    UIScrollView * scrollView = [UIScrollView scrollViewWithBgColor:[UIColor whiteColor] frame:self.view.bounds];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    NSInteger count = 3;
//    BOOL is4S = ScreenHeight < 568;
    for (int i = 0; i < count; i++) {
        NSString * name = [NSString stringWithFormat:@"guide_%d", i];
//        if (is4S) {
//            [name stringByAppendingString:@"_4s"];
//        }
        UIImageView * imageView = [UIImageView imageViewWithImage:[UIImage imageNamed:name] frame:Rect(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        [scrollView addSubview:imageView];
        
//        UIView * imageView = [UIView viewWithBgColor:randomColor frame:Rect(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
//        [scrollView addSubview:imageView];
        
        if (i == count - 1) {
            UIButton * btn = [UIButton buttonWithTitle:nil titleColor:[UIColor blueColor] backgroundColor:[UIColor whiteColor] font:0 image:nil frame:Rect(0, 0, Fit(140), Fit(40))];
            btn.title = @"确定";
            btn.centerX = HalfScreenWidth;
            btn.maxY = ScreenHeight - Fit(74);
            [imageView addSubview:btn];
            imageView.userInteractionEnabled = YES;
            @weakify(self);
            [[btn rac_signalForControlEvents:64] subscribeNext:^(id x) {
                @strongify(self);
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@(NO) forKey:@"_isFirstLaunchApp"];
                [defaults synchronize];
                AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                BLOCK_SAFE_RUN(delegate.didFinishedFirstLaunchBlock);
                //切换控制器
//                self.view.window.rootViewController =[HomeViewController new];

                MainViewController * main = [[MainViewController alloc] init];
                self.view.window.rootViewController = main;
            }];
        }
        
    }
    scrollView.contentSize = Size(ScreenWidth * 3, 0);
}


@end

