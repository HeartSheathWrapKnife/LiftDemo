//
//  UITextField+PlaceHolder.m
//  PocketJC
//
//  Created by Seven Lv on 16/10/1.
//  Copyright © 2016年 CHY. All rights reserved.
//

#import "UITextField+PlaceHolder.h"

@implementation UITextField (PlaceHolder)

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (!self.placeholder) {
        return;
    }
    // 创建一个富文本对象
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = placeholderColor;
    // 设置UITextField的占位文字
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
//    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor {
    return nil;
}
@end
