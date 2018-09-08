//
//  EmptyView.m
//  KCWC
//
//  Created by Seven on 2017/5/22.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

+ (instancetype)emptyViewWithTitle:(NSString *)title frame:(CGRect)frame {
    EmptyView * view = [[EmptyView alloc] initWithFrame:frame];
    view.backgroundColor = HexColorInt32_t(F8F8F8);
    UIImageView * imageView = [UIImageView imageViewWithImage:ImageWithName(@"emptyView") frame:CGRectMake(0, 0, Fit(200), Fit(125))];
    [view addSubview:imageView];
    imageView.centerX = frame.size.width * 0.5;
    imageView.centerY = frame.size.width * 0.5;
    UILabel * titleLabel = [UILabel labelWithText:title font:Fit(12) textColor:HexColorInt32_t(999999) frame:CGRectZero];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    titleLabel.centerX = imageView.centerX;
    titleLabel.y = imageView.maxY + Fit(30);
    
    return view;
}
@end
