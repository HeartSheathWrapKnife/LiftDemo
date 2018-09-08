//
//  JYSoundTool.m
//  XinCai
//
//  Created by Lostifor on 2017/8/22.
//  Copyright © 2017年 ShunLiFu. All rights reserved.
//

#import "JYSoundTool.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation JYSoundTool

- (id)initForPlayingVibrate {
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}


//sysetem
- (id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ] pathForResource:@"Tock" ofType:@"aiff"];
        if (path) {
            NSLog(@"path:%@",path);
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                NSLog(@"system");
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}

//自定义声音
- (id)initForPlayingSoundEffectWith:(NSString *)filename {
    self = [super init];
    if (self) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        //        NSData * data = [NSData dataWithContentsOfURL:fileURL];
        if (fileURL != nil) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound");
            }
        }
    }
    return self;
}

- (void)play {
    AudioServicesPlaySystemSound(soundID);
}

- (void)deallocSound {
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
