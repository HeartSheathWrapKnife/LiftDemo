//
//  GestureLockShowController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "GestureLockShowController.h"

@interface GestureLockShowController ()
///<UITableViewDelegate, UITableViewDataSource>
//@property (nonatomic,   weak) UITableView * tableView;

@end

@implementation GestureLockShowController

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
    UIButton *button = [UIButton buttonWithTitle:@"创建手势密码" titleColor:[UIColor blueColor] backgroundColor:[UIColor grayColor] font:14 image:nil frame:Rect(50, 120, 120, 40)];
    [button addTarget:self action:@selector(creatGestureLockPwd)];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithTitle:@"验证手势密码" titleColor:[UIColor blueColor] backgroundColor:[UIColor grayColor] font:14 image:nil frame:Rect(50, button.maxY + 10, 120, 40)];
    [button1 addTarget:self action:@selector(checkGestureLock)];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithTitle:@"删除手势密码" titleColor:[UIColor blueColor] backgroundColor:[UIColor grayColor] font:14 image:nil frame:Rect(50, button1.maxY + 10, 120, 40)];
    [button2 addTarget:self action:@selector(deleteGestureLock)];
    [self.view addSubview:button2];
}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"手势解锁";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Actions

/**
 创建手势密码
 */
- (void)creatGestureLockPwd {
    ZLGestureLockViewController *vc = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeCreatePsw];
    //创建成功block
    vc.createGestureSuccess = ^{
        SVShowSuccess(@"创建成功");
    };
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 检测手势密码
 */
- (void)checkGestureLock {
    NSString *pwd = [ZLGestureLockViewController gesturesPassword];
    if (!pwd.length) {
        SVShowError(@"未创建手势密码");
    } else {
        ZLGestureLockViewController *vc = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeValidatePsw];
        vc.validateGestureSuccess = ^{
            SVShowSuccess(@"验证成功了撒");
        };
        [self presentViewController:vc animated:YES completion:nil];
    }

}

/**
 删除手势密码
 */
- (void)deleteGestureLock {
    NSString *pwd = [ZLGestureLockViewController gesturesPassword];
    if (!pwd.length) {
        SVShowError(@"未创建手势密码");
    } else {
        [ZLGestureLockViewController deleteGesturesPassword];
        SVShowSuccess(@"删除成功");
    }
    
}

#pragma mark - Networking

#pragma mark - Delegate


#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
