//
//  MineViewController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/3.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()
///<UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic,   weak) UITableView * tableView;

@end

@implementation MineViewController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

///  初始化子控件
- (void)setupSubViews {
    //    UITableView * tableView = [[UITableView alloc] initWithFrame:Rect(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    //    tableView.delegate = self;
    //    tableView.dataSource = self;
    //    tableView.backgroundColor = [UIColor clearColor];
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self.view addSubview:tableView];
    //    self.tableView = tableView;
}

///  设置自定义导航条
- (void)setupNavigationBar {
    NSString * title = @"Mine";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title];
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
