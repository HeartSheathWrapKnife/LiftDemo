//
//  SLCollectionLogTool.h
//  RunningMan
//
//  Created by Seven Lv on 16/4/16.
//  Copyright © 2016年 Toocms. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLBox(var) __sl_box(@encode(__typeof__((var))), (var))
#define SLBoxToString(var)  [SLBox(var) description]


#ifdef DEBUG
    #define SLLog(Anything) SLLog2(@"%@",SLBox(Anything))
    #define SLLog2(formate, ...)   { \
        NSString * __str = [NSString stringWithFormat:@"🎈%s 第 %d 行📍\n %@\n\n", __func__, __LINE__, [NSString stringWithFormat:formate, ##__VA_ARGS__]];\
        printf("%s", __str.UTF8String); }
#else
    #define SLLog(Anything)
    #define SLLog2(formate, ...)
#endif


FOUNDATION_EXPORT void printPropertyName (NSDictionary * request);
FOUNDATION_EXPORT id __sl_box(const char * type, ...);




