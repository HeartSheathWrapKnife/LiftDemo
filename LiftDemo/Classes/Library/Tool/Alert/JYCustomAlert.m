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

+ (void)alertWithCustomViewHandle:(HandleBlock)handle {
    if (handle) {
        block = [handle copy];
    }
    
    JYCustomAlert *view = [[JYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    alertView = view;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];
    
    //custom View
    UIView * content = [[UIView alloc] initWithFrame:Rect(0, kScreenHeight, kScreenWidth, 100)];
    content.backgroundColor = [UIColor whiteColor];
    customView = content;
    
    content.height = content.maxY;
    view.hidden = YES;
    [view addSubview:content];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}

#pragma mark status
- (void)show {
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = customView.frame;
        frame.origin.y = kScreenHeight - CGRectGetHeight(customView.frame);
        customView.frame = frame;
        alertView.alpha = 1;
        
    } completion:nil];
}

- (void)cancelAction {
    [JYCustomAlert dismiss];
}
+ (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = customView.frame;
        frame.origin.y = kScreenHeight;
        customView.frame = frame;
        alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [alertView removeFromSuperview];
        alertView = nil;
        customView = nil;
        block = nil;
    }];
}

@end
