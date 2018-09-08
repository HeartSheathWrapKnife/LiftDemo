//
//  JYActionSheet.m
//  JYLab
//
//  Created by 李佳育 on 2017/5/7.
//  Copyright © 2017年 JY. All rights reserved.
//

#import "JYActionSheet.h"

typedef void (^SelectedBlock)(NSInteger index);
static JYActionSheet * sheet = nil;
static SelectedBlock selectedBlcok = nil;
static NSArray *dataArray = nil;
static NSInteger rowCount = 0;


//#define ScreenHeight     _getScreenHeight()
//#define ScreenWidth      _getScreenWidth()
//
//#define HexColorInt32_t(rgbValue) \
//[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]
//
//#define RGBAColor(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]//RGB alpha
//#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;


@interface JYActionSheet ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,   weak) UITableView * tableView;
@property (nonatomic,   weak) UIView * body;
@end

@implementation JYActionSheet

+ (JYActionSheet *)actionSheetWithTip:(NSString *)tip cancel:(NSString *)cancel options:(NSArray *)options selectedIndex:(void (^)(NSInteger))selectedIndex {
    if (selectedIndex) selectedBlcok = [selectedIndex copy];
    //行数
    int count = 0;
//    if (tip) count ++;
    if (options) count += options.count;
//    if (cancel) count++;
    rowCount = count;
    
    JYActionSheet *actionSheet = [[JYActionSheet alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    sheet = actionSheet;
    actionSheet.userInteractionEnabled = YES;
    actionSheet.backgroundColor = RGBAColor(0, 0, 0, 0.4);
    actionSheet.alpha = 0;
    dataArray = options;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:actionSheet];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:actionSheet action:@selector(tap)];
//    [window addGestureRecognizer:tap];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,ScreenHeight, ScreenWidth, ScreenHeight*0.618)];
    view.backgroundColor = [UIColor whiteColor];
    [actionSheet addSubview:view];
    actionSheet.body = view;
    /// 标题
    UIView *tipView = [[UIView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, 44)];
    [view addSubview:tipView];
    
    UIView * devider = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(tipView.bounds) - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    devider.backgroundColor = [UIColor lightGrayColor];
    devider.alpha = 0.2;
    [tipView addSubview:devider];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(tipView.bounds) - 0.5)];
    tipLabel.text = tip;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = [UIColor darkGrayColor];
    [tipView addSubview:tipLabel];
    
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44, ScreenWidth, CGRectGetHeight(view.bounds) - 44*2) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = YES;//显示水平滑条
    tableView.delegate = actionSheet;
    tableView.dataSource = actionSheet;
    actionSheet.tableView = tableView;
    //tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
    [view addSubview:tableView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(tableView.frame), ScreenWidth, 44);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:actionSheet action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:cancel forState:UIControlStateNormal];
    [view addSubview:cancelBtn];
    
    UIView * cDevider = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame), ScreenWidth, 0.5)];
    cDevider.backgroundColor = [UIColor lightGrayColor];
    cDevider.alpha = 0.2;
    [tipView addSubview:cDevider];
    
    [actionSheet show];
    return actionSheet;
}
#pragma mark status
- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = sheet.body.frame;
        frame.origin.y = ScreenHeight - CGRectGetHeight(sheet.body.frame);
        sheet.body.frame = frame;
        sheet.alpha = 1;
        
    } completion:nil];

    
}
- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = sheet.body.frame;
        frame.origin.y = ScreenHeight;
        sheet.body.frame = frame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [sheet removeFromSuperview];
    }];

    
}
- (void)cancelBtnAction {
    [self dismiss];
}
- (void)tap {
    [self dismiss];
    
}
#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellReuseIdentifier = @"SearchSerisesCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIView * devider = [JYActionSheet makeDiveder];
        [cell addSubview:devider];
    }
    
    
    cell.textLabel.text = dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BLOCK_SAFE_RUN(selectedBlcok,indexPath.row);
    [self dismiss];
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



/// 分割线
+ (UIView *)makeDiveder
{
    UIView * devider = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    devider.backgroundColor = [UIColor lightGrayColor];
    devider.alpha = 0.2;
    return devider;
}


/////  获取屏幕宽度
//static inline CGFloat _getScreenWidth () {
//    static CGFloat _screenWidth = 0;
//    if (_screenWidth > 0) return _screenWidth;
//    _screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
//    return _screenWidth;
//}
//
/////  获取屏幕高度
//static inline CGFloat _getScreenHeight () {
//    static CGFloat _screenHeight = 0;
//    if (_screenHeight > 0) return _screenHeight;
//    _screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
//    return _screenHeight;
//}
@end
