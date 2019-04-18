//
//  JYCustomAleartVC.h
//  LiftDemo
//
//  Created by apple on 2019/4/16.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYCustomAleartVC : UIViewController
@property (nonatomic, assign ,getter=isTouchBack) BOOL touchBack;
@property (nonatomic, strong) UIView * customView;
@end

NS_ASSUME_NONNULL_END
