//
//  LoginViewController.m
//  XinCai
//
//  Created by Lostifor on 25/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  登录

#import "LoginViewController.h"
#import "UIButton+Extension.h"
#import "RegisterController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "SLAlertView.h"
#import "WebLinkController.h"



@interface LoginViewController ()
@property (nonatomic,   weak) UITextField * passwordField;
@property (nonatomic,   weak) UITextField * phoneField;
@property (nonatomic, strong) NSString * urlStr;
@end

@implementation LoginViewController {
    UIScrollView * _scrollView;
    UIButton * _selectBtn;
    UIView * _line;

    RACDisposable * _dis;
    UIButton * _rightBtn;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setStatusBarSytle:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

    
    UIView * container = [UIView viewWithBgColor:[UIColor clearColor] frame:Rect(0, 64, kScreenWidth, kScreenHeight - 64)];
    [self.view addSubview:container];
    
    UIImageView * logoImageView = [UIImageView imageViewWithImage:[UIImage imageNamed:@"AppIcon"] frame:CGRectZero];
    [container addSubview:logoImageView];
    logoImageView.hidden = YES;
    logoImageView.sd_layout.heightIs(Fit(48)).widthIs(Fit(49)).topSpaceToView(container, 5).centerXIs(kHalfScreenWidth);
    
    CGFloat lastY = logoImageView.maxY + Fit(35 + 44);
    
    UIScrollView * scrollView = [UIScrollView scrollViewWithBgColor:nil frame:Rect(0, lastY, kScreenWidth, container.height - lastY)];
    [container addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.scrollEnabled = NO;
    
    //view
    {
        UIView * view = [UIView viewWithBgColor:nil frame:Rect(0, 0, kScreenWidth, scrollView.height)];
        [scrollView addSubview:view];
        
        UIView * d1 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(0, 0, kScreenWidth, 0.5)];
        [view addSubview:d1];
        
        UIView * d2 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d1.maxY + 44, kScreenWidth - 30, 0.5)];
        [view addSubview:d2];
        
        UIView * d3 = [UIView viewWithBgColor:HexColorInt32_t(F0F0F0) frame:Rect(15, d2.maxY + 44, kScreenWidth - 30, 0.5)];
        [view addSubview:d3];
        
        UILabel * accountLabel = [UILabel labelWithText:@"账号" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15 + 20, d1.y, 50, 44)];
        [view addSubview:accountLabel];
        
        UILabel * passwordLabel = [UILabel labelWithText:@"密码" font:Fit(14) textColor:HexColorInt32_t(1E2124) frame:Rect(15 + 20, d2.y, 50, 44)];
        [view addSubview:passwordLabel];
        
        CGFloat accountFX = Fit(73);
        UITextField * accountField = [[UITextField alloc] initWithFrame:Rect(accountFX, accountLabel.y, kScreenWidth - accountFX - 15, accountLabel.height)];
        accountField.font = passwordLabel.font;
        accountField.placeholder = @"请输入账号";
        accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [view addSubview:accountField];
        accountField.keyboardType = UIKeyboardTypeDefault;
        self.phoneField = accountField;
        
        UITextField * passwordField = [[UITextField alloc] initWithFrame:Rect(accountFX, passwordLabel.y, kScreenWidth - accountFX - 15 , accountLabel.height)];
        passwordField.font = passwordLabel.font;
        passwordField.placeholder = @"请输入密码";
        passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordField.secureTextEntry = YES;
        [view addSubview:passwordField];
        passwordField.keyboardType = UIKeyboardTypeDefault;
        self.passwordField = passwordField;
        


        
        UIButton * loginBtn = [UIButton buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] backgroundColor:HexColorInt32_t(C0C0C0) font:Fit(16) image:nil frame:Rect(15, passwordField.maxY + 70, kScreenWidth - 30, Fit(44))];
        loginBtn.cornerRadius = 3;
        [view addSubview:loginBtn];
        [loginBtn addTarget:self action:@selector(_didClickLoginBtn)];
        
        
        UILabel * protocal = [UILabel labelWithText:nil font:Fit(10) textColor:HexColorInt32_t(999999) frame:Rect(16, 0, 1, 1)];
        NSString * txt = @"登录表示您同意《用户协议》";
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:txt];
        [attr addAttribute:NSForegroundColorAttributeName value:HexColorInt32_t(4E92DF) range:[txt rangeOfString:@"《用户协议》"]];
        protocal.attributedText = attr;
        protocal.userInteractionEnabled = YES;
        [protocal sizeToFit];
        protocal.maxY = view.height - 15;
        [view addSubview:protocal];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_didClickProtocalLabel)];
        [protocal addGestureRecognizer:tap];
        
        UIButton *forgetBtn = [UIButton buttonWithTitle:@"忘记密码?" titleColor:HexColorInt32_t(666666) backgroundColor:[UIColor clearColor] font:Fit(10) image:nil frame:Rect(ScreenWidth - Fit(70), loginBtn.maxY + Fit(20), Fit(50), Fit(30))];
        [forgetBtn addTarget:self action:@selector(_didClickForgetPasswordBtn)];
        [view addSubview:forgetBtn];
        
        //临时号码
        accountField.text = @"cqhand";
        passwordField.text = @"tt1214";
        //监听
        RACSignal * enabled = [RACSignal combineLatest:@[accountField.rac_textSignal, passwordField.rac_textSignal] reduce:^id(NSString *phone,NSString *code) {
            return @([phone length] && code.length > 0);
        }];
        
        RAC(loginBtn, backgroundColor) = [enabled map:^id(id value) {
            return [value boolValue] ? TheamColor : HexColorInt32_t(C0C0C0);
        }];
        
        RAC(loginBtn, enabled) = enabled;
        

    }
}

///  设置自定义导航条
- (void)setupNavigationBar {
//    @weakify(self);
    NSString * title = @"登录";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title 
                                              backAction:^{
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"freshInfoView" object:nil];
                                                  [self.navigationController dismissViewControllerAnimated:YES completion:nil];}];
}

#pragma mark - Actions
///  点击协议
- (void)_didClickProtocalLabel {
    SLLog(@"跳转到协议");
    UIViewController * controller = [[NSClassFromString(@"ProtocalVC") alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

///  可见\不可见
- (void)_didClickEyeBtn:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    self.passwordField.secureTextEntry = !btn.isSelected;
}

///  点击获取验证码
- (void)_didClickGetVerifyBtn:(UIButton *)btn {
    [self.view endEditing:YES];
    JYAssert(self.phoneField.hasText, @"请输入手机号");
    JYAssert([self.phoneField.text validateMobile], @"请输入正确的手机号码！");
    [btn countDownWithTime:60 title:@"获取验证码" countDownTitle:@"s" backgroundColor:nil disabledColor:HexColorInt32_t(C0C0C0)];
}

///  登录
- (void)_didClickLoginBtn {
    [self.view endEditing:YES];
//    [self loginRequest];
    [self loginYunBet];
}

///  忘记密码
- (void)_didClickForgetPasswordBtn {
    @weakify(self);
    [UIAlertView alertWithTitle:@"" message:@"是否立即联系管理员修改？" cancelButtonTitle:@"稍后再说" OtherButtonsArray:@[@"立即前往"] clickAtIndex:^(NSInteger buttonIndex) {
        @strongify(self);
        if (buttonIndex !=0) {
//            [self requestBannerData];
        }
    }];
}





#pragma mark - Networking


- (void)loginYunBet {
}



/**
 登录
 */
- (void)loginRequest {

}

/**
 检测手势密码
 */
- (void)checkGestureLock {
    ZLGestureLockViewController *vc = [[ZLGestureLockViewController alloc] initWithUnlockType:ZLUnlockTypeValidatePsw];
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 删除手势密码
 */
- (void)deleteGestureLock {
    [ZLGestureLockViewController deleteGesturesPassword];
}

//合适的时机加载持久化后Cookie 一般都是app刚刚启动的时候
- (void)loadSavedCookies{
//    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"SPI/Launch.aspx.cookiesave"]];
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in cookies){
//        NSLog(@"cookie,name:= %@,value = %@",cookie.name,cookie.value);
//    }
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"SPI/Launch.aspx.cookiesave"];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}

/**
 登录
 */
//- (void)loginRequest {//this.accountStorage.Set({ username: username, uid: uid, token: token });
//    Parameter *params = [Parameter new];
//    params.username = @"testljy";
//    params.password = @"123456";
//    params.username = self.phoneField.text;
//    params.password = self.passwordField.text;
//    NSString * hudText = @"登录中";
//    [XCNetworking POSTWithEvent:@"User-UserLogin" params:params hudText:hudText success:^(XCBaseModel *response) {
//        if (response.code != kSuccess) {
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//            [SVProgressHUD showErrorWithStatus:response.message];
//            return;
//        }
//        SLLog(response);
//        //储存用户信息
//        [User saveUserInfomation:response.value];
//        //默认打开震动
//        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"zhongDongSwith"];
//        //
//        [User sharedUser].userInfo.needRefresh = YES;//需要刷新首页数据
////        //切换
////        MainViewController *main = [MainViewController new];
////        self.view.window.rootViewController = main;
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//        [SVProgressHUD showErrorWithStatus:hudTextForRequestFail];
//    }];
//}

/**
 获取首页系统数据
 */
//- (void)requestBannerData {
//    NSString * event = @"Config-GetSysConfig";
//    Parameter * param = [Parameter new];
//    
//    NSString * hudText = nil;
//    [XCNetworking POSTWithEvent:event params:param hudText:hudText success:^(XCBaseModel *response) {
//        SLLog(response);
//        if (response.code != kSuccess) {
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//            [SVProgressHUD showErrorWithStatus:response.message];
//            return;
//        }
//        //success
//        self.urlStr = response.value[@"custom_service"];
//        //前往客服页面
//        WebLinkController * controller = [[WebLinkController alloc] init];
//        controller.title = @"客服咨询";
//        controller.linkUrl = self.urlStr;
//        [self.navigationController pushViewController:controller animated:YES];
//
//    } failure:^(NSError *error) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//        [SVProgressHUD showErrorWithStatus:hudTextForRequestFail];
//    }];
//}
#pragma mark - Delegate



#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
