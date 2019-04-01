//
//  Lostifor
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  各种常用宏


//#pragma mark - 色彩相关宏
#define RGBColor(r, g, b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]//RGB
#define RGBAColor(r, g, b, a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]//RGB alpha
#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SetBackgroundGrayColor self.view.backgroundColor = HexColorInt32_t(F8F8F8);// 背景颜色
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]//随机颜色
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))//随机颜色
///  主题色
//#define TheamColor HexColorInt32_t(4baae7)
#define TheamColor HexColorInt32_t(56bff8)
#define ThemeGreenColor HexColorInt32_t(36A95C)
#define ThemeTitleColor HexColorInt32_t(FFFFFF)
#define ThemeWhiteColor HexColorInt32_t(FFFFFF)
#define ThemePinkColor HexColorInt32_t(DA667E)
#define ThemeGrayColor HexColorInt32_t(1E2124)
////////////////////////////////////////////////////////////////////////////////////////////


#define ThreeNumMax(a,b,c) (a>=b?(a>=c?a:c):(b>=c?b:c))
#define ThreeNumMin(a,b,c) (a<=b?(a<=c?a:c):(b<=c?b:c))

//适配iPhoneX
#define SafeAreaTopHeight (ScreenHeight == 812.0 ? 88 : 64)
#define StatusBarHeight (ScreenHeight == 812.0 ? 44 : 20)
#define SafeAreaTabBarHeight (ScreenHeight == 812.0 ? 84 : 50)
#define SafeAreaBottomHeight (ScreenHeight == 812.0 ? 34 : 0)
/// 第一个参数是当下的控制器适配iOS11 以下的，第二个参数表示scrollview或子类 automaticallyAdjustsScrollViewInsets 废弃
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = NO;}


//#pragma mark - 宽高大小相关宏
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define HalfScreenWidth  [UIScreen mainScreen].bounds.size.width * 0.5
#define HalfScreenHeight [UIScreen mainScreen].bounds.size.height * 0.5
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kHalfScreenWidth  [UIScreen mainScreen].bounds.size.width * 0.5
#define kHalfScreenHeight [UIScreen mainScreen].bounds.size.height * 0.5


/////////////////////////////////////////////////////////////////////////////////
//#define Fit375(num) ((num)*kScreenWidth/375.00)
/// CGRect
#define Rect(x, y, w, h) CGRectMake((x), (y), (w), (h))
/// CGSize
#define Size(w, h) CGSizeMake((w), (h))
/// CGPoint
#define Point(x, y) CGPointMake((x), (y))
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
/////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - USER相关
#define User_m_id [User sharedUser].userInfo.cis_id
#define User_is_login [User sharedUser].isLogin
#define USER [User sharedUser]
#define USERINFO [User sharedUser].userInfo
#define IfUserIsNotLogin \
if (!User_is_login) { \
LoginViewController *loginVC = [[LoginViewController alloc] init]; \
BaseNavigationController *nav = [BaseNavigationController navWithRootViewController:loginVC]; \
[self presentViewController:nav animated:YES completion:nil]; \
return; \
}
// 获取token
#define GetToken [User sharedUser].userInfo.token

#define GetSign [User sharedUser].userInfo.Sign
///  在view中判断未登录，弹出登录控制器
#define IfUserIsNotLoginInView \
if (!User_is_login) { \
LoginViewController *loginVC = [[LoginViewController alloc] init]; \
BaseNavigationController *nav = [BaseNavigationController navWithRootViewController:loginVC]; \
[self.sl_viewController presentViewController:nav animated:YES completion:nil]; \
return; \
}
/////////////////////////////////////////////////////////////////////////////////////////////

//提示
#define SVShowError(message) [SVProgressHUD showError:(message)]
#define SVShowSuccess(message)[SVProgressHUD showSuccess:(message)]
#define SVFail SVShowError(@"网络连接失败");

///////////////////////////////////////////////////////////////////////////////////////

//弱self
#define WeakSelf __weak typeof(self) wself = self;
//一般使用RAC自带的@weakify @strongify 自带缓存池
//弱引用
//#define weakify(object) __weak __typeof__(object) weak##_##object = object;
//强引用
//#define strongify(object) __typeof__(object) object = weak##_##object;

////////////////////////////////////////////////////////////////////////////////////////

//block运行
#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil;


/// 验证是文字是否输入
///
/// @param __Text    文字长度
/// @param __Message 错误提示
#define JYVerifyText(__TextLength, __Message)\
if (!__TextLength) {\
SVShowError(__Message);\
return;\
}

/// 验证手机正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyPhone(__Phone, __Message)\
if (![__Phone validateMobile]) {\
SVShowError(__Message);\
return;\
}

/// 验证邮箱正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyEmail(__Email, __Message)\
if (![__Email validateEmail]) {\
SVShowError(__Message);\
return;\
}

/// 验证密码正则
///
/// @param __Text    文字
/// @param __Message 错误提示
#define JYVerifyPassword(__Password, __Message)\
if (![__Password validatePassword]) {\
SVShowError(__Message);\
return;\
}

/// 验证条件
#define JYAssert(Condition, Message)\
if (!(Condition)) {\
SVShowError(Message);\
return;\
}




#define JYReleaseView(__View) { \
[(__View) removeFromSuperview];\
(__View) = nil;}
///////////////////////////////////////////////////////////////////////

//懒加载相关宏
#define JYLazyMutableArray(_array) \
return !(_array) ? (_array) = [NSMutableArray array] : (_array);

#define JYLazyArray(_array)    \
return !(_array) ? (_array) = [NSArray array] : (_array);

#define JYLazyMutableDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSMutableDictionary dictionary] : (_dictionary);

#define JYLazyDictionary(_dictionary) \
return !(_dictionary) ? (_dictionary) = [NSDictionary dictionary] : (_dictionary);




//图片 URL

#define PlaceHolder11 ImageWithName(@"ic_default_no_data")
#define PlaceHolder21 ImageWithName(@"ic_default_no_data")
#define PlaceHolderAvator ImageWithName(@"")
#define ImageWithName(nameString) [UIImage imageNamed:nameString]
#define UrlWithString(urlSring) [NSURL URLWithString:urlSring]
//tableview停止刷新
#define JYEndRefreshing(__ScrollView)\
if ([__ScrollView.mj_footer isRefreshing]) {\
[__ScrollView.mj_footer endRefreshing];\
}\
if ([__ScrollView.mj_header isRefreshing]) {\
[__ScrollView.mj_header endRefreshing];\
}


//是否第一次进入app 实际上可以不用CFBundleShortVersionString 只是为了不重复命名
#define  NOTFIRSTOPEN  [[NSUserDefaults standardUserDefaults]objectForKey:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
//是否登录
#define LOGIN [[NSUserDefaults standardUserDefaults] objectForKey:@"login"]



