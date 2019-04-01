//
//  JYCustomAlert.h
//  LiftDemo
//
//  Created by apple on 2019/3/29.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HandleBlock)(_Nullable id obj);

@interface JYCustomAlert : UIView
+ (void)alertWithCustomViewHandle:(HandleBlock)handle;
@end

NS_ASSUME_NONNULL_END