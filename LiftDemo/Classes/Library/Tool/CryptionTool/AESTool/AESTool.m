//
//  AESTool.m
//  SLBet
//
//  Created by Lostifor on 2018/5/10.
//  Copyright © 2018年 lostifor. All rights reserved.
//

#import "AESTool.h"
#define gkey @"YpKQGXV3FQ4NR41vnQC36ZJT" //自行修改
#define gIv @"" //自行修改

@implementation AESTool

/*
 *  对data加密
 *  @param data 需要加密的数据
 *  @return 加密后的数据
 */
+ (NSData *)aes256EncryptWithData:(NSData *)data {
    
//    if (!AES_KEY || AES_KEY.length !=16) {
//        
//        NSLog(@"key length must be 16");
//        
//        return nil;
//        
//    }
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [AES_KEY getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = data.length;
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          data.bytes, dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}

/**
 *  对data解密
 *  @param data 需要解密的数据
 *  @return 解密后的数据
 */
+ (NSData *)aes256DecryptWithData:(NSData *)data {
    
//    if (!AES_KEY || AES_KEY.length !=16) {
//
//        NSLog(@"key length must be 16");
//
//        return nil;
//
//    }
    
    char keyPtr[kCCKeySizeAES256+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [AES_KEY getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = data.length;
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          data.bytes, dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}

/**
 *  对字符串加密
 *  @param string 需要加密的字符串
 *  @return 加密后的数据
 */
+ (NSData*)aes256EncryptWithString:(NSString*)string {
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [self aes256EncryptWithData:data];
    
    return encryptedData;
    
}

/**
 *  解密
 *  @param data 需要解密的数据
 *  @return 解密后的字符串
 */
+ (NSString*)aes256DecryptStringWithData:(NSData *)data {
    
    NSData *decryData = [self aes256DecryptWithData:data];
    
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    
    return string;
    
}


+ (NSString *)hyb_AESEncrypt:(NSString *)plainText password:(NSString *)key {
    char keyPtr[kCCKeySizeAES128+1];
    
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = data.length;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          
                                          keyPtr, kCCBlockSizeAES128,
                                          
                                          NULL,
                                          
                                          data.bytes, dataLength,
                                          
                                          buffer, bufferSize,
                                          
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess){
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        NSString *encoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return encoded;
    }
    
    free(buffer);
    
    return nil;
}

+ (NSString *)hyb_AESDecrypt:(NSString *)encryptText password:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES256 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
//    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [encryptText dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
//    NSData *data = [GTMBase64 decodeData:ordata];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return decoded;
    }
    
    free(buffer);
    return nil;
}

// 加密
+(NSString *)AES128Encrypt:(NSString *)plainText
{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = (int)dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
//        NSString *lllsstrr= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        NSString *encodeStr = [GTMBase64 stringByEncodingData:resultData];
        return encodeStr;
    }
    free(buffer);
    return nil;
}

// 解密
+(NSString *)AES128Decrypt:(NSString *)encryptText
{
    char keyPtr[kCCKeySizeAES192 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    bzero(keyPtr, sizeof(keyPtr));
//    NSData *keydata = [gkey dataUsingEncoding:NSUTF8StringEncoding];
//    [keydata getBytes:keyPtr length:kCCKeySizeAES192+1];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000|kCCOptionECBMode,
                                          keyPtr,
                                          strlen(keyPtr),
                                          NULL,
                                          data.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *decodeStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return decodeStr;
    }
    free(buffer);
    return nil;
}

@end
