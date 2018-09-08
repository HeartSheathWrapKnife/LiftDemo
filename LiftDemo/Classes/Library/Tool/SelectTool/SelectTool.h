//
//  SelectTool.h
//  XinCai
//
//  Created by Lostifor on 17/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  选择工具

#import <UIKit/UIKit.h>

@interface SelectTool : UIView

/// 取消
- (void)cancelBtnAction;

/**
 选择彩种

 @param array 数据
 @param num   高亮index
 @param index 选中index
 @param cancel 取消
 */
+ (SelectTool *)selectToolShowLoadArray:(NSString *)array
                          HighLigtIndex:(NSInteger)num
                  SelectedIndex:(void(^)(NSInteger index))index
                                 Cancel:(void(^)(void))cancel;


- (void)selectToolChooseIndex:(NSInteger)index;
@end
