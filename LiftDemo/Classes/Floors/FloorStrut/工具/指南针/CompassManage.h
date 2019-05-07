//
//  CompassManage.h
//  LiftDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLHeading.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompassManage : NSObject
+ (instancetype)shared;
- (void)startSensor;
- (void)stopSensor;
- (void)startGyroscope;

@property (nonatomic, copy) void (^didUpdateHeadingBlock)(CLLocationDirection theHeading);
@property (nonatomic, copy) void (^updateDeviceMotionBlock)(CMDeviceMotion *data);
@end

NS_ASSUME_NONNULL_END
