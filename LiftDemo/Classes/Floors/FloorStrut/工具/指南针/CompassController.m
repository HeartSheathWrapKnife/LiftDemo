//
//  CompassController.m
//  LiftDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "CompassController.h"
#import "CompassView.h"

@interface CompassController ()

@end

@implementation CompassController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    
}

- (void)setupSubViews {
    CompassView *compassView = [CompassView sharedWithRect:self.view.bounds radius:(self.view.bounds.size.width-20)/2];
    compassView.backgroundColor = [UIColor blackColor];
    compassView.textColor = [UIColor whiteColor];
    compassView.calibrationColor = [UIColor whiteColor];
    compassView.horizontalColor = [UIColor purpleColor];
    [self.view addSubview:compassView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.tintColor = [UIColor whiteColor];
    button.frame = CGRectMake(15, 35, 37, 37);
    [button setImage:[UIImage imageNamed:@"tool_fanhui_left"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)buttonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
