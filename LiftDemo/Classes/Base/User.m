//
//  User.m
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "User.h"

static User * _user = nil;

@implementation User

+ (instancetype)sharedUser
{
    if (_user == nil) {
        _user = [[self alloc] init];
    }
    return _user;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [super allocWithZone:zone];
    });
    return _user;
}

+ (BOOL)saveUserInfomation:(NSDictionary *)userInfo {
    
    if (!userInfo) return NO;
    
    UserInfo * info = [UserInfo yy_modelWithJSON:userInfo];
    [User sharedUser]->_userInfo = info;
    [[User sharedUser] setLogin:YES];
    // 沙盒路径
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    return [info.yy_modelToJSONObject writeToFile:path atomically:YES];
}

+ (void)saveUserLocation {
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userLocation.plist"];
    NSDictionary * dict = [User sharedUser].location.yy_modelToJSONObject;
    [dict writeToFile:path atomically:YES];
    
}

+ (void)configUser {
    NSString * userInfoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    SLLog(userInfoPath);
    NSDictionary * d = [NSDictionary dictionaryWithContentsOfFile:userInfoPath];
    
    if ([d count]) {
        UserInfo * info = [UserInfo yy_modelWithJSON:d];
        [User sharedUser]->_userInfo = info;
        [[User sharedUser] setLogin:YES];
    }
    
//    NSString * userLocationPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userLocation.plist"];
//    NSDictionary * location = [NSDictionary dictionaryWithContentsOfFile:userLocationPath];
//    if (location) {
//        UserLocation * l = [UserLocation yy_modelWithDictionary:location];
//        [User sharedUser].location = l;
//        USER.location.coordinate = CLLocationCoordinate2DMake(l.latitude.doubleValue, l.longitude.doubleValue);
//    }
}

+ (BOOL)removeUserInfomation {
    
    [User sharedUser]->_userInfo = nil;
    [User sharedUser].login = NO;
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    // 判断文件路径是否存在
    if (![manager fileExistsAtPath:path]) {
        return NO;
    }
    
    
    // 删除文件
    return [manager removeItemAtPath:path error:nil];
}

+ (void)removeUseDefaultsForKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

///  保存对象到userDefaults
+ (void)saveUseDefaultsOjbect:(id)obj forKey:(NSString *)key {
    
    [self removeUseDefaultsForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

///  从userDefaults获取对象
+ (id)getUseDefaultsOjbectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

void setStatusBarLightContent(BOOL isNeedLight) {
    
    UIApplication * app = [UIApplication sharedApplication];
    if (isNeedLight) {
        if (app.statusBarStyle == UIStatusBarStyleDefault) {
            app.statusBarStyle = UIStatusBarStyleLightContent;
        }
    } else {
        if (app.statusBarStyle == UIStatusBarStyleLightContent) {
            app.statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}

+ (NSString *)getDeviceId {
    NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
    NSString * currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
    return currentDeviceUUIDStr;
}

@end

@implementation UserLocation

@end

@implementation UserInfo



@end
