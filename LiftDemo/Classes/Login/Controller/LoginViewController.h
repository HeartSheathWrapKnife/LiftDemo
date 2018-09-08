//
//  LoginViewController.h
//  XinCai
//
//  Created by Lostifor on 25/7/17.
//  Copyright © 2017年 ShunLiFu. All rights reserved.


/* 佛祖保佑         永无bug*/
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
//登录成功
@property (nonatomic,   copy) void (^loginSuccess)(void);
@end
