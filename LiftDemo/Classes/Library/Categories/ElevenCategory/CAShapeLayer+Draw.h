//
//  CAShapeLayer+Draw.h
//  RideMoto
//
//  Created by Eleven on 16/12/29.
//  Copyright © 2016年 TGF. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (Draw)

+ (CAShapeLayer *)drawWithPath:(UIBezierPath *)path strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;

+ (CAShapeLayer *)drawCycleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle cneter:(CGPoint)center lineToPoint:(CGPoint)point radius:(CGFloat)radius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;

@end
