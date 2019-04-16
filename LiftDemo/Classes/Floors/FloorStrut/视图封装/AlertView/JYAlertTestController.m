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
    self.titles = @[@"alert1",@"alert2",@"alert3",@"alert4",@"custom",@"modalPresentVC"];
    self.subTitles = @[@"alert1--",@"alert2--",@"alert3--",@"alert4--",@"custom--",@"present 透明控制器"];
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
    NSArray *longOptions = @[@"1",@"2",@"3",@"4",@"2",@"3",@"4",@"2",@"3",@"4"];
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
        [JYActionSheet actionSheetWithTip:titleStr cancel:cancelStr options:longOptions selectedIndex:^(NSInteger index) {
            NSString *tip = [NSString stringWithFormat:@"选中%zd",index];
            SVShowSuccess(tip);
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
        UIView *view = [UIView viewWithBgColor:[UIColor redColor] frame:Rect(0, 0, Fit(320), 300)];
        
        [JYCustomAlert alertWithCustomView:view Handle:^(id  _Nullable obj) {
            
        }];
    }
    if (index == 5) {
        //present
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        float version = [UIDevice currentDevice].systemVersion.floatValue;
        if (version < 8.0) {
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self.view.window.rootViewController presentViewController:vc animated:NO completion:^{
            }];
        } else {
            vc.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
            
            [self presentViewController:vc animated:NO completion:^{
                
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
