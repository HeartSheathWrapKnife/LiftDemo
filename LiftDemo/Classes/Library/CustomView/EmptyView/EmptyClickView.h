//
//  EmptyClickView.h
//  KCWC
//
//  Created by Eleven on 2017/6/14.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyClickView : UIView

+ (instancetype)emptyViewWithTitle:(NSString *)title clickTitle:(NSString *)clickTitle frame:(CGRect)frame clik:(void(^)(void))clickBlcok;

@end
