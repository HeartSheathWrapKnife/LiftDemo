//
//  CAShapeLayer+Draw.m
//  RideMoto
//
//  Created by Eleven on 16/12/29.
//  Copyright © 2016年 TGF. All rights reserved.
//

#import "CAShapeLayer+Draw.h"

@implementation CAShapeLayer (Draw)

+ (CAShapeLayer *)drawWithPath:(UIBezierPath *)path strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    return shapeLayer;
}

+ (CAShapeLayer *)drawCycleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle cneter:(CGPoint)center lineToPoint:(CGPoint)point radius:(CGFloat)radius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:center];
    [path addLineToPoint:point];
    
    CAShapeLayer *shapeLayer = [self drawWithPath:path strokeColor:strokeColor fillColor:fillColor];
    return shapeLayer;
}

@end
