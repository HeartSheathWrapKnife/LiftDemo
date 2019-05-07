//
//  NoiseTestController.m
//  LiftDemo
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "NoiseTestController.h"
#import <AVFoundation/AVFoundation.h>
#import "NoiseTestView.h"

@interface NoiseTestController ()
@property (strong, nonatomic) UILabel *numberLb;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSTimer *levelTimer;
@property (strong, nonatomic) NoiseTestView *rectView;
@end

@implementation NoiseTestController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //清除timer
    if (_levelTimer && [_levelTimer isValid]) {
        [_levelTimer invalidate];
        _levelTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubviews];
    [self testVoice];
    [self setupNavigationBar];
}


///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"测噪音";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)testVoice {
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (_recorder){
        [_recorder prepareToRecord];
        //是否启用音频测量
        _recorder.meteringEnabled = YES;
        //开始录音
        [_recorder record];
        _levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    } else{
        NSLog(@"%@", [error description]);
    }
}

- (void)levelTimerCallback:(NSTimer *)timer {
    [_recorder updateMeters];
    //最终获取的值 0~1之间
    float level;
    //最小分贝 -80 去除分贝过小的声音
    float minDecibels = -80.0f;
    //获取通道0的分贝
    float decibels = [_recorder averagePowerForChannel:0];
    if (decibels < minDecibels){
        //控制最小值 0
        level = 0.0f;
    }else if (decibels >= 0.0f){
        //控制最大值 1
        level = 1.0f;
    }else{
        level =(1 - decibels/(float)minDecibels);
    }
    //扩大范围 0~1 -> 0~110
    CGFloat theVal = level * 110;
    [_numberLb setText:[NSString stringWithFormat:@"%.0f",theVal]];
    [_numberLb setAttributedText:[self changeLabelWithText:[NSString stringWithFormat:@"%.0fdb",theVal]]];
    //计算指针角度
    CGFloat angle = theVal/(float)110 * 1.5*M_PI;
    CGFloat needAngle = angle - 0.75*M_PI;
    _rectView.needleLayer.transform = CATransform3DMakeRotation(needAngle, 0, 0, 1);
}

- (void)createSubviews {
    CGFloat imgHeight = Fit(640);
    UIImageView *baseImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight-imgHeight, kScreenWidth, imgHeight)];
    baseImgV.image = [UIImage imageNamed:@"cezao-bg"];
    [self.view addSubview:baseImgV];
    //288.5的宽度是相对屏幕288.5+86的宽度
    CGFloat width = Fit(288.5) ;
    CGFloat height = Fit(248);
    CGFloat x = (kScreenWidth - width)/2.f;
    CGFloat y = 30;
    _rectView = [[NoiseTestView alloc]initWithFrame:CGRectMake(x, y+SafeAreaTopHeight, width, height)];
    [_rectView show];
    [self.view addSubview:_rectView];
    
    _numberLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_rectView.frame)-30, kScreenWidth, 45)];
    _numberLb.textAlignment = NSTextAlignmentCenter;
    _numberLb.font = [UIFont systemFontOfSize:45 weight:UIFontWeightMedium];
    _numberLb.backgroundColor = [UIColor clearColor];
    [_numberLb setAttributedText:[self changeLabelWithText:@"0db"]];
    _numberLb.textColor = [UIColor whiteColor];
    [self.view addSubview:_numberLb];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_numberLb.frame)+20, kScreenWidth, 18)];
    message.textAlignment = NSTextAlignmentCenter;
    message.backgroundColor = [UIColor clearColor];
    message.textColor = [UIColor whiteColor];
    message.text = @"当前噪音/单位db";
    message.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.view addSubview:message];
}

- (NSMutableAttributedString*) changeLabelWithText:(NSString*)needText {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(needText.length-2,2)];
    return attrString;
}

- (void)dealloc {
    _recorder = nil;
}




@end
