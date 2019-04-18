//
//  CyclePageTestController.m
//  LiftDemo
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "CyclePageTestController.h"
#import "TYCyclePagerView.h"
#import "TYCyclePagerViewCell.h"
#import "TYPageControl.h"

@interface CyclePageTestController ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@property (weak, nonatomic) IBOutlet UISwitch *horCenterSwitch;
@end

@implementation CyclePageTestController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}

///  初始化子控件
- (void)setupSubViews {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"CPTestView" owner:self options:nil] lastObject];
    view.frame = Rect(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:view];
    
    [self.view addSubview:self.pagerView];
    [self.pagerView addSubview:self.pageControl];
}

///  设置自定义导航条
- (void)setupNavigationBar {
    
}


#pragma mark - UI
- (TYCyclePagerView *)pagerView {
    if (!_pagerView) {
        TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
        pagerView.layer.borderWidth = 1;
        pagerView.isInfiniteLoop = YES;
        pagerView.autoScrollInterval = 3.0;
        pagerView.dataSource = self;
        pagerView.delegate = self;
        // registerClass or registerNib
        [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
        _pagerView = pagerView;
    }
    return _pagerView;
}

- (TYPageControl *)pageControl {
    if (!_pageControl) {
        TYPageControl *pageControl = [[TYPageControl alloc]init];
        pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
        pageControl.pageIndicatorSize = CGSizeMake(6, 6);
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - Actions
- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}


#pragma mark - Networking

#pragma mark - Delegate
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.8, CGRectGetHeight(pageView.frame)*0.8);
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = _horCenterSwitch.isOn;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}
#pragma mark - Private
- (IBAction)switchValueChangeAction:(UISwitch *)sender {
    if (sender.tag == 0) {
        _pagerView.isInfiniteLoop = sender.isOn;
        [_pagerView updateData];
    }else if (sender.tag == 1) {
        _pagerView.autoScrollInterval = sender.isOn ? 3.0:0;
    }else if (sender.tag == 2) {
        _pagerView.layout.itemHorizontalCenter = sender.isOn;
        [UIView animateWithDuration:0.3 animations:^{
            [_pagerView setNeedUpdateLayout];
        }];
    }
}

- (IBAction)sliderValueChangeAction:(UISlider *)sender {
    if (sender.tag == 0) {
        _pagerView.layout.itemSize = CGSizeMake(CGRectGetWidth(_pagerView.frame)*sender.value, CGRectGetHeight(_pagerView.frame)*sender.value);
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 1) {
        _pagerView.layout.itemSpacing = 30*sender.value;
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 2) {
        _pageControl.pageIndicatorSize = CGSizeMake(6*(1+sender.value), 6*(1+sender.value));
        _pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+sender.value), 8*(1+sender.value));
        _pageControl.pageIndicatorSpaing = (1+sender.value)*10;
    }
}

- (IBAction)buttonAction:(UIButton *)sender {
    _pagerView.layout.layoutType = sender.tag;
    [_pagerView setNeedUpdateLayout];
}

- (void)pageControlValueChangeAction:(TYPageControl *)sender {
    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
}
#pragma mark - Public

#pragma mark - Getter\Setter


@end
