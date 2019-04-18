//
//  JYActionSheet.h
//  JYLab
//
//  Created by 李佳育 on 2017/5/7.
//  Copyright © 2017年 JY. All rights reserved.
//  中间可滑动的actionsheet

#import <UIKit/UIKit.h>

@interface JYSheetModel : NSObject
@property (nonatomic,   copy) NSString * title;
@end


@interface JYActionSheet : UIView

+ (JYActionSheet *)actionSheetWithTip:(NSString *)tip
                                   cancel:(NSString *)cancel
                                  options:(NSArray <JYSheetModel *>*)options
                            selectedIndex:(void (^)(NSInteger index))selectedIndex;
@end
