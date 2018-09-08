//
//  BaseViewController.m
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "BaseViewController.h"
#import "SLAlertView.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexColorInt32_t(F8F8F8);
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    setStatusBarLightContent(YES);
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setupNavigationBar {}
- (void)setupSubViews {}
- (void)setupInitializeData {}
//- (void)didClickButtonAtIndex:(NSInteger)index {}

- (void)setStatusBarSytle:(BOOL)isLight {
//    UIApplication * app = [UIApplication sharedApplication];
//    if (isLight) {
//        if (app.statusBarStyle == UIStatusBarStyleDefault) {
//            app.statusBarStyle = UIStatusBarStyleLightContent;
//        }
//    } else {
//        if (app.statusBarStyle == UIStatusBarStyleLightContent) {
//            app.statusBarStyle = UIStatusBarStyleDefault;
//        }
//    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


- (void)dealloc {
    [[XCHTTPSessionManager sharedManager].operationQueue cancelAllOperations];
    SLLog2(@"%@ @>->->->---- dealloc", self);
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

void makePhoneCall(NSString *phone) {
    if (!phone.length) {
        [UIAlertView alertWithTitle:@"号码为空" message:nil cancelButtonTitle:@"确定" OtherButtonsArray:nil clickAtIndex:nil];
        return;
    };
    [UIAlertView alertWithTitle:phone message:nil cancelButtonTitle:@"取消" OtherButtonsArray:@[@"拨打"] clickAtIndex:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    
}
@end
