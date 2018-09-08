//
//  UIView+Filter.h
//  RideMoto
//
//  Created by Eleven on 16/12/28.
//  Copyright © 2016年 TGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Filter)

@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, assign) BOOL isShow;

- (void)showMenu;
- (void)dismissMenu;

@end
