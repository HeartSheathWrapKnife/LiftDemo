//
//  HallController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/3.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "HallController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"

@interface HallController ()

@end

@implementation HallController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

///  初始化子控件
- (void)setupSubViews {
    
    
    //按钮  上图+下文 margin 间隔
    float btnW = (kScreenWidth - 2) / 4.;
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithTitle:@"title" titleColor:HexColor(0x333333) backgroundColor:[UIColor clearColor] font:14 image:@"酷" frame:CGRectMake(btnW*i, 120, btnW, 80)];
        [UIButton setBtnMidleStyle:button margin:3];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            SLLog(@"click");
        }];
        [self.view addSubview:button];
    }
}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"hall";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - Actions


#pragma mark - Networking



#pragma mark - Delegate

//#pragma mark UITableViewDelegate & UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  return nil;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}
//


#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
