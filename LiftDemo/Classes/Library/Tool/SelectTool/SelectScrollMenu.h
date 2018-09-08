//
//  SelectScrollMenu.h
//  XinCai
//
//  Created by Lostifor on 2017/8/22.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  横向滑动栏

#import <UIKit/UIKit.h>
//#import "HistoryModel.h"


@interface SelectScrollMenu : UIView

/**
 普通 title文字样式

 @param titles titles
 @param itemWidth   item宽度
 @param index 当前index
 */
- (void)loadScrollMenuWithTitles:(NSArray *)titles itemWidth:(float)itemWidth selectedIndex:(void(^)(NSInteger index))index;

/**
 选取一个index
 */
- (void)scrollMenuChooseCurrentIndex:(NSInteger)index;


//- (void)loadScrollMenuWithDates:(NSArray <TransActionRecordModel *>*)dateModels itemWidth:(float)itemWidth selectedIndex:(void(^)(NSInteger index))index;

@end
