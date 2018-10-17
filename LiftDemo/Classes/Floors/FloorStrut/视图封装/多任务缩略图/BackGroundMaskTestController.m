//
//  BackGroundMaskTestController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "BackGroundMaskTestController.h"

@interface BackGroundMaskTestController ()
///<UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic,   weak) UITableView * tableView;

@end

@implementation BackGroundMaskTestController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

///  初始化子控件
- (void)setupSubViews {
    
    UISegmentedControl *controll = [[UISegmentedControl alloc] initWithItems:@[@"无效果",@"模糊效果",@"自定义视图"]];
    [controll addTarget:self action:@selector(controllValueChange:) forControlEvents:UIControlEventValueChanged];
    controll.frame = Rect(50, 120, 0.8*ScreenWidth, 50);
    [self.view addSubview:controll];
    
    UILabel *introLable = [UILabel labelWithText:@"选择需要的显示模式(主要的设置在appdelegate里面实现,模糊效果可以在backgroundMask文件中调整，自定义页面需要自己写样式)，home键进入后台，双击home键查看多任务缩略图" font:14 textColor:[UIColor blueColor] frame:Rect(0, controll.maxY+20, ScreenWidth, 200)];
    introLable.numberOfLines = 0;
    [self.view addSubview:introLable];
}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"多任务缩略图";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Actions

/**
 值变化

 @param sender segment
 */
- (void)controllValueChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {//无效果
        USER.backGroundMaskType = 0;
    }
    if (sender.selectedSegmentIndex == 1) {//模糊
        USER.backGroundMaskType = 1;
    }
    if (sender.selectedSegmentIndex == 2) {//自定义视图
        USER.backGroundMaskType = 2;
    }
    
}

#pragma mark - Networking

#pragma mark - Delegate




#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
