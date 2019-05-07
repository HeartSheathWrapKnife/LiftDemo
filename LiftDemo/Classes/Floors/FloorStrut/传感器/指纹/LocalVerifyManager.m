//
//  LocalVerifyManager.m
//  LiftDemo
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "LocalVerifyManager.h"
#import<LocalAuthentication/LocalAuthentication.h>

#define kIsIphoneXAndAfter ((kScreenHeight >= 812.f) ? YES : NO)

@implementation LocalVerifyManager

+ (instancetype)shareManager{
    static LocalVerifyManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[LocalVerifyManager alloc] init];
    });
    return manage;
}
- (void)localVerifyResult:(void(^)(FingerVerResults resultStatte))result backfallTitle:(nullable NSString *)title {
    //首先判断版本
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        //系统版本不支持TouchID
        return;
    }
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = title;
    if (@available(iOS 10.0, *)) {
        //        context.localizedCancelTitle = @"22222";
    } else {
        // Fallback on earlier versions
    }
    NSError *myError = nil;
    //是否支持touchid
    //    [_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]
    //    //报错码为-8时，调用此方法会弹出系统密码输入界面
    //    [_context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"指纹验证错误次数过多，请输入密码" reply:^(BOOL success, NSError * _Nullable error){
    //
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&myError]) {
        NSString *message = kIsIphoneXAndAfter ? @"验证已有面容 ID 指纹" : @"通过Home键验证已有手机指纹";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(FingerVerResultsSuccess);
                });
            }else if(error){
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            SVShowError(@"指纹验证失败，请稍后再试");
                        });
                        break;
                    }
                    case LAErrorUserCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            result(FingerVerResultsUserCancel);
                        });
                    }
                        break;
                    case LAErrorUserFallback:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"用户不使用TouchID,选择手动输入密码");
                            result(FingerVerResultsUserPwd);
                        });
                    }
                        break;
                    case LAErrorSystemCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                            result(FingerVerResultsSysCancel);
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                        });
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                        });
                    }
                        break;
                    case LAErrorTouchIDNotAvailable:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 无效");
                        });
                    }
                        break;
                    case LAErrorTouchIDLockout:{
                        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
                            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"指纹验证错误次数过多，请输入解锁密码" reply:^(BOOL asuccess, NSError * _Nullable aerror) {
                                [self localVerifyResult:result backfallTitle:title];
                            }];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                        });
                    }
                        break;
                    case LAErrorAppCancel:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                        });
                    }
                        break;
                    case LAErrorInvalidContext:{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }else{
        if (myError.code == -8) {
            result(FingerVerResultsLocked);
        }
        if (myError.code == -7) {
            result(FingerVerResultsNoRegisterFinger);
        }
        if (myError.code == -5) {
            result(FingerVerResultsNoRegisterFinger);
        }
    }
}
@end
