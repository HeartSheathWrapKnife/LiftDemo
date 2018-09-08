//
//  UIVew+SL.m
//  SPAHOME
//
//  Created by 吕超 on 15/4/7.
//  Copyright (c) 2015年 TooCMS. All rights reserved.
//
#import "UIView+Extension.h"
#import <objc/runtime.h>

#pragma mark - UIView (Extension)

static NSString * const kCornerRadiusKey = @"cornerRadius";
static NSString * const kBorderColorKey = @"borderColorKey";


@implementation UIView (Extension)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)halfWidth {
    return CGRectGetWidth(self.frame) * 0.5;
}

- (CGFloat)halfHeight {
    return CGRectGetHeight(self.frame) * 0.5;
}

- (CGFloat)cornerRadius {
    return [objc_getAssociatedObject(self, &kCornerRadiusKey) floatValue];
}


- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    objc_setAssociatedObject(self, &kCornerRadiusKey, @(cornerRadius), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setCornerRadius:(CGFloat)cornerRadius rounding:(UIRectCorner)rounding {
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rounding cornerRadii:Size(cornerRadius, cornerRadius)];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, &kBorderColorKey);
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    objc_setAssociatedObject(self, &kBorderColorKey, borderColor, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setBorderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.borderWidth = bWidth;
    self.borderColor = bColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)bWidth borderColor:(UIColor *)bColor {
    self.cornerRadius = cornerRadius;
    [self setBorderWidth:bWidth borderColor:bColor];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (void)setMaxX:(CGFloat)maxX {
    self.x = maxX - CGRectGetWidth(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {
    self.y = maxY - CGRectGetHeight(self.frame);
}

- (void)setMaxOrigin:(CGPoint)maxOrigin {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(maxOrigin.x - CGRectGetWidth(self.frame), maxOrigin.y - CGRectGetHeight(self.frame));
    self.frame = frame;
}

- (CGPoint)maxOrigin {
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
}

- (CGFloat)getLastSubViewY {
    return self.subviews.lastObject.maxY;
}
- (void)sl_removeAllSubViews {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
}

+ (instancetype)viewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame {
    UIView * view = [[UIView alloc] initWithFrame:frame];
    if (!bgColor) {
        view.backgroundColor = [UIColor clearColor];
    } else {
        view.backgroundColor = bgColor;
    }
    return view;
}
+ (instancetype)creatView { return nil; }
///  从xib中加载和类名一样的xib
+ (instancetype)creatViewFromNib {
    return [self creatViewFromNibName:NSStringFromClass([self class]) atIndex:0];
}

+ (instancetype)creatViewFromNibName:(NSString *)aName atIndex:(NSInteger)index {
//    return _creatViewFromNibNameWithCache(aName, index);
    return [[[NSBundle mainBundle] loadNibNamed:aName owner:nil options:nil] objectAtIndex:index];
}

CGRect defaultRect() {
    return CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
}
///  找到view的控制器：返回view所加载在的控制器
- (UIViewController *)sl_viewController {
    for (UIView * superView = [self superview]; superView; superView = superView.superview) {
        UIResponder *nextResponder = [superView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end


#pragma mark - UILabel (Extension)
@implementation UILabel (Extension)

+ (instancetype)labelWithText:(NSString *)text font:(CGFloat)fontSize textColor:(UIColor *)color frame:(CGRect)frame {
    UILabel * label = [[self alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    if (text) label.text = text;
    if (color) label.textColor = color;
    return label;
}
@end


#pragma mark - UIImageView
@implementation UIImageView (Extension)

+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
//    NSAssert(image != nil, @"图片不能为空");
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setImage:image];
    return imageView;
}

+ (instancetype)imageViewWithUrl:(NSURL *)url frame:(CGRect)frame {
    
    return [self imageViewWithUrl:url placeHolder:nil frame:frame];
}

+ (instancetype)imageViewWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder frame:(CGRect)frame {
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView sd_setImageWithURL:url placeholderImage:placeHolder];
    return imageView;
}

@end

#pragma mark - UIScrollView
@implementation UIScrollView (Extension)

+ (instancetype)defaultScrollView {
    return [self scrollViewWithBgColor:nil frame:Rect(0, 64, kScreenWidth, kScreenHeight - 64)];
}

+ (instancetype)scrollViewWithBgColor:(UIColor *)bgColor frame:(CGRect)frame {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (bgColor) {
        scrollView.backgroundColor = bgColor;
    } else {
        scrollView.backgroundColor = [UIColor clearColor];
    }
    return scrollView;
}


@end



