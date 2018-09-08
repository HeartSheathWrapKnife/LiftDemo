//
//  UIViewController+PhoneCall.m
//  RideMoto
//
//  Created by Eleven on 17/1/17.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "UIViewController+PhoneCall.h"

@implementation UIViewController (PhoneCall)

- (void)dialTelephoneWithTelephoneNum:(NSString*)telNum {
#if TARGET_IPHONE_SIMULATOR // 模拟器
    NSLog(@"模拟器无法打电话");
    return;
#elif TARGET_OS_IPHONE      // 真机
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:telNum preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", telNum]];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
#endif
}

@end
