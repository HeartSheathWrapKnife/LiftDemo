//
//  JYSliderControl.h
//  JYSliderControlDemo
//
//  Created by Lostifor on 2018/3/31.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYSliderControl;
@protocol JYSliderControlDelegate <NSObject>
@optional
//滑条值改变
- (void)sliderValueChanging:(JYSliderControl *)slider;
//滑条值改变结束
- (void)sliderValueChanged:(JYSliderControl *)slider;
@end

@interface JYSliderControl : UIView
//滑动器当前的滑动值
@property (nonatomic, assign) CGFloat value;
//显示的提示文字
@property (nonatomic, copy) NSString *text;
//文字font
@property (nonatomic, strong) UIFont *font;
//滑动触发器开始显示的图片
@property (nonatomic, strong) UIImage *thumbImage;
//滑动触发器结束显示的图片
@property (nonatomic, strong) UIImage *finishImage;
//滑动触发器是否隐藏
@property (nonatomic, assign) BOOL thumbHidden;
//滑动触发器是否回弹
@property (nonatomic, assign) BOOL thumbBack;
//协议
@property (nonatomic, weak) id<JYSliderControlDelegate> delegate;

//设置当前滑动值
- (void)setSliderValue:(CGFloat)value;

//设置滑动值以及完成回调
- (void)setSliderValue:(CGFloat)value animation:(BOOL)animation completion:(void(^)(BOOL finish))completion;

//设置滑动背景颜色 滑动触发器颜色 boder颜色 文字颜色
- (void)setColorForBackgroud:(UIColor *)backgroud foreground:(UIColor *)foreground thumb:(UIColor *)thumb border:(UIColor *)border textColor:(UIColor *)textColor;

//设置滑动起始图片和结束图片
- (void)setThumbBeginImage:(UIImage *)beginImage finishImage:(UIImage *)finishImage;

//移除圆角
- (void)removeRoundCorners:(BOOL)corners border:(BOOL)border;
@end
