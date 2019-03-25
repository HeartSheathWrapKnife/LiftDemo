//
//  FloorRoomsController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "FloorRoomsController.h"
#import "FloorCell.h"
#import "FloorModel.h"

#import "BackGroundMaskTestController.h"//多任务缩略图测试

#import "GestureLockShowController.h"//九宫格手势解锁展示

#import "MotionShowController.h"//摇一摇陀螺仪实现

#import "ResumDownloadController.h"//断点续传实现

#import "AVPlayerShowController.h"//播放器

@interface FloorRoomsController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,   weak) UITableView * tableView;
@property (nonatomic, strong) NSArray <FloorModel *>* dataArr;
@end

@implementation FloorRoomsController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

- (void)setupInitializeData {
//     NSArray * sections = @[@"视图封装",@"动画",@"绘图与手势",@"蓝牙",@"传感器",@"demo"];
    if ([self.sectionName isEqualToString:@"视图封装"]) {
        [self initDataWithUI];
    } else if ([self.sectionName isEqualToString:@"动画"]) {
        [self initDataWithCA];
    } else if ([self.sectionName isEqualToString:@"绘图与手势"]) {
        [self initDataWithGesture];
    } else if ([self.sectionName isEqualToString:@"蓝牙"]) {
        [self initDataWithBlueTooth];
    } else if ([self.sectionName isEqualToString:@"传感器"]) {
        [self initDataWithSensor];
    } else if ([self.sectionName isEqualToString:@"demo"]) {
        [self initDataWithDemo];
    } else {
        SLLog(@"??未知分类名");
    }
}

- (void)initDataWithUI {//视图

    self.dataArr = @[[FloorModel modelWithTitle:@"多任务缩略图"
                                           desc:@"显示自定义页面或模糊当前页面"
                                      className:@"BackGroundMaskTestController"]];
    
}

- (void)initDataWithCA {//动画
    
    
}

- (void)initDataWithGesture {//绘图与手势
    self.dataArr = @[[FloorModel modelWithTitle:@"手势解锁"
                                           desc:@"九宫格样式"
                                      className:@"GestureLockShowController"]];
}

- (void)initDataWithBlueTooth {//蓝牙
    
    
}

- (void)initDataWithSensor {//传感器

    self.dataArr = @[[FloorModel modelWithTitle:@"摇一摇"
                                           desc:@"陀螺仪实现，添加震动反馈演示，触发灵敏度可调"
                                      className:@"MotionShowController"]];
    
}

- (void)initDataWithDemo {//demo
    
    self.dataArr = @[[FloorModel modelWithTitle:@"断点续传实现"
                                           desc:@"使用AF实现，处理了网络变化，后台下载等情况"
                                      className:@"ResumDownloadController"],
                     [FloorModel modelWithTitle:@"AVPlayer自定UI"
                                           desc:@"自定视频播放器demo，不完善"
                                      className:@"AVPlayerShowController"],];
}



///  初始化子控件
- (void)setupSubViews {
        UITableView * tableView = [[UITableView alloc] initWithFrame:Rect(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        self.tableView = tableView;
}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"rooms";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FloorCell *cell = [FloorCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FloorModel *model = self.dataArr[indexPath.row];
    if(model.descVC){
        UIViewController *vc = [[model.descVC alloc] init];
        if ([vc isKindOfClass:[UIViewController class]]) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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


@end
