//
//  UIView+Dashed.h
//  RideMoto
//
//  Created by Eleven on 17/1/3.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, lineType) {
    lineTypeHorizontal, // 横线
    lineTypeVertical // 竖线
};

@interface UIView (Dashed)

/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 ** lineType:   虚线的类型（横/竖）
 **/

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineType:(lineType)type;

@end
