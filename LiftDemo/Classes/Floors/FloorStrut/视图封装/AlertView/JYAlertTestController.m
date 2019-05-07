//
//  JYAlertTestController.m
//  LiftDemo
//
//  Created by apple on 2019/3/29.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYAlertTestController.h"
#import "SLAlertView.h"
#import "JYActionSheet.h"
#import "JYCustomAlert.h"
#import "JYCustomAleartVC.h"

@interface JYAlertTestController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * subTitles;

@end

@implementation JYAlertTestController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = Rect(0, SafeAreaTopHeight, kScreenWidth, kScreenHeight - SafeAreaBottomHeight);
}

- (void)setupInitializeData {
    self.titles = @[@"actionSheet",@"actionSheet根据内容",@"alert3",@"alert4",@"custom",@"modalPresentVC"];
    self.subTitles = @[@"仿wx-actionsheet",@"超过最大高度滑动",@"alert3--",@"alert4--",@"keywindow 弹出 customview--",@"present 透明控制器"];
    [self.tableView reloadData];
}

///  初始化子控件
- (void)setupSubViews {

}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"Alert";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - UI
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark - Actions
- (void)actionAlertWithIndex:(NSInteger)index {
    
    NSArray *options = @[@"1",@"2"];
    NSString *cancelStr = @"取消";
    NSString *sureStr = @"确定";
    NSString *titleStr = @"标题";
    NSString *msg = @"-----msg-----";
    if (index == 0) {
        [SLAlertView alertViewWithTitle:titleStr cancelBtn:cancelStr destructiveButton:nil otherButtons:options clickAtIndex:^(NSInteger buttonIndex) {
            SLLog(buttonIndex);
            NSString *tip = [NSString stringWithFormat:@"选中%zd",buttonIndex];
            SVShowSuccess(tip);
        }];
    }
    if (index == 1) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 2; i ++) {
            JYSheetModel *model = [JYSheetModel new];
            model.title = [NSString stringWithFormat:@"---------%d---------",i];
            [array addObject:model];
        }
        [JYActionSheet actionSheetWithTip:@"选择" cancel:@"取消" options:array selectedIndex:^(NSInteger index) {
            
        }];
    }
    if (index == 2) {
        [UIAlertView alertWithTitle:titleStr message:msg cancelButtonTitle:cancelStr OtherButtonsArray:options clickAtIndex:^(NSInteger buttonIndex) {
            NSString *tip = [NSString stringWithFormat:@"选中%zd",buttonIndex];
            SVShowSuccess(tip);
        }];
    }
    if (index == 3) {
        [UIAlertView alertWithTitle:titleStr message:msg cancelButtonTitle:cancelStr OtherButtonsArray:@[sureStr] clickAtIndex:^(NSInteger buttonIndex) {
            NSString *tip = [NSString stringWithFormat:@"选中%zd",buttonIndex];
            SVShowSuccess(tip);
        }];
    }
    if (index == 4) {
        UIView *view = [UIView viewWithBgColor:[UIColor whiteColor] frame:Rect(0, 0, Fit(320), 300)];
        UILabel *tlabel = [UILabel labelWithText:@"customview" font:14 textColor:[UIColor blackColor] frame:Rect(0, 0, view.width, view.height)];
        tlabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:tlabel];
        [JYCustomAlert alertWithCustomView:view touchBack:YES eventHandle:^(id  _Nullable obj) {
            
        }];
    }
    if (index == 5) {
        //present
        UIView *view = [UIView viewWithBgColor:[UIColor whiteColor] frame:Rect(0, 0, Fit(320), 300)];
        UILabel *tlabel = [UILabel labelWithText:@"present customview" font:14 textColor:[UIColor blackColor] frame:Rect(0, 0, view.width, view.height)];
        tlabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:tlabel];
        
        JYCustomAleartVC *vc = [[JYCustomAleartVC alloc] init];
        vc.touchBack = YES;
        vc.customView = view;
        vc.customView.center = vc.view.center;
        float version = [UIDevice currentDevice].systemVersion.floatValue;
        if (version < 8.0) {
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self.view.window.rootViewController presentViewController:vc animated:YES completion:^{
            }];
        } else {
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
        
    }
    
    
}


#pragma mark - Networking

#pragma mark - Delegate

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"alertcellid"];
    cell.textLabel.text = self.titles[indexPath.section];
    cell.detailTextLabel.text = self.subTitles[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self actionAlertWithIndex:indexPath.section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView viewWithBgColor:[UIColor groupTableViewBackgroundColor] frame:Rect(0, 0, kScreenWidth, 10)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
