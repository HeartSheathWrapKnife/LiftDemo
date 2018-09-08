//
//  SelectScrollMenu.m
//  XinCai
//
//  Created by Lostifor on 2017/8/22.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "SelectScrollMenu.h"
#import "NSString+Adaptive.h"

@interface SelectScrollMenu ()<UIScrollViewDelegate>
///  顶部视图
@property (nonatomic, strong) UIView * sliderView;
@property (nonatomic, strong) UIButton * topCurrentBtn;
///   当前分类 type index
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic,   weak) UIScrollView * topScrollView;


@property (nonatomic, strong) NSArray *titles;
//button数组
@property (nonatomic, strong) NSMutableArray <UIButton *>* items;
//button宽度数组
@property (nonatomic, strong) NSMutableArray * itemsWidth;
//被选中前面的宽度合（用于计算是否进行超过一屏，没有一屏则进行平分）
@property (nonatomic, assign) CGFloat selectedTitlesWidth;
//回调
@property (nonatomic,   copy) void (^selectedIndex)(NSInteger index);

//@property (nonatomic, strong) NSArray  <TransActionRecordModel *> * dateModels;

@end

@implementation SelectScrollMenu

- (void)layoutSubviews {
    [super layoutSubviews];
}
//- (void)loadScrollMenuWithDates:(NSArray <TransActionRecordModel *>*)dateModels itemWidth:(float)itemWidth selectedIndex:(void(^)(NSInteger index))index {
//    self.dateModels = dateModels;
//    self.selectedIndex = index;
//    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Fit(50))];
//    scrollView.backgroundColor = [UIColor whiteColor];
//    scrollView.delegate = self;
//    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
//    [scrollView setUserInteractionEnabled:YES];
//    scrollView.scrollsToTop = NO;
//    scrollView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:scrollView];
//
//    //初始化
//    float btnX = 0;
//    //添加顶部视图滑动按钮按钮
//    for (int i = 0 ; i < self.dateModels.count; i ++) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.titleColor = [UIColor lightGrayColor];
//        button.titleLabel.numberOfLines = 2;
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        button.title = [NSString stringWithFormat:@"%@\n%@",self.dateModels[i].date,self.dateModels[i].week];
//        button.rm_font = Fit(12);
//        [button addTarget:self action:@selector(sliderViewClick:)];
//        float btnWidth = [NSString calculateSizeWithString:button.title font:Fit(14)].width + Fit(20);
//        if (btnWidth < Fit(60)) btnWidth = Fit(60);//最小item宽度为60
//        if (itemWidth > Fit(60)) btnWidth = itemWidth;//如果是平分样式 则计算
//        button.frame = Rect(btnX, 0, btnWidth, Fit(50));
//        btnX += Fit(btnWidth);
//        if (i == self.currentIndex) {
//            button.selected = YES;
//            button.titleColor = TheamColor;
//            self.topCurrentBtn = button;
//            [UIView animateWithDuration:0.1 animations:^{
//                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
//            }];
//            CGFloat sliderWith = Fit(60);
//            UIView * sliderView = [UIView viewWithBgColor:TheamColor frame:Rect(0, 0, sliderWith, 2)];
//            [scrollView addSubview:sliderView];
//            sliderView.center = CGPointMake(CGRectGetMidX(button.frame), Fit(50) - 2);
//            self.sliderView = sliderView;
//        }
//        button.tag = 100 + i;
//        [scrollView addSubview:button];
//        [self.items addObject:button];
//        [self.itemsWidth addObject:[NSNumber numberWithFloat:btnWidth]];
//    }
//    //设置contensize
//    scrollView.contentSize = Size(btnX,0);
//    self.topScrollView = scrollView;
//
//}

//普通样式
- (void)loadScrollMenuWithTitles:(NSArray *)titles itemWidth:(float)itemWidth selectedIndex:(void(^)(NSInteger index))index {
    self.titles = titles;
    self.selectedIndex = index;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, Fit(35))];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setUserInteractionEnabled:YES];
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
    //初始化
    float btnX = 0;
    //添加顶部视图滑动按钮按钮
    for (int i = 0 ; i < self.titles.count; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleColor = [UIColor lightGrayColor];
        button.title = self.titles[i];
        button.rm_font = Fit(14);
        [button addTarget:self action:@selector(sliderViewClick:)];
        float btnWidth = [NSString calculateSizeWithString:button.title font:Fit(14)].width + Fit(20);
        if (btnWidth < Fit(60)) btnWidth = Fit(60);//最小item宽度为60
        if (itemWidth > Fit(60)) btnWidth = itemWidth;//如果是平分样式 则计算
        button.frame = Rect(btnX, 0, btnWidth, Fit(35));
        btnX += Fit(btnWidth);
        if (i == self.currentIndex) {
            button.selected = YES;
            button.titleColor = TheamColor;
            self.topCurrentBtn = button;
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            }];
            CGFloat sliderWith = Fit(60);
            UIView * sliderView = [UIView viewWithBgColor:TheamColor frame:Rect(0, 0, sliderWith, 2)];
            [scrollView addSubview:sliderView];
            sliderView.center = CGPointMake(CGRectGetMidX(button.frame), Fit(35) - 2);
            self.sliderView = sliderView;
        }
        button.tag = 100 + i;
        [scrollView addSubview:button];
        [self.items addObject:button];
        [self.itemsWidth addObject:[NSNumber numberWithFloat:btnWidth]];
    }
    //设置contensize
    scrollView.contentSize = Size(btnX,0);
    self.topScrollView = scrollView;
}


/**
 选中一个index

 @param index 选择的index
 */
- (void)scrollMenuChooseCurrentIndex:(NSInteger)index {
    self.topCurrentBtn.titleColor = [UIColor lightGrayColor];
    UIButton *button = self.items[index];
    button.selected = YES;
    [UIView animateWithDuration:0.1 animations:^{
        self.topCurrentBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    //设置选中标示
    self.currentIndex = button.tag - 100;
    //刷新视图
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }];
    //白条动画
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.center = CGPointMake(CGRectGetMidX(button.frame),  self.height - 2);
    }];
    self.topCurrentBtn = button;
    self.topCurrentBtn.titleColor = TheamColor;
    [self scrollToRightPosition];
}



#pragma mark 滑条滑动事件
- (void)sliderViewClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender == self.topCurrentBtn) {
        return;
    }
    self.topCurrentBtn.titleColor = [UIColor lightGrayColor];
    [UIView animateWithDuration:0.1 animations:^{
        self.topCurrentBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    //设置选中标示
    self.currentIndex = sender.tag - 100;
    //刷新视图
    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }];
    //白条动画
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.center = CGPointMake(CGRectGetMidX(sender.frame),  self.height -2);
    }];
    self.topCurrentBtn = sender;
    self.topCurrentBtn.titleColor = TheamColor;
    [self scrollToRightPosition];
    BLOCK_SAFE_RUN(self.selectedIndex,sender.tag - 100);
}

- (void)scrollToRightPosition {
    //选中按钮 前面的宽度 与后面的宽度
    float frontW = 0;
    float backW = 0;
    for (int i = 0; i < self.itemsWidth.count; i ++) {
        if (i < self.currentIndex) {
            frontW += [self.itemsWidth[i] floatValue];
        } else {
            backW += [self.itemsWidth[i] floatValue];
        }
    }
    
    if ((frontW + backW) > ScreenWidth) {
        if (frontW > HalfScreenWidth && backW > HalfScreenWidth) {
            [UIView animateWithDuration:0.25 animations:^{
                self.topScrollView.contentOffset = Point(frontW - HalfScreenWidth, 0);
            }];
        }
        if (frontW > HalfScreenWidth && backW < HalfScreenWidth) {
            [UIView animateWithDuration:0.25 animations:^{
                self.topScrollView.contentOffset = Point(frontW+backW - ScreenWidth, 0);
            }];
        }
        if (frontW < HalfScreenWidth) {
            [UIView animateWithDuration:0.25 animations:^{
                self.topScrollView.contentOffset = Point(0, 0);
            }];
        }
    }
    
    
}


- (NSArray *)titles {
    JYLazyArray(_titles);
}

//- (NSArray<TransActionRecordModel *> *)dateModels {
//    JYLazyArray(_dateModels);
//}

- (NSMutableArray <UIButton *>*)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)itemsWidth {
    if (!_itemsWidth) {
        _itemsWidth = [NSMutableArray array];
    }
    return _itemsWidth;
}

@end
