//
//  UIButton+EnlargeEdge.h
//  UIButton扩展响应区域
//
//  Created by Eleven on 16/10/10.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

/**
 *  同时向按钮的四个方向延伸相应区域
 *
 *  @param size 间距
 */
- (void)setEnlargeEdge:(CGFloat)size;

/**
 *  向按钮的四个方向延伸响应面积
 *
 *  @param top    上间距
 *  @param left   左间距
 *  @param bottom 下间距
 *  @param right  右间距
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;

@end
