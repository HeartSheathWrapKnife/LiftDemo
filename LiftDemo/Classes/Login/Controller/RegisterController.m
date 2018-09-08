//
//  RegisterController.m
//  XinCai
//
//  Created by Lostifor on 25/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()
@property (nonatomic,   weak) UITextField * passwordField;
@property (nonatomic,   weak) UITextField * rePasswordField;
@property (nonatomic,   weak) UITextField * accountField;
@property (nonatomic,   weak) UITextField * phoneField;
@property (nonatomic,   weak) UITextField * verifyField;
@property (nonatomic,   weak) UIButton * getVerifyBtn;
@end

@implementation RegisterController {
    UIScrollView * _scrollView;
    UIButton * _selectBtn;
    UIView * _line;
    
    RACDisposable * _dis;
    UIButton * _rightBtn;
    
}

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

///  初始化子控件
- (void)setupSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView * scrollView = [UIScrollView scrollViewWithBgColor:nil frame:Rect(0, 64, kScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.scrollEnabled = NO;
    
    UIView * view = [UIView viewWithBgColor:nil frame:Rect(0, 0, kScreenWidth, scrollView.height)];
    [scrollView addSubview:view];
    
    UIView * d1 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(0, 0, kScreenWidth, 0.5)];
    [view addSubview:d1];
    
    UIView * d2 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d1.maxY + 44, kScreenWidth - 30, 0.5)];
    [view addSubview:d2];
    
    UIView * d3 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d2.maxY + 44, kScreenWidth - 30, 0.5)];
    [view addSubview:d3];
    
    UIView * d4 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d3.maxY + 44, kScreenWidth - 30, 0.5)];
    [view addSubview:d4];
    
    UIView * d5 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d4.maxY + 44, kScreenWidth - 30, 0.5)];
    [view addSubview:d5];
    
    UILabel * accountLabel = [UILabel labelWithText:@"账号" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15, d1.y, 50, 44)];
    [view addSubview:accountLabel];
    
    UILabel * passwordLabel = [UILabel labelWithText:@"密码" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15, d2.y, 50, 44)];
    [view addSubview:passwordLabel];
    
    UILabel * rePasswordLabel = [UILabel labelWithText:@"密码" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15, d3.y, 50, 44)];
    [view addSubview:rePasswordLabel];
    
    UILabel * phoneLabel = [UILabel labelWithText:@"手机号" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15, d4.y, 50, 44)];
    [view addSubview:phoneLabel];
    
    UILabel * verifyLabel = [UILabel labelWithText:@"验证码" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15, d5.y, 50, 44)];
    [view addSubview:verifyLabel];
    
    CGFloat accountFX = Fit(73);
    UITextField * accountField = [[UITextField alloc] initWithFrame:Rect(accountFX, accountLabel.y, kScreenWidth - accountFX - 15, accountLabel.height)];
    accountField.font = passwordLabel.font;
    accountField.placeholder = @"请输入4~12字符";
    accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:accountField];
    accountField.keyboardType = UIKeyboardTypeDefault;
    self.accountField = accountField;
    
    UITextField * passwordField = [[UITextField alloc] initWithFrame:Rect(accountFX, passwordLabel.y, kScreenWidth - accountFX - 15 , accountLabel.height)];
    passwordField.font = passwordLabel.font;
    passwordField.placeholder = @"请输入6~18位密码";
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:passwordField];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    self.passwordField = passwordField;
    
    UITextField * rePasswordField = [[UITextField alloc] initWithFrame:Rect(accountFX, rePasswordLabel.y, kScreenWidth - accountFX - 15 , passwordLabel.height)];
    rePasswordField.font = passwordLabel.font;
    rePasswordField.placeholder = @"请再次输入设置的密码";
    rePasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:rePasswordField];
    rePasswordField.keyboardType = UIKeyboardTypeDefault;
    self.rePasswordField = rePasswordField;
    
    UITextField * phoneField = [[UITextField alloc] initWithFrame:Rect(accountFX, phoneLabel.y, kScreenWidth - accountFX - 15 , passwordLabel.height)];
    phoneField.font = passwordLabel.font;
    phoneField.placeholder = @"手机号";
    phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:phoneField];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField = phoneField;
    
    UITextField * verifyField = [[UITextField alloc] initWithFrame:Rect(accountFX, verifyLabel.y, kScreenWidth - accountFX - 15 - 44 - 64 , passwordLabel.height)];
    verifyField.font = passwordLabel.font;
    verifyField.placeholder = @"验证码";
    verifyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:verifyField];
    verifyField.keyboardType = UIKeyboardTypeDefault;
    self.verifyField = verifyField;
    
    
    UIButton * getVerifyBtn = [UIButton buttonWithTitle:@"获取验证码" titleColor:HexColorInt32_t(666666) backgroundColor:nil font:Fit(12) image:nil frame:Rect(0, d5.y, Fit(64), 44)];
    getVerifyBtn.maxX = kScreenWidth - 20;
    [view addSubview:getVerifyBtn];
    [getVerifyBtn addTarget:self action:@selector(didClickGetVerifyBtn:)];
    self.getVerifyBtn = getVerifyBtn;
    
    UIButton * registerBtn = [UIButton buttonWithTitle:@"注册" titleColor:[UIColor whiteColor] backgroundColor:HexColorInt32_t(C0C0C0) font:Fit(16) image:nil frame:Rect(15, verifyField.maxY + 70, kScreenWidth - 30, Fit(44))];
    registerBtn.cornerRadius = 3;
    [view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(regisetrAccount)];
    
    RACSignal * enabled = [RACSignal combineLatest:@[accountField.rac_textSignal, passwordField.rac_textSignal, rePasswordField.rac_textSignal, phoneField.rac_textSignal, verifyField.rac_textSignal] reduce:^id(NSString *account,NSString *pwd,NSString *rePwd,NSString *phone,NSString *ver) {
        return @([phone length] && account.length > 0 && pwd.length > 0 && rePwd.length > 0 && ver.length > 0);
    }];
    
    RAC(registerBtn, backgroundColor) = [enabled map:^id(id value) {
        return [value boolValue] ? TheamColor : HexColorInt32_t(C0C0C0);
    }];
    RAC(registerBtn, enabled) = enabled;

}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"注册";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Actions

- (void)regisetrAccount {
    [self.view endEditing:YES];
    if (_accountField.text.length < 4 || _accountField.text.length > 12) {
        SVShowError(@"请输入4~12字符");
        return;
    }
    if (_passwordField.text.length < 6 || _passwordField.text.length > 18) {
        SVShowError(@"请输入6~18位密码");
        return;
    }
    if (_rePasswordField.text.length < 6 || _rePasswordField.text.length > 18) {
        SVShowError(@"请输入6~18位密码");
        return;
    }
    if (![_rePasswordField.text isEqualToString:_passwordField.text]) {
        SVShowError(@"两次输入的密码不一致");
        return;
    }
    SLLog(@"注册");
    SVShowSuccess(@"注册成功");
}

- (void)didClickGetVerifyBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    JYAssert(self.phoneField.hasText, @"请输入手机号");
    JYAssert([self.phoneField.text validateMobile], @"手机号格式不正确");
    [sender countDownWithTime:60 title:@"获取验证码" countDownTitle:@"s" backgroundColor:nil disabledColor:HexColorInt32_t(f8f8f8)];
    
}

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
