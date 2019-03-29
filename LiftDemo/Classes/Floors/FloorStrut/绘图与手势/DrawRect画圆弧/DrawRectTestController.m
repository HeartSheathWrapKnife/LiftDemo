//
//  DrawRectTestController.m
//  LiftDemo
//
//  Created by apple on 2019/3/26.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "DrawRectTestController.h"
#import "DrawTestView.h"

@interface DrawRectTestController ()

@end

@implementation DrawRectTestController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

///  初始化子控件
- (void)setupSubViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    DrawTestView *view = [[DrawTestView alloc] initWithFrame:Rect(0, 0, kScreenWidth, 150)];
    [scrollView addSubview:view];
    //虚线
    DashLineView *dashLine = [[DashLineView alloc] initWithFrame:Rect(0, view.maxY, kScreenWidth, 150)];
    [scrollView addSubview:dashLine];
    //图片
    DrawImageView *drawImgView = [[DrawImageView alloc] initWithFrame:Rect(0, dashLine.maxY, kScreenWidth, 300)];
    drawImgView.borderColor = [UIColor blackColor];
    drawImgView.borderWidth = 1;
    [scrollView addSubview:drawImgView];
    //椭圆
    EllipseView *ellipseView = [[EllipseView alloc] initWithFrame:Rect(0, drawImgView.maxY, kScreenWidth, 500)];
    [scrollView addSubview:ellipseView];
    //扇形
    FanView *fanView = [[FanView alloc] initWithFrame:Rect(0, ellipseView.maxY, kScreenWidth, 500)];
    [scrollView addSubview:fanView];
    //圆
    CircleView *circleView = [[CircleView alloc] initWithFrame:Rect(0, fanView.maxY, kScreenWidth, 300)];
    [scrollView addSubview:circleView];
    //弧
    ArcView *arcView = [[ArcView alloc] initWithFrame:Rect(0, circleView.maxY, kScreenWidth, 500)];
    [scrollView addSubview:arcView];
    scrollView.contentSize = CGSizeMake(0, [scrollView.subviews lastObject].maxY);
}



///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"rect";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark - UI

#pragma mark - Actions


#pragma mark - Networking

#pragma mark - Delegate



#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
