//
//  NSString+Category.h
//  AFN
//
//  Created by seven on 15/5/15.
//  Copyright (c) 2015年 toocms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

/**
 *  将长数字以3位用逗号隔开表示（例如：18000 -> 18,000）
 *
 *  @param numberString 数字字符串 （例如：@"124234")
 *
 *  @return 以3位用逗号隔开的数字符串（例如：124,234）
 */
+ (NSString *)formatNumber:(NSString *)numberString;
- (NSString *)formatNumber;

/** md5加密 */
- (NSString *)MD5String;
+ (NSString *)MD5String:(NSString *)string;

/** 移除html标签 */
+ (NSString *)removeHTML:(NSString *)html;
+ (NSString *)removeHTML2:(NSString *)html;

//验证是否有效银行卡
+ (BOOL)validateBankCard:(NSString *)bankCard;

//验证IP合法性
+ (BOOL)validateIP:(NSString *)IP;
- (BOOL)isValidIP;

//验证url
+ (BOOL)validateUrl:(NSString *)url;
- (BOOL)validateUrl;

//验证全汉字
+ (BOOL)validateChinese:(NSString *)chinese;
- (BOOL)validateChinese;
/** 验证email */
+ (BOOL)validateEmail:(NSString *)email;
- (BOOL)validateEmail;

/** 手机号码验证 */
+ (BOOL)validateMobile:(NSString *)mobile;
- (BOOL)validateMobile;

/** 字符串是否包含特殊字符 */
- (BOOL)isIncludeSpecialCharact;

+ (BOOL) validateUserName:(NSString *)name;

/** (由英文、数字和下划线构成，6-18位，首字母只能是英文和数字) */
+ (BOOL)validatePassword:(NSString *)passWord;
- (BOOL)validatePassword;

/** (验证身份证号码-中国大陆) 简单版本 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
- (BOOL) validateIdentityCard;

//身份证验证 加权版本
+ (BOOL)validateIDCardNumber:(NSString *)value;
- (BOOL)validateIDCardNumber;

//字符包含 汉字
+ (BOOL)hasChinese:(NSString *)str;

/// 将int类型转成NSString
FOUNDATION_EXTERN NSString * stringWithInt(int number);
/// 将NSInteger类型转成NSString
FOUNDATION_EXTERN NSString * stringWithInteger(NSInteger number);
/// 将double类型转成NSString，默认2位小数
FOUNDATION_EXTERN NSString * stringWithDouble(double number);
/// 将double类型转成NSString并带上小数位数
FOUNDATION_EXTERN NSString * stringWithDoubleAndDecimalCount(double number, unsigned int count);


/**
 *  计算文字尺寸
 *
 *  @param aString     文字
 *  @param fontSize    文字大小
 *  @param stringWidth 所在控件的宽度
 *
 *  @return 文字尺寸
 */
+ (CGSize)getStringRect:(NSString*)aString fontSize:(CGFloat)fontSize width:(int)stringWidth;

/**
 *  计算文字尺寸
 *
 *  @param fontSize    文字大小
 *  @param stringWidth 所在控件的宽度
 *
 *  @return 文字尺寸
 */
- (CGSize)getStringRectWithfontSize:(CGFloat)fontSize width:(int)stringWidth;

+ (void)setLabellineSpacing:(UILabel *)label aString:(NSString *)content setLineSpacing:(CGFloat)LineSpacing;

/**
 *  根据字符串长度计算label的尺寸
 *
 *  @param text     要计算的字符串
 *  @param fontSize 字体大小
 *  @param maxSize  label允许的最大尺寸
 *
 *  @return label的尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

//保留几位小数
+ (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV;

+ (NSString *)decimalwithFloatV:(float)floatV;

+ (NSString *)KGFormatScale:(id)scale;

@end
