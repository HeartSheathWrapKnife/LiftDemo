//
//  XCNetworking.m
//  XunChangApp
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "XCNetworking.h"
#import "UIImage+Compress.h"
#import "NSObject+YYModel.h"
#import "SVProgressHUD.h"
#import "SLAlertView.h"
#import "LoginViewController.h"


//#define Zhengshi 1 // 打开这个宏表示使用正式接口

#if !(DEBUG) && !(Zhengshi)
#error 请使用正式接口
#endif

//#ifdef Zhengshi
//// 正式接口
//NSString * const baseUrl      = @"https://i.api.51kcwc.com/";
//NSString * const baseWebUrl   = @"https://m.51kcwc.com/";
//NSString * const baseImageUrl = @"https://img.51kcwc.com";
//#else
//// 测试接口
//NSString * const baseUrl      = @"http://car.i.cacf.cn/";
//NSString * const baseWebUrl   = @"http://car.i.cacf.cn/";
//NSString * const baseImageUrl = @"http://img.i.cacf.cn";
//
//#endif
NSString * const baseUrl = @"http://sb-bcmp.prdasbbwla1.com/zh-cn/";



@implementation XCBaseModel
- (NSString *)description {
    return [NSString stringWithFormat:@"code = %zd,\n msg = %@, \n data = %@", self.code, self.msg, self.data];
}
@end

static XCHTTPSessionManager *_manager = nil;
@implementation XCHTTPSessionManager

+ (instancetype)sharedManager
{
    if (_manager == nil) {
        _manager = [[self alloc] init];
        
    }
    return _manager;
}
- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:baseUrl]
             sessionConfiguration:nil];
    self.requestSerializer.timeoutInterval = 30;
//    // 1.初始化
//    AFURLSessionManager *manager = self;
//    // 2.设置证书模式
//    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"kcwc" ofType:@"cer"];
//    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
//    // 客户端是否信任非法证书
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    // 是否在证书域字段中验证域名
//    [manager.securityPolicy setValidatesDomainName:YES];
    return self;
}

//切换baseURL
- (void)switchBaseURL:(NSString *)url {
    if (![baseUrl isEqualToString:url]) {
        NSURL *urlValue = [NSURL URLWithString:url];
        [self setValue:urlValue forKey:@"BaseURL"];
    } else {
        NSURL *urlValue = [NSURL URLWithString:baseUrl];
        [self setValue:urlValue forKey:@"BaseURL"];
    }
}

//重置baseU
+ (void)RESETBaseURL:(XCHTTPSessionManager *)manager {
    [manager switchBaseURL:@"http://sb-bcmp.prdasbbwla1.com/zh-cn/"];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
@end

@implementation XCNetworking

//表单提交 登录使用的网络请求
+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)baseUrl Action:(NSString *)event params:(id)params Cookie:(NSString *)cookieString hudText:(NSString *)text success:(void(^)(NSDictionary * response))success failure:(void(^)(NSError *error))failure {
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",baseUrl,event];
    NSDictionary * p = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        p = params;
    } else {
        p = [params modelToJSONObject];
    }
    
    /// 创建请求
    XCHTTPSessionManager *manager = [XCHTTPSessionManager sharedManager];
    //切换baseURL
    [manager switchBaseURL:baseUrl];
#if DEBUG
    _printParameter(manager,p, event);
#endif
    //表单格式上传参数
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //遍历key生成form表单
        NSArray *paramkeys = [p allKeys];
        for (int i = 0; i < paramkeys.count; i ++) {
            NSString * value = p[paramkeys[i]];
            NSString * key = paramkeys[i];
            [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
        }
        
    } error:nil];

    //redirect 重定向
    [manager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
        if (request) {
            NSLog(@"%@",request.URL);
            return request;
        } else {
            return nil;
        }
        return request;
    }];
    /// 超时
    request.timeoutInterval = 30;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 设置接收文件类型
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    //cookies
    if (cookieString) {
        [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
    if (text.length) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showStatus:text];
    }
    __block NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (text.length) [SVProgressHUD dismiss];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];//解析
                //如果不能解析成dictionary、array， 就按string来解析查看
//                NSString *responseObjectString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//                SLLog(responseObjectString);
            if (responseObject) {
                error = nil;
            }
            BLOCK_SAFE_RUN(success,resultDic);
            //切换为原来的baseurl
            [XCHTTPSessionManager RESETBaseURL:manager];
        } else {
            if (text.length) [SVProgressHUD dismiss];
            BLOCK_SAFE_RUN(failure,error);
#if DEBUG
            SLLog2(@"request error = %@",error);
#endif
            //切换为原来的baseurl
            [XCHTTPSessionManager RESETBaseURL:manager];
        }
    }];
    [task resume];
    return task;
}

//body- data传递参数
+ (NSURLSessionDataTask *)POSTWithEvent:(NSString *)event params:(id)params hudText:(NSString *)text success:(void(^)(NSDictionary * response))success failure:(void(^)(NSError *error))failure {
    return  [XCNetworking POSTWithURL:baseUrl Action:event params:params hudText:text success:^(NSDictionary *response) {
        BLOCK_SAFE_RUN(success,response);
    } failure:^(NSError *error) {
        BLOCK_SAFE_RUN(failure,error);
    }];
}

//body- data传递参数
+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)urlString
                               Action:(NSString *)event
                               params:(id)params
                              hudText:(NSString *)text
                              success:(void(^)(NSDictionary * response))success
                              failure:(void(^)(NSError * error))failure {
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",urlString,event];
    NSDictionary * p = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        p = params;
    } else {
        p = [params modelToJSONObject];
    }
    /// 组装body
    NSString *bodyStr = [p modelToJSONObject];
    NSData   *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    /// 创建请求
    XCHTTPSessionManager *manager = [XCHTTPSessionManager sharedManager];
    //切换baseURL
    [manager switchBaseURL:urlString];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    /// 超时
    request.timeoutInterval = 30;
    
    // 设置body
    [request setHTTPBody:body];
    /// 设置头部文件
    [request setValue:[NSString stringWithFormat:@"%lu",body.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:event forHTTPHeaderField:@"Event"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 设置接收文件类型
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    if (text.length) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showStatus:text];
    }
    
#if DEBUG
    SLLog2(@"body :%@ /n action :%@",bodyStr,event);
#endif
    __block NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (text.length) [SVProgressHUD dismiss];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];  //解析
            //            if (!_checkLoginStatus(resultDic)) return;//检测token
            BLOCK_SAFE_RUN(success,resultDic);
            [XCHTTPSessionManager RESETBaseURL:manager];
        } else {
            if (text.length) [SVProgressHUD dismiss];
            BLOCK_SAFE_RUN(failure,error);
            [XCHTTPSessionManager RESETBaseURL:manager];
#if DEBUG
            SLLog2(@"request error = %@",error);
#endif
        }
    }];
    [task resume];
    return task;
}


+ (NSURLSessionDataTask *)POSTWithURL:(NSString *)urlString
                                Action:(NSString *)event
                           SpLicParams:(id)params
                               hudText:(NSString *)text
                               success:(void(^)(NSDictionary * response))success
                               failure:(void(^)(NSError * error))failure{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",urlString,event];
    NSDictionary * p = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        p = params;
    } else {
        p = [params modelToJSONObject];
    }
    
    XCHTTPSessionManager * manager = [XCHTTPSessionManager sharedManager];
    [manager switchBaseURL:urlString];
    

#if DEBUG
    _printParameter(manager,p, event);
#endif
    if (text.length) {
        [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeBlack];
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:p error:nil];
    /// 超时
    request.timeoutInterval = 30;
    
    /// 设置头部文件
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 设置接收文件类型
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    if (text.length) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showStatus:text];
    }
    __block NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (text.length) [SVProgressHUD dismiss];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];  //解析
            BLOCK_SAFE_RUN(success,resultDic);
            [XCHTTPSessionManager RESETBaseURL:manager];
        } else {
            if (text.length) [SVProgressHUD dismiss];
            BLOCK_SAFE_RUN(failure,error);
            [XCHTTPSessionManager RESETBaseURL:manager];
#if DEBUG
            SLLog2(@"request error = %@",error);
#endif
        }
    }];
    [task resume];
    return task;
}


//baseurl 的get urlstring是action
+ (NSURLSessionDataTask *)GETWithURL:(NSString *)urlString params:(id)params hudText:(NSString *)text success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    return [XCNetworking GETWithURL:baseUrl Action:urlString params:params hudText:text success:^(NSDictionary *response) {
       BLOCK_SAFE_RUN(success,response);
    } failure:^(NSError *error) {
        BLOCK_SAFE_RUN(failure,error);
    }];
}

//任意url（manager切换）的get event是action
+ (NSURLSessionDataTask *)GETWithURL:(NSString *)urlString
                              Action:(NSString *)event
                              params:(id)params
                             hudText:(NSString *)text
                             success:(void(^)(NSDictionary *response))success
                             failure:(void(^)(NSError * error))failure {
    XCHTTPSessionManager * manager = [XCHTTPSessionManager sharedManager];
    [manager switchBaseURL:urlString];
    NSDictionary * p = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        p = params;
    } else {
        p = [params modelToJSONObject];
    }
#if DEBUG
    _printParameter(manager,p, event);
#endif
    if (text.length) {
        [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeBlack];
    }
    return [manager GET:event parameters:p success:^(NSURLSessionDataTask *task, id responseObject) {
        if (text.length) [SVProgressHUD dismiss];
        //        if (!_checkLoginStatus(responseObject)) return ;
        //        XCBaseModel * model = [XCBaseModel yy_modelWithDictionary:responseObject];
        NSDictionary *dict;
        if (![responseObject isKindOfClass:[NSDictionary class]]) {//如果不能解析成dictionary、array，说明是byte[] 需要重新解析.
            SLLog(@"非字典 bytes 重新格式化");
            NSString *jsonStr = [NSString stringWithUTF8String:[responseObject bytes]];
            NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
            dict = jsonDic;
        } else {
            dict = responseObject;
        }
        BLOCK_SAFE_RUN(success, dict);
        [XCHTTPSessionManager RESETBaseURL:manager];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (text.length) [SVProgressHUD dismiss];
        BLOCK_SAFE_RUN(failure, error);
        [XCHTTPSessionManager RESETBaseURL:manager];
    }];
}


+ (NSURLSessionDataTask *)GETWithEvent:(NSString *)event
                                params:(id)params
                             sessionID:(NSString *)sessionId
                               hudText:(NSString *)text
                               success:(void(^)(id responseObject))success
                               failure:(void(^)(NSError * error))failure {
    //url
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",baseUrl,event];
    
    XCHTTPSessionManager * manager = [XCHTTPSessionManager sharedManager];
    NSDictionary * p = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        p = params;
    } else {
        p = [params modelToJSONObject];
    }
#if DEBUG
    _printParameter(manager,p, event);
#endif
    //设置request
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestUrl parameters:p error:nil];
    request.timeoutInterval = 30;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 设置接收文件类型
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    //cookies 设置sessionid
    NSString *cookieString = sessionId;
    if (cookieString) {
        [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
    __block NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            BLOCK_SAFE_RUN(success,responseObject);
        } else {
            BLOCK_SAFE_RUN(failure,error);
        }
    }];
    [task resume];
    return task;
}



static void _printParameter(XCHTTPSessionManager * manager,NSDictionary * p, NSString * urlString) {
    NSString * string = [NSString stringWithFormat:@"请求参数：\n%@\n", p];
    NSString * u = [NSString stringWithFormat:@"%@%@?", manager.baseURL, urlString];
    NSMutableString * str = [NSMutableString string];
    [str appendString:string];
    [str appendString:u];
    [p enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"%@=%@&", key, obj];
    }];
    
    if ([str hasSuffix:@"&"]) {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    u = [NSString stringWithFormat:@"🎈%s 第 %d 行📍\n %@\n\n", __func__, __LINE__, str];
    printf("%s", u.UTF8String);
}

NSString *randFileName () {
    u_int32_t randNumber = arc4random_uniform(1999999);
    NSString * str = stringWithInt(randNumber);
    return [str stringByAppendingFormat:@"%@.jpg",str.MD5String];
}


static BOOL _isShowing = NO;

//检查登录是否过期
//static BOOL _checkLoginStatus (NSDictionary *dict) {
//    NSInteger code = [dict[@"code"] integerValue];
//    if (code == 10001 || code == 20077) {
//        [User removeUserInfomation];
//        if (_isShowing) return NO;
//        _isShowing = YES;
//        [UIAlertView alertWithTitle:@"提示" message:@"未登录或者登录过期，请重新登录" cancelButtonTitle:nil OtherButtonsArray:@[@"确定"] clickAtIndex:^(NSInteger buttonIndex) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                LoginViewController * vc = [LoginViewController new];
//                BaseNavigationController * b = [[BaseNavigationController alloc] initWithRootViewController:vc];
//                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:b animated:YES completion:nil];
//                _isShowing = NO;
//            });
//        }];
//        return NO;
//    }
//    return YES;
//}

@end


@implementation NSString (AppendPrefixURL)

//- (NSString *)rm_appendSize:(RMPicSize)size {
//    if ([self hasPrefix:@"http"]) return self;
//    static NSArray * arr;
//    if (arr == nil) {
//        arr =
//        @[
//          @"!7501334",
//
//          @"!414232",
//          @"!207116",
//          @"!10358",
//
//          @"!414310",
//          @"!207165",
//          @"!10383",
//
//          @"!414414",
//          @"!207207",
//          @"!103103",
//
//          @"!414207",
//          @"!207103",
//          @"!10352"
//          ];
//    }
//    return [NSString stringWithFormat:@"%@%@%@", baseImageUrl, self, arr[size]];
//}


@end
