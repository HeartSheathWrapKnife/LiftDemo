//
//  User.h
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AMapLocationKit/AMapLocationKit.h>
#import <CoreLocation/CLLocation.h>


/// 用户位置
@interface UserLocation : NSObject
@property (nonatomic,   copy) NSString * city_id;
@property (nonatomic,   copy) NSString * city_name;
@property (nonatomic,   copy) NSString * longitude;
@property (nonatomic,   copy) NSString * latitude;
//@property (nonatomic, strong) AMapLocationReGeocode *reGeocode;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,   copy) NSString * adcode;
@end

@interface UserInfo : NSObject
@property (nonatomic,   copy) NSString * accesstoken;//token
@property (nonatomic,   copy) NSString * userid;
@property (nonatomic,   copy) NSString * username;
@property (nonatomic, assign) BOOL needRefresh;//如果推出再登录 重新进入需要刷新首页的数据
@property (nonatomic,   copy) NSString * token;


@end



@interface User : NSObject
/// 是否登录
@property (nonatomic, assign, getter=isLogin) BOOL login;
///  用户位置
@property (nonatomic, strong) UserLocation * location;
///  用户信息
@property (nonatomic, strong) UserInfo * userInfo;
///  多任务缩略图类型  0无  1模糊当前页面截图  2自定义视图
@property (nonatomic, assign) NSInteger  backGroundMaskType;
///  是否需要重新验证手势密码
@property (nonatomic, assign ,getter=isCheckGesturePwd) BOOL checkGesturePwd;

+ (instancetype)sharedUser;

///  用户是否登录
+ (void)configUser;

///  保存用户信息（登录状态）
+ (BOOL)saveUserInfomation:(NSDictionary *)userInfo;
///  保存上一次定位信息
+ (void)saveUserLocation;

///  删除用户信息 （退出登录状态）
+ (BOOL)removeUserInfomation;

#pragma mark - UserDefault
///  移除userDefaults key对应的object
+ (void)removeUseDefaultsForKey:(NSString *)key;

///  保存对象到userDefaults
+ (void)saveUseDefaultsOjbect:(id)obj forKey:(NSString *)key;

///  从userDefaults获取对象
+ (id)getUseDefaultsOjbectForKey:(NSString *)key;

///  设置导航条白色
///
///  @param isNeedLight  YES 需要设置成白色， 反之NO
UIKIT_EXTERN void setStatusBarLightContent(BOOL isNeedLight);

///  获取设备uuid
///
///  @return uuid string
+ (NSString *)getDeviceId;

@end


/// 定义没有返回值的block
typedef void (^VoidBlcok)(void);

/// 定义带一个NSDictionary参数的block
///
/// @param dict NSDictionary
typedef void (^DictionaryBlcok)(NSDictionary *dict);

/// 定义带一个array参数的block
///
/// @param array NSArray
typedef void (^ArrayBlcok)(NSArray *array);

/// 定义带一个NSString参数的block
///
/// @param string NSString
typedef void (^StringBlcok)(NSString *string);
