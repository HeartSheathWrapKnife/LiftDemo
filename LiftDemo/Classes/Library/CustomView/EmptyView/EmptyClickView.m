//
//  EmptyClickView.m
//  KCWC
//
//  Created by Eleven on 2017/6/14.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import "EmptyClickView.h"

@interface EmptyClickView ()

@property (nonatomic,   copy) void (^clickBlock)(void);

@end

@implementation EmptyClickView

+ (instancetype)emptyViewWithTitle:(NSString *)title clickTitle:(NSString *)clickTitle frame:(CGRect)frame clik:(void (^)(void))clickBlcok {
    EmptyClickView * view = [[EmptyClickView alloc] initWithFrame:frame];
    view.backgroundColor = HexColorInt32_t(F8F8F8);
    UIImageView * imageView = [UIImageView imageViewWithImage:ImageWithName(@"ic_default_no_data") frame:CGRectMake(0, Fit(60), Fit(85), Fit(79))];
    [view addSubview:imageView];
    imageView.centerX = frame.size.width * 0.5;
    
    UILabel * titleLabel = [UILabel labelWithText:title font:Fit(12) textColor:HexColorInt32_t(999999) frame:CGRectZero];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    titleLabel.centerX = imageView.centerX;
    titleLabel.y = imageView.maxY + Fit(30);
    
    UIButton * clickBtn = [UIButton buttonWithTitle:clickTitle titleColor:[UIColor whiteColor] backgroundColor:[UIColor groupTableViewBackgroundColor] font:Fit(16) image:nil target:view action:@selector(click) frame:CGRectZero];
    [view addSubview:clickBtn];
    clickBtn.centerX = view.centerX;
    clickBtn.y = titleLabel.maxY + Fit(18);
    clickBtn.width = Fit(120);
    clickBtn.height = Fit(40);
    clickBtn.cornerRadius = Fit(4);
    
    view.clickBlock = clickBlcok;
    
    return view;
}

- (void)click {
    BLOCK_SAFE_RUN(self.clickBlock);
}

@end
