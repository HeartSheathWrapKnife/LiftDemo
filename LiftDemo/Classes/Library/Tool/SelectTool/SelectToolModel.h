//
//  SelectToolModel.h
//  XinCai
//
//  Created by Lostifor on 17/8/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//  tool模型

#import <Foundation/Foundation.h>

@interface SelectToolModel : NSObject
//标题
@property (nonatomic,   copy) NSString * title;
//是否选中
@property (nonatomic, assign ,getter=isSelected) BOOL selected;
@end
