//
//  UIButton+SL.m
//  Sushi
//
//  Created by losifor on 15/5/8.
//  Copyright (c) 2015年 losifor. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "UIButton+Extension.h"
//#import "YYTextWeakProxy.h"
#import "YYWeakProxy.h"

@implementation UIButton (Extension)
- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
- (NSString *)title {
    return self.currentTitle;
}
- (void)setImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
}
- (id)image {
    return self.currentImage;
}

-(void)addTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
- (UIColor *)titleColor {
    return self.currentTitleColor;
}
- (id)highlightImage {
    return nil;
}
- (void)setHighlightImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    }
}
- (id)selectImage {
    return nil;
}
- (void)setSelectImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    }
}
- (CGFloat)titleFont {
    return 0;
}
- (void)setTitleFont:(CGFloat)titleFont {
    self.titleLabel.font = [UIFont systemFontOfSize:titleFont];
}
- (UIColor *)selectTitleColor {
    return nil;
}
- (void)setSelectTitleColor:(UIColor *)selectTitleColor {
    [self setTitleColor:selectTitleColor forState:UIControlStateSelected];
}
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor font:(CGFloat)fontSize image:(NSString *)imageName frame:(CGRect)frame {
    return [self buttonWithTitle:title titleColor:titleColor backgroundColor:bgColor font:fontSize image:imageName target:nil action:nil frame:frame];
}

+ (instancetype)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)bgColor
                         font:(CGFloat)fontSize
                        image:(NSString *)imageName
                       target:(id)target
                       action:(SEL)action
                        frame:(CGRect)frame {
    
    UIButton * button = [[self alloc] initWithFrame:frame];
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    if (title) button.title = title;
    if (titleColor) button.titleColor = titleColor;
    if (bgColor) button.backgroundColor = bgColor;
    if (fontSize) button.titleFont = fontSize;
    if (imageName) {
        button.image = imageName;
        button.contentMode = UIViewContentModeCenter;
    }
    if (target && action) {
        [button addTarget:target action:action];
    }
    return button;
}

- (void)countDownWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle backgroundColor:(UIColor *)mColor disabledColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (![self superview]) {
            dispatch_source_cancel(_timer);
            return ;
        }
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            NSInteger seconds = timeOut;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    
    
}

+ (void)setBtnMidleStyle:(UIButton *)sender margin:(CGFloat)margin{
    if (sender.imageView == nil || sender.titleLabel == nil) {
        return;
    }
    CGFloat imageWidth = sender.imageView.frame.size.width;
    CGFloat imageHeight = sender.imageView.frame.size.height;
    CGFloat titleWidth = sender.titleLabel.frame.size.width;
    CGFloat titleHeight = sender.titleLabel.frame.size.height;
    margin = margin?margin:5;
    sender.imageEdgeInsets = UIEdgeInsetsMake(-titleHeight-margin/2, 0, 0, -titleWidth);
    sender.titleEdgeInsets = UIEdgeInsetsMake(imageHeight+margin/2, -imageWidth, 0, 0);
}

@end
