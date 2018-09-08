//
//  SelectTool.m
//  XinCai
//
//  Created by Lostifor on 17/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "SelectTool.h"
#import "SelectToolCell.h"
#import "SelectToolModel.h"

@interface SelectTool ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,   copy) void(^selectedBlcok)(NSInteger index);
@property (nonatomic,   copy) void(^cancelBlcok)(void);
@property (nonatomic, strong) NSArray * array;
@property (nonatomic,   weak) UIView * mask;
@property (nonatomic,   weak) UIView * navMask;
@property (nonatomic, assign) NSInteger highLightNum;
@property (nonatomic, strong) NSMutableArray <SelectToolModel *>* listArr;
@property (nonatomic,   weak) UICollectionView * collectionView;
@end

@implementation SelectTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //下部灰色蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = Rect(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight);
        view.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        self.mask = view;
        [self addSubview:view];
        //顶部透明蒙版
        UIView *navMask = [[UIView alloc] init];
        navMask.frame = Rect(0, 0, ScreenWidth, SafeAreaTopHeight);
        navMask.backgroundColor = [UIColor clearColor];
        self.navMask = navMask;
        [self addSubview:navMask];
        
        
        //collectionView
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        float margin = 4;
        float itemWH = (kScreenWidth - 5 * margin) / 4;
        layout.itemSize = CGSizeMake(itemWH, itemWH/2);
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth ,Fit(176)) collectionViewLayout:layout];
        collectionView.alwaysBounceVertical = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.collectionView = collectionView;
        [self addSubview:collectionView];
        [collectionView registerClass:[SelectToolCell class] forCellWithReuseIdentifier:@"SelectToolCell"];
    }
    return self;
}


/**
 配置数据模型
 */
- (void)configListModel {
    for (int i = 0; i < self.array.count; i ++) {
        SelectToolModel *model = [SelectToolModel new];
        model.title = self.array[i];
        model.selected = NO;
        if (i == self.highLightNum) {
            model.selected = YES;
        }
        [self.listArr addObject:model];
    }
    [self.collectionView reloadData];
}


+ (SelectTool *)selectToolShowLoadArray:(NSArray *)array HighLigtIndex:(NSInteger)num SelectedIndex:(void (^)(NSInteger))index Cancel:(void (^)())cancel {
    //加载
    SelectTool *tool = [[SelectTool alloc] initWithFrame:Rect(0, 0, ScreenWidth, ScreenHeight)];
    //赋值
    tool.array = array;
    tool.selectedBlcok = index;
    tool.cancelBlcok = cancel;
    tool.highLightNum = num;
    [tool configListModel];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:tool];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:tool action:@selector(cancelBtnAction)];
    [tool.mask addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:tool action:@selector(cancelBtnAction)];
    [tool.navMask addGestureRecognizer:tap2];
    
    return tool;
}

/// 取消
- (void)cancelBtnAction {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        //取消
        [self removeFromSuperview];
        BLOCK_SAFE_RUN(self.cancelBlcok);
    }];
}

/// 确定
- (void)sureBtnAction:(NSInteger)index {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        //确定
        [self removeFromSuperview];
        BLOCK_SAFE_RUN(self.selectedBlcok,index);
    }];
}

- (void)selectToolChooseIndex:(NSInteger)index {
    for (SelectToolModel *model in self.listArr) {
        model.selected = NO;
    }
    self.listArr[index].selected = YES;
    [self sureBtnAction:index];
}


#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectToolCell" forIndexPath:indexPath];
    cell.model = self.listArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (SelectToolModel *model in self.listArr) {
        model.selected = NO;
    }
    self.listArr[indexPath.item].selected = YES;
    [self sureBtnAction:indexPath.item];
}



- (NSMutableArray <SelectToolModel *>*)listArr {
    JYLazyMutableArray(_listArr);
}

@end
