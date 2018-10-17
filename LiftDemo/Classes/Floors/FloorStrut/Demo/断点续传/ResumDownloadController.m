//
//  ResumDownloadController.m
//  LiftDemo
//
//  Created by Lostifor on 2018/9/12.
//  Copyright © 2018年 Lostifor. All rights reserved.
//

#import "ResumDownloadController.h"
#import "ResumDownloadTool.h"

@interface ResumDownloadController ()
{
    NSString  *downLoadUrl;
    NSURL *fileUrl;
    NSURLSessionDownloadTask *task;
    BOOL downLoadIng;
}
@property (nonatomic,   weak) UIProgressView * progress;
@property (nonatomic,   weak) UIButton * startNew;
@property (nonatomic,   weak) UIButton * pause;
@end

@implementation ResumDownloadController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitializeData];
    
    [self setupSubViews];
    
    [self setupNavigationBar];
}

///  初始化子控件
- (void)setupSubViews {
    //进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = Rect(0, 80, ScreenWidth, 30);
    [self.view addSubview:progressView];
    self.progress = progressView;
    self.progress.progress = 0;
    
    UIButton *startNew = [UIButton buttonWithTitle:@"开始下载" titleColor:[UIColor blueColor] backgroundColor:[UIColor groupTableViewBackgroundColor] font:14 image:nil frame:Rect(0, 0, 60, 30)];
    startNew.y = progressView.maxY + 30;
    [self.view addSubview:startNew];
    self.startNew = startNew;
    
    UIButton *pause = [UIButton buttonWithTitle:@"暂停一下" titleColor:[UIColor blueColor] backgroundColor:[UIColor groupTableViewBackgroundColor] font:14 image:nil frame:Rect(0, 0, 60, 30)];
    pause.y = startNew.maxY + 30;
    [self.view addSubview:pause];
    self.pause = pause;
    
    //下载源
    downLoadUrl = @"https://www.apple.com/105/media/cn/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-cn-20170912_1280x720h.mp4";
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath stringByAppendingPathComponent:@"Tiger_Trade_latest.dmg"];
    fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
    
}
///  设置自定义导航条
- (void)setupNavigationBar {
    @weakify(self);
    NSString * title = @"AF断点续传demo";
    self.xc_navgationBar = [XCNavigationBar navWithTitle:title backAction:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark - Actions
- (void)startNew:(UIButton *)sender {
    if (downLoadIng) {
        return;
    }
    downLoadIng = YES;
    NSURLSessionDownloadTask *tempTask = [[ResumDownloadTool sharedTool]AFDownLoadFileWithUrl:downLoadUrl progress:^(CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress.progress = progress;
        });
    } fileLocalUrl:fileUrl success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        NSLog(@"下载成功 下载的文档路径是 %@, ",fileUrlPath);
    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"下载失败,下载的data被downLoad工具处理了 ");
        
    }];
    task = tempTask;
}

- (void)pause:(UIButton *)sender {
    //可以在这里存储resumeData ,也可以去QDNetServerDownLoadTool 里面 根据那个通知去处理 都有回调的
    if (downLoadIng) {
        [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            
        }];
    }
    downLoadIng = NO;
}

#pragma mark - Networking

#pragma mark - Delegate

//#pragma mark UITableViewDelegate & UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  return nil;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return nil;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}
//


#pragma mark - Private


#pragma mark - Public


#pragma mark - Getter\Setter


@end
