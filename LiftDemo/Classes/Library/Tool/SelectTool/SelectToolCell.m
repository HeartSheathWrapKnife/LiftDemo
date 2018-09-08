//
//  SelectToolCell.m
//  XinCai
//
//  Created by Lostifor on 17/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "SelectToolCell.h"

@interface SelectToolCell ()
@property (nonatomic,   weak) UILabel * label;
@end

@implementation SelectToolCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    //init
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    [self addSubview:label];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //frame
    self.label.frame = Rect(Fit(4), Fit(5), Fit(78), Fit(40));
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:Fit(15)];
    self.label.adjustsFontSizeToFitWidth = YES;
    self.label.backgroundColor = HexColorInt32_t(F2F2F2);
    
//    self.label.borderWidth = 1;
    self.label.cornerRadius = Fit(3);
}

- (void)setModel:(SelectToolModel *)model {
    _model = model;
    self.label.text = model.title;
    if (model.isSelected) {
        self.label.textColor = HexColorInt32_t(F2643C);
//        self.label.borderColor = HexColorInt32_t(F2643C);
    } else {
        self.label.textColor = [UIColor blackColor];
//        self.label.borderColor = [UIColor lightGrayColor];
    }
}



@end
