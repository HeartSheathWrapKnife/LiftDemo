//
//  LocalVerifyTestController.m
//  LiftDemo
//
//  Created by apple on 2019/4/23.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "LocalVerifyTestController.h"
#import "LocalVerifyManager.h"

@interface LocalVerifyTestController ()
@property (nonatomic, strong) LocalVerifyManager * manager;
@end

@implementation LocalVerifyTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [LocalVerifyManager shareManager];
    
    UIButton *button = [UIButton buttonWithTitle:@"本地验证" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:13 image:nil frame:Rect(0, 0, 80, 120)];
    [button addTarget:self action:@selector(buttonClick)];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)buttonClick {
    [self.manager localVerifyResult:^(FingerVerResults resultStatte) {
        //code
    } backfallTitle:nil];
}

@end
