//
//  MainViewController.m
//  XinCai
//
//  Created by Lostifor on 17/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "HallController.h"
#import "MineViewController.h"
#import "FloorsController.h"


@interface MainViewController ()

@end


@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController {
    RMTabBar *_rm;
}

#pragma mark - 初始化tabbaritem设置(字体颜色等)
+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = TheamColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupChildControllers];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    RMTabBar * tabBar = [RMTabBar new];
    _rm = tabBar;
    [tabBar setDidClickPlusBtnBlock:^{
        SLLog(@"click +");
    }];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setupChildControllers {
    
    NSArray *selectImages = @[@"笑-1", @"酷", @"开心-2", @"热恋"];
    NSArray *normalImages = @[@"面无表情", @"面无表情", @"面无表情", @"面无表情"];
    NSArray *title = @[@"Hall",@"Floors",@"ToDoList",@"Mine"];
    
    HallController * controller1 = [[HallController alloc] init];
    FloorsController * controller2 = [[FloorsController alloc] init];
    MineViewController * controller3 = [[MineViewController alloc] init];
    MineViewController * controller4 = [[MineViewController alloc] init];
    NSArray * array = @[controller1, controller2, controller3, controller4];
    
    for (int i = 0; i < title.count; i++) {
        [self setupChildVc:array[i] title:title[i] image:normalImages[i] selectedImage:selectImages[i]];
    }
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    UIImage * no = [UIImage imageNamed:image];
    vc.tabBarItem.image = [no imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * sel = [UIImage imageNamed:selectedImage];
    vc.tabBarItem.selectedImage = [sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem * item = vc.tabBarItem;
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : HexColorInt32_t(999999)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : TheamColor} forState:UIControlStateSelected];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end


@implementation RMTabBar {
    UIButton * _plusBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    _plusBtn = btn;
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    [btn addSubview:img];
    img.image = [UIImage imageNamed:@"22btn_and"];
    img.tag = -1;
    
    [btn addTarget:self action:@selector(_didClickPlusBtn:)];

    self.backgroundImage = [UIImage imageWithColor:HexColorInt32_t(FFFFFF) size:CGSizeMake(ScreenWidth, 49)];
    self.translucent = NO;
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger i = 0;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 5;
    CGFloat h = 49;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            NSInteger c = 0;
            if (i > 1) {
                c++;
            }
            view.frame = CGRectMake((i + c) * width, 0, width, h);
            i++;
            
        } else if (view == _plusBtn) {


            view.frame = CGRectMake(2 * width, 0, width, 49);
            UIImageView * imageV = [view viewWithTag:-1];
            imageV.center = CGPointMake(width / 2, 49 / 2);
        }
    }
}

- (void)_didClickPlusBtn:(UIButton *)btn {
    BLOCK_SAFE_RUN(self.didClickPlusBtnBlock);
}
@end
