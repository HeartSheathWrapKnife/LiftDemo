//
//  Parameter.m
//  XinCai
//
//  Created by ljy on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "Parameter.h"

@implementation Parameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([User sharedUser].isLogin) {
        }
    }
    return self;
}


@end



@implementation BodyParameter


@end

///  失败
const NSInteger kFailure = 9999;
///  成功，需要跳转链接
const NSInteger kSuccessWithLink = 8001;
///  无权\未登录
const NSInteger kUnLogin = 1001;
/// 成功
const NSInteger kSuccess = 0;
///  请求失败提示文字
NSString * const hudTextForRequestFail = @"网络请求错误了...";
///  请求失败提示文字
NSString * const hudTextForRequesting = @"正在加载";
