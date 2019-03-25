//
//  XCNavigationBar.m
//  XinCai
//
//  Created by Lostifor on 16/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "XCNavigationBar.h"
#import <objc/runtime.h>

/// 返回按钮图片
static NSString * BackButtonImageName = @"navItem_whiteBack";
///  标题文字大小
static CGFloat    TitleFont           = 18;
///  按钮文字大小
static CGFloat    ButtonFont          = 15;
typedef void (^ButtonClick)(void);

@interface XCNavigationBar ()
@property(nonatomic, copy)ButtonClick backBlock;
@property(nonatomic, copy)ButtonClick actionBlock;
@end

@implementation XCNavigationBar
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.size = Size(ScreenWidth, SafeAreaTopHeight);
        self.backgroundColor = TheamColor;
        // 分隔线
        UIView * diveder = [UIView new];
        diveder.frame = Rect(0, SafeAreaTopHeight - 0.5, ScreenWidth, 0.5);
        diveder.backgroundColor = [UIColor clearColor];
        [self addSubview:diveder];
        [self bringSubviewToFront:diveder];
        _diveder = diveder;
    }
    return self;
}

- (void)removeDivider {
    [_diveder removeFromSuperview];
}

- (instancetype)initWithTitle_sl:(NSString *)title right:(NSString *)right rightAction:(void (^)(void))action backAction:(void (^)(void))backAction {
    
    if (self = [super init]) {
        // 标题
        UILabel * label = [UILabel labelWithText:title font:Fit(TitleFont) textColor:ThemeTitleColor frame:Rect(45, StatusBarHeight + 1, ScreenWidth - 90, 42)];
        [self addSubview:label];
        self.titleLabel = label;
        label.textAlignment = NSTextAlignmentCenter;
        
        // 如果实现了右边的事件，会创建右边的按钮
        if (action) {
            UIImage * image = [UIImage rm_imageNamed:right];
            UIButton * btn = nil;
            if (image) {
                btn = [UIButton buttonWithTitle:nil titleColor:[UIColor whiteColor] backgroundColor:nil font:0 image:right frame:Rect(ScreenWidth - 40, StatusBarHeight, 44, 44)];
                CGFloat f = 10;
                btn.contentEdgeInsets = UIEdgeInsetsMake(f, f, f, f);
                btn.maxX = ScreenWidth - 7;
                [self addSubview:btn];
            } else {
                if (right.length) {
                    // 按钮
                    CGSize size = [NSString getStringRect:right fontSize:ButtonFont width:300];
                    btn = [UIButton buttonWithTitle:right titleColor:[UIColor whiteColor] backgroundColor:nil font:ButtonFont image:nil frame:Rect(ScreenWidth - 15 - size.width, StatusBarHeight, size.width, 30)];
                    [self addSubview:btn];
                }
            }
            
            btn.centerY = label.centerY;
            [btn addTarget:self action:@selector(btnClick)];
            self.actionBlock = action;
            self.rightButton = btn;
        } else {
            //            // 38btn_more
            //            UIButton * btn = [UIButton buttonWithTitle:nil titleColor:nil backgroundColor:nil font:0 image:[UIImage rm_imageNamed:@"38btn_more"] frame:Rect(ScreenWidth - 40, 0, 44, 44)];
            //            btn.maxX = ScreenWidth - 7;
            //            btn.centerY = label.centerY;
            //            [btn addTarget:self action:@selector(_btnClick)];
            //            [self addSubview:btn];
        }
        
        // 如果实现了返回的事件，才创建返回按钮
        if (backAction) {
            UIButton * back = [UIButton buttonWithTitle:nil titleColor:nil backgroundColor:nil font:ButtonFont image:BackButtonImageName frame:Rect(0, 12+ StatusBarHeight, 44, 44)];
            [back addTarget:self action:@selector(backClick)];
            CGFloat f = 11;
            back.contentEdgeInsets = UIEdgeInsetsMake(f, f + 5, f, f + 5);
            back.centerY = label.centerY;
            back.adjustsImageWhenHighlighted = NO;
            [self addSubview:back];
            self.backBlock = backAction;
            self.leftButton = back;
        }
        
    }
    return self;
}

#pragma mark - ButtonAction
- (void)btnClick {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

- (void)backClick {
    if (self.backBlock) {
        self.backBlock();
    }
}


- (void)_btnClick {
    //    BaseViewController * vc = (BaseViewController *)[self viewController];
    //    if ([vc respondsToSelector:@selector(didClickButtonAtIndex:)]) {
    //        NSInteger index = 0;
    //        id data = [vc didClickButtonAtIndex:index];
    //        if (index ==0 ) {
    //            // 分享
    //        } else if (index == 1){
    //            // 收藏
    //        } else {
    //
    //        }
    //    } else {
    //        SLLog(123);
    //    }
}

- (UIViewController *)viewController {
    for (UIView * superView = [self superview]; superView; superView = superView.superview) {
        UIResponder *nextResponder = [superView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setupToWhiteTheme {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = ThemeTitleColor;
    self.rightButton.titleColor = ThemeTitleColor;
    self.leftButton.image = [UIImage imageNamed:@"btn_back_gray"];
    [_diveder removeFromSuperview];
}

#pragma mark - 类方法
+ (instancetype)navWithTitle:(NSString *)title rightItem:(NSString *)rightItem rightAction:(void (^)(void))action {
    return [[self alloc] initWithTitle_sl:title right:rightItem rightAction:action backAction:nil];
}

+ (instancetype)navWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle_sl:title right:nil rightAction:nil backAction:nil];
}

+ (instancetype)navWithTitle:(NSString *)title backAction:(void (^)(void))backAction {
    return [[self alloc] initWithTitle_sl:title right:nil rightAction:nil backAction:backAction];
}

+ (instancetype)navWithTitle:(NSString *)title rightItem:(NSString *)rightItem rightAction:(void (^)(void))action backAction:(void (^)(void))backAction {
    return [[self alloc] initWithTitle_sl:title right:rightItem rightAction:action backAction:backAction];
}


@end


static const char NavgationBarkey = '\0';
@implementation UIViewController (NavigattionBar)

- (void)setXc_navgationBar:(XCNavigationBar *)xc_navgationBar {
    if (self.xc_navgationBar != xc_navgationBar) {
        [self.xc_navgationBar removeFromSuperview];
        [self.view addSubview:xc_navgationBar];
        objc_setAssociatedObject(self, &NavgationBarkey, xc_navgationBar, OBJC_ASSOCIATION_ASSIGN);
    }
}


- (XCNavigationBar *)xc_navgationBar {
    return objc_getAssociatedObject(self, &NavgationBarkey);
}




@end
