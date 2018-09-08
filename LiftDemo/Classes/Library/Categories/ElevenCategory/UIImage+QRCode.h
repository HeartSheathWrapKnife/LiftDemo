//
//  UIImage+QRCode.h
//  RideMoto
//
//  Created by Eleven on 17/1/3.
//  Copyright © 2017年 TGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

// 二维码
+ (UIImage *)creatQRCodeWithData:(NSString *)dataStr imageViewWidth:(CGFloat)size;
// 条形码
+ (UIImage *)creatBarCodeWithData:(NSString *)dataStr imageViewSize:(CGSize)size;

@end
