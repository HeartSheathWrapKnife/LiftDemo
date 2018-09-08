//
//  Parameter.h
//  XinCai
//
//  Created by ljy on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  参数

#import <Foundation/Foundation.h>

@interface Parameter : NSObject
//详情参数
@property (nonatomic,   copy) NSString * programmeId;
@property (nonatomic,   copy) NSString * sportIds;
@property (nonatomic,   copy) NSString * sportId;
@property (nonatomic,   copy) NSString * pageType;
@property (nonatomic,   copy) NSString * uiBetType;
@property (nonatomic,   copy) NSString * displayView;
@property (nonatomic,   copy) NSString * sortBy;
@property (nonatomic,   copy) NSString * isFirstLoad;
@property (nonatomic,   copy) NSString * MoreBetEvent;
@property (nonatomic,   copy) NSString * oddsType;
@property (nonatomic,   copy) NSString * _;
@property (nonatomic,   copy) NSString * isInplay;
//登录
@property (nonatomic,   copy) NSString * password;
@property (nonatomic,   copy) NSString * username;
@property (nonatomic,   copy) NSString * action;
@property (nonatomic,   copy) NSString * r;
@end


@interface BodyParameter : NSObject
@end

///  失败
extern const NSInteger kFailure;
///  成功，需要跳转链接
extern const NSInteger kSuccessWithLink;
///  无权\未登录
extern const NSInteger kUnLogin;
/// 成功
extern const NSInteger kSuccess;
///  请求失败提示文字
extern NSString * const hudTextForRequestFail;
///  正在请求提示文字
extern NSString * const hudTextForRequesting;
