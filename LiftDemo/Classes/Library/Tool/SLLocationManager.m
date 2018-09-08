//
//  SLLocationTool.m
//  NBG
//
//  Created by Seven Lv on 16/3/28.
//  Copyright © 2016年 Seven Lv. All rights reserved.
//

#import "SLLocationManager.h"

@interface SLLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,   copy) void (^complete)(NSString *cityName, CLLocationCoordinate2D coordinate, NSError * error);
@end

static SLLocationManager *_manager = nil;

@implementation SLLocationManager



+ (instancetype)sharedManager
{
    if (_manager == nil) {
        _manager = [[self alloc] init];
    }
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

///  定位
- (void)startLocation:(void (^)(NSString *, CLLocationCoordinate2D, NSError *)) complete {
    
    SLLog([CLLocationManager authorizationStatus]);
    // kCLAuthorizationStatusAuthorizedWhenInUse  使用期间
    // kCLAuthorizationStatusDenied               用户拒绝定位
    if (![CLLocationManager locationServicesEnabled]) {
        NSString * message = @"无法定位，因为您的设备没有启用定位服务，请到设置中启用";
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        !complete ? : complete(nil, CLLocationCoordinate2DMake(0.0, 0.0), [NSError errorWithDomain:@"Error" code:0 userInfo:@{}]);
        return;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    } else if (status == kCLAuthorizationStatusDenied) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * message = @"无法定位，因为您没有授权本程序使用定位，请至设置中开启";
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            !complete ? : complete(nil, CLLocationCoordinate2DMake(0.0, 0.0), [NSError errorWithDomain:@"Error" code:0 userInfo:@{}]);
            return ;
        });
    }
    
    
    self.complete = complete;
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    // 1.取出位置对象
    CLLocation *loc = [locations firstObject];
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    __block NSString *city = nil;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0 && self.complete)  {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            if ([city containsString:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            // 发送结果
            !self.complete ? : self.complete(city, coordinate, nil);
            self.complete = nil;
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    if (error) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        !self.complete ? : self.complete(nil, CLLocationCoordinate2DMake(0.0, 0.0), [NSError errorWithDomain:@"Error" code:0 userInfo:@{}]);
    }
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
    }
    return _locationManager;
}



@end
