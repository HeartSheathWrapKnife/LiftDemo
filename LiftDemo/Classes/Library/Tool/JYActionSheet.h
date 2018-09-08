//
//  JYActionSheet.h
//  JYLab
//
//  Created by 李佳育 on 2017/5/7.
//  Copyright © 2017年 JY. All rights reserved.
//  中间可滑动的actionsheet

#import <UIKit/UIKit.h>

@interface JYActionSheet : UIView

/**
 创建actionsheet

 @param tip 提示信息
 @param cancel 取消提示文字
 @param options 选项列表
 @param selectedIndex 选择的index
 */
+ (JYActionSheet *)actionSheetWithTip:(NSString *)tip cancel:(NSString *)cancel options:(NSArray *)options selectedIndex:(void(^)(NSInteger))selectedIndex;
@end
