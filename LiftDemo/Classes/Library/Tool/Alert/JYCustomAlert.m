//
//  JYCustomAlert.m
//  LiftDemo
//
//  Created by apple on 2019/3/29.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "JYCustomAlert.h"

static JYCustomAlert * alertView = nil;
static UIView * customView = nil;
static HandleBlock block = nil;

@implementation JYCustomAlert

+ (void)alertWithCustomView:(UIView *)cview Handle:(_Nullable HandleBlock)handle {
    if (handle) {
        block = [handle copy];
    }
    
    JYCustomAlert *view = [[JYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alertView = view;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(cancelAction)]];
    view.alpha = 0;
    
    customView = cview;
    cview.center = view.center;
    [view addSubview:cview];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}

#pragma mark status
- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = customView.frame;
        customView.frame = frame;
        alertView.alpha = 1;
        
    } completion:nil];
}

- (void)cancelAction {
    [JYCustomAlert dismiss];
}

+ (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [alertView removeFromSuperview];
        alertView = nil;
        block = nil;
    }];
}

@end
