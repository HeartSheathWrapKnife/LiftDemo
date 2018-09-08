//
//  AESTool.h
//  SLBet
//
//  Created by Lostifor on 2018/5/10.
//  Copyright © 2018年 lostifor. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define AES_KEY @"YpKQGXV3FQ4NR41vnQC36ZJT"

@interface AESTool : NSObject
///*
// *  对data加密
// *  @param data 需要加密的数据
// *  @return 加密后的数据
// */
//+ (NSData *)aes256EncryptWithData:(NSData *)data;
//
///**
// *  对data解密
// *  @param data 需要解密的数据
// *  @return 解密后的数据
// */
//+ (NSData *)aes256DecryptWithData:(NSData *)data;
//
///**
// *  对字符串加密
// *  @param string 需要加密的字符串
// *  @return 加密后的数据
// */
//+ (NSData*)aes256EncryptWithString:(NSString*)string;
//
///**
// *  解密
// *  @param data 需要解密的数据
// *  @return 解密后的字符串
// */
//+ (NSString*)aes256DecryptStringWithData:(NSData *)data;
//
////加密
//+ (NSString *)hyb_AESEncrypt:(NSString *)plainText password:(NSString *)key;
////解密
//+ (NSString *)hyb_AESDecrypt:(NSString *)encryptText password:(NSString *)key;

+(NSString *)AES128Encrypt:(NSString *)plainText;

+(NSString *)AES128Decrypt:(NSString *)encryptText;

@end
