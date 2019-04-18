//
//  JYCustomAleartVC.m
//  LiftDemo
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYCustomAleartVC.h"

@interface JYCustomAleartVC ()

@end

@implementation JYCustomAleartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    if (self.customView) {
        [self.view addSubview:self.customView];
        [self.customView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customViewClicked)]];
    }
    
    if (self.isTouchBack) {
        [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
        
    }
    
}

- (void)customViewClicked {
    NSLog(@"点击自定义视图");
}

- (void)cancelAction {
    NSLog(@"tapBack");
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
