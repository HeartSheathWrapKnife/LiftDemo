//
//  LocalVerifyManager.h
//  LiftDemo
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FingerVerResults) {
    FingerVerResultsSuccess,//成功
    FingerVerResultsUserCancel,//用户取消
    FingerVerResultsExtVer,//退出验证
    FingerVerResultsSysCancel,//系统取消
    FingerVerResultsUserPwd,//点击输入密码
    FingerVerResultsManyTimesInvalid,//多次验证无效
    FingerVerResultsNoRegisterFinger,//未设置指纹
    FingerVerResultsLocked//被锁定，需要输入解锁密码
};

@interface LocalVerifyManager : NSObject
+ (instancetype)shareManager;

- (void)localVerifyResult:(void(^)(FingerVerResults resultStatte))result backfallTitle:(nullable NSString *)title;

@end

NS_ASSUME_NONNULL_END
