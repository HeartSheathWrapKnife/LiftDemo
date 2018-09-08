//
//  XCNetworking.h
//  XunChangApp
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

extern NSString * const baseUrl;
extern NSString * const baseWebUrl;
extern NSString * const baseImageUrl;

@interface XCBaseModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;
@property (nonatomic,   copy) NSString * msg;

@end

/// 将AFHTTPSessionManager封装成单例
@interface XCHTTPSessionManager : AFHTTPSessionManager

/// 获取单例对象
+ (instancetype)sharedManager;

- (void)switchBaseURL:(NSString *)url;

@end

@interface XCNetworking : NSObject

//登录使用的 formdata表单
+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)baseUrl Action:(NSString *)event params:(id)params Cookie:(NSString *)cookieString hudText:(NSString *)text success:(void(^)(NSDictionary * response))success failure:(void(^)(NSError *error))failure;

///  Get请求
///
///  @param urlString url
///  @param params    参数（字典或模型）
///  @param success   成功回调
///  @param failure   失败回调
///
///  @return task
+ (NSURLSessionDataTask *)GETWithURL:(NSString *)urlString
                              params:(id)params
                             hudText:(NSString *)text
                             success:(void(^)(NSDictionary *))success
                             failure:(void(^)(NSError * error))failure;

+ (NSURLSessionDataTask *)GETWithURL:(NSString *)baseURL
                              Action:(NSString *)event
                              params:(id)params
                             hudText:(NSString *)text
                             success:(void(^)(NSDictionary *))success
                             failure:(void(^)(NSError * error))failure;
///  POST请求
///
///  @param urlString url
///  @param params    参数（字典或模型）
///  @param success   成功回调
///  @param failure   失败回调
///
///  @return task
+ (NSURLSessionDataTask *)POSTWithEvent:(NSString *)urlString
                               params:(id)params
                              hudText:(NSString *)text
                              success:(void(^)(NSDictionary * response))success
                              failure:(void(^)(NSError * error))failure;


//body data形式传递参数
+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)urlString
                               Action:(NSString *)event
                                 params:(id)params
                                hudText:(NSString *)text
                                success:(void(^)(NSDictionary * response))success
                                failure:(void(^)(NSError * error))failure;

//拼接形式 传递参数
+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)urlString
                               Action:(NSString *)event
                               SpLicParams:(id)params
                              hudText:(NSString *)text
                              success:(void(^)(NSDictionary * response))success
                              failure:(void(^)(NSError * error))failure;


//BMCP使用的GET 传递sessionid  返还的responseObject不一定是json
+ (NSURLSessionDataTask *)GETWithEvent:(NSString *)event
                                params:(id)params
                             sessionID:(NSString *)sessionId
                               hudText:(NSString *)text
                               success:(void(^)(id responseObject))success
                               failure:(void(^)(NSError * error))failure;






///  图片上传
///
///  @param urlString url
///  @param params    参数（字典或模型）
///  @param image      图片
///  @param imageParam 图片参数
///  @param success   成功回调
///  @param failure   失败回调
///
///  @return task
//+ (NSURLSessionDataTask *)POSTImageWithURL:(NSString *)urlString
//                                    params:(id)params
//                                     image:(UIImage *)image
//                                imageParam:(NSString *)imageParam
//                                   hudText:(NSString *)text
//                                   success:(void(^)(XCBaseModel * response))success
//                                   failure:(void(^)(NSError * error))failure;

///  产生随便文件名(xxx.jpg)
FOUNDATION_EXPORT NSString * randFileName(void);

@end


/**
 图片尺寸版本
 */
typedef NS_ENUM(NSUInteger, RMPicSize) {
    RMPicSizeOrigin = 0,
    
    RMPicSize16x9L,
    RMPicSize16x9M,
    RMPicSize16x9S,
    
    RMPicSize4x3L,
    RMPicSize4x3M,
    RMPicSize4x3S,
    
    RMPicSize1x1L,
    RMPicSize1x1M,
    RMPicSize1x1S,
    
    RMPicSize2x1L,
    RMPicSize2x1M,
    RMPicSize2x1S,
    /*
    RMPicSize16x9L = 414 * 232,
    RMPicSize16x9M = 207 * 116,
    RMPicSize16x9S = 103 * 58,
    
    RMPicSize4x3L  = 414 * 310,
    RMPicSize4x3M  = 207 * 165,
    RMPicSize4x3S  = 103 * 83,
    
    RMPicSize1x1L  = 414 * 414,
    RMPicSize1x1M  = 207 * 207,
    RMPicSize1x1S  = 103 * 103,
    
    RMPicSize2x1L  = 414 * 207,
    RMPicSize2x1M  = 207 * 103,
    RMPicSize2x1S  = 103 * 52,
     */
};

@interface NSString (AppendPrefixURL)

- (NSString *)rm_appendSize:(RMPicSize)size;

@end
