//
//  NoiseTestView.m
//  LiftDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "NoiseTestView.h"

@implementation NoiseTestView

- (instancetype)init {
    self = [super init];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)show {
    //背景图片
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zp"]];
    imageV.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:imageV];
    
    // 指针
    CALayer *needleLayer = [CALayer layer];
    // 设置锚点位置
    needleLayer.anchorPoint = CGPointMake(0.5, (98-20)/98.f);
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    // 锚点在父视图上面的位置
    needleLayer.position = CGPointMake(w*0.5, (h-36)/2.f+36);
    // bounds
    needleLayer.bounds = CGRectMake(0, 0, Fit(39.5), Fit(98));
    // 添加图片
    needleLayer.contents = (id)[UIImage imageNamed:@"zz"].CGImage;
    [self.layer addSublayer:needleLayer];
    needleLayer.transform = CATransform3DMakeRotation(-0.75*M_PI, 0, 0, 1);
    _needleLayer = needleLayer;
    
}

@end
