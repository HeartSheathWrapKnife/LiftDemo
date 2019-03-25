//
//  FloorCell.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "FloorCell.h"

@interface FloorCell()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *desc;

@end

@implementation FloorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self rm_fitAllConstraint];
}

- (void)setModel:(FloorModel *)model {
    _model = model;
    self.name.text = model.title;
    self.desc.text = model.desc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
