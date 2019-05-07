//
//  MotionShowController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/10.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "MotionShowController.h"

#import <CoreMotion/CoreMotion.h>
#import "JYSoundTool.h"

@interface MotionShowController ()
@property (nonatomic, strong) CMMotionManager * motionManager;//摇一摇管理
@property (nonatomic, strong) UILabel * showLabel;
@end

@implementation MotionShowController

#pragma mark - Life circle
- (void)viewDidAppear:(BOOL)animated {
    //启动陀螺仪
    [self startAccelerometer];
}

- (void)viewDidDisappear:(BOOL)animated {
    //停止加速仪更新
    [self.motionManager stopAccelerometerUpdates];
    //取消加速器监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
    //进入展示页面，振动开关默认开
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"zhengDongSwitch"];
    
    
    //加速器实例  一个项目应该只有一个实例,否者会影响接收效率
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval =.1;//加速仪更新频率，以秒为单位
    @weakify(self);
    //添加加速器监听
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(id x) {
        // 进入后台停止加速器监听
        @strongify(self);
        [self.motionManager stopAccelerometerUpdates];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil] subscribeNext:^(id x) {
        // 重新进入前台打开监听
        @strongify(self);
        [self startAccelerometer];
    }];
}

///  初始化子控件
- (void)setupSubViews {
    UILabel *showLabel = [UILabel labelWithText:@"随机数" font:20 textColor:[UIColor redColor] frame:Rect(100, 70, 200, 60)];
    [self.view addSubview:showLabel];
    self.showLabel = showLabel;
    
    UILabel *label = [UILabel labelWithText:@"陀螺仪实现，灵敏度可调节，当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）" font:14 textColor:[UIColor blueColor] frame:Rect(50, 120, 240, 200)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    //振动开关
    UILabel *vibrateLabel = [UILabel labelWithText:@"振动开关" font:14 textColor:[UIColor blackColor] frame:Rect(50, label.maxY, 60, 20)];
    [self.view addSubview:vibrateLabel];
    UISwitch *vibrateSwitch = [[UISwitch alloc] initWithFrame:Rect(vibrateLabel.maxX + 10, label.maxY +20, 60, 20)];
    vibrateSwitch.on = YES;
    [self.view addSubview:vibrateSwitch];
    [vibrateSwitch addTarget:self action:@selector(swithValueChange:) forControlEvents:UIControlEventValueChanged];
    
}

///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"摇一摇";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Actions
- (void)swithValueChange:(UISwitch *)sender {
    if (sender.on) {
        //比如在个人设置里面设置是否让app振动，就可以用userdefaults
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"zhengDongSwitch"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"zhengDongSwitch"];
    }
    
}

#pragma mark - Private
/// 接收加速器更新
- (void)startAccelerometer {
    //以push的方式更新并在block中接收加速度
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData*accelerometerData,NSError*error) {
        [self outputAccelertionData:accelerometerData.acceleration];
        if(error) {
            NSLog(@"motion error:%@",error);
        }
    }];
}

/// 判断触发结果执行其他操作
- (void)outputAccelertionData:(CMAcceleration)acceleration {
    //综合3个方向的加速度
    double accelerameter = sqrt( pow(acceleration.x,2) + pow(acceleration.y,2) + pow(acceleration.z,2));
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if(accelerameter > 3.3f) {
        //立即停止更新加速仪
        [self.motionManager stopAccelerometerUpdates];
        dispatch_async(dispatch_get_main_queue(), ^{
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            SLLog(@"摇一摇 执行操作");
            NSString * boolString = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhengDongSwitch"];
            if ([boolString isEqualToString:@"YES"]) {//判断是否开启了振动
                JYSoundTool *sound = [JYSoundTool new];
                [[sound initForPlayingVibrate] play];
            }
            NSString *str = [NSString stringWithFormat:@"重新生成的随机数：%d",arc4random()%10];
            self.showLabel.text = str;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//延时防止重复操作
                [self startAccelerometer];
            });
        });
    }
}

#pragma mark - Public


#pragma mark - Getter\Setter


@end
