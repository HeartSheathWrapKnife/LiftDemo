//
//  JYSoundTool.h
//  XinCai
//
//  Created by Lostifor on 2017/8/22.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface JYSoundTool : NSObject {
    SystemSoundID soundID;
}

- (id)initForPlayingVibrate;

- (id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

- (id)initForPlayingSoundEffectWith:(NSString *)filename;

- (void)play;//播放

- (void)deallocSound;

//-(void)endSound;

@end
