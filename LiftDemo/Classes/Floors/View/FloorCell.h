//
//  FloorCell.h
//  LiftDemo
//
//  Created by Lostifor on 2018/9/9.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "FloorModel.h"

@interface FloorCell : BaseTableViewCell
@property (nonatomic, strong) FloorModel * model;
@end