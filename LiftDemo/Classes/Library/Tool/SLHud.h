//
//  SLHud.h
//  TKLUser
//
//  Created by Seven Lv on 16/11/17.
//  Copyright © 2016年 Seven Lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLHud : UIView

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;
+ (instancetype)hudWithTitle:(NSString *)title frame:(CGRect)frame;

#if FOUNDATION_SWIFT_SDK_EPOCH_AT_LEAST(8)
/// 快速创建一个默认样式的hud (不是单例对象)
@property (class, readonly, strong) SLHud * defaultHud;

#endif

@end
