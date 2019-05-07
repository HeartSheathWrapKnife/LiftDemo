//
//  FloorsController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "FloorsController.h"
#import "FloorCell.h"
#import "FloorModel.h"
#import "FloorRoomsController.h"


@interface FloorsController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,   weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray <FloorModel *>* dataArr;
@end

@implementation FloorsController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}
///  初始化列表数据
- (void)setupInitializeData {
    NSArray * sections = @[@"视图封装",@"动画",@"绘图与手势",@"蓝牙",@"传感器",@"demo",@"Tools"];
    for (int i = 0 ; i < sections.count; i ++) {
        FloorModel *model = [FloorModel new];
        model.title = sections[i];
        [self.dataArr addObject:model];
    }
}

///  初始化子控件
- (void)setupSubViews {
    UITableView * tableView = [[UITableView alloc] initWithFrame:Rect(0, SafeAreaTopHeight, kScreenWidth, ScreenHeight - SafeAreaTopHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

///  设置自定义导航条
- (void)setupNavigationBar {
    NSString * title = @"floors";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title];
}

#pragma mark - Actions


#pragma mark - Networking

#pragma mark - Delegate

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FloorCell *cell = [FloorCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FloorRoomsController * controller = [[FloorRoomsController alloc] init];
    controller.sectionName = self.dataArr[indexPath.row].title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter

- (NSMutableArray<FloorModel *> *)dataArr {
    JYLazyMutableArray(_dataArr);
}
@end
