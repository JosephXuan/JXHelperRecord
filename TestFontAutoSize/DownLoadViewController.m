//
//  DownLoadViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "DownLoadViewController.h"
#import "httpTool.h"
@interface DownLoadViewController ()
@property(nonatomic,retain)UIProgressView *progress;
@property(strong,nonatomic)NSURLSessionDownloadTask *task;

@property(nonatomic,retain)UIButton *pause;
@property(nonatomic,retain)UIButton *start;
@property(nonatomic,retain)UIImageView *iv;
@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
   
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(170, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    btn.tag=100;
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _progress  = [[UIProgressView alloc] initWithFrame:CGRectMake(7, 170, 400, 10)];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 100, 100, 50);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 addTarget:self action:@selector(started:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    _start = [[UIButton alloc] initWithFrame:CGRectMake(100, 170, 70, 40)];
    [_start setTintColor:[UIColor blackColor]];
    [_start setTitle:@"继续" forState:UIControlStateNormal];
    [_start addTarget:self action:@selector(startDownload:) forControlEvents:UIControlEventTouchUpInside];
    
    _pause = [[UIButton alloc] initWithFrame:CGRectMake(244, 170, 70, 40)];
    [_pause setTintColor:[UIColor blackColor]];
    [_pause setTitle:@"暂停" forState:UIControlStateNormal];
    [_pause addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchUpInside];
    
    _iv = [[UIImageView alloc] initWithFrame:CGRectMake(80, 270, 200, 200)];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(300, 100, 100, 50);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"移除" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(removed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    [self.view addSubview:_progress];
    [self.view addSubview:_start];
    [self.view addSubview:_pause];
    [self.view addSubview:_iv];
}
-(void)started:(UIButton *)btn{
     [self downloadTask];
}
-(void)clicked:(UIButton*)btn{
    NSLog(@"查看进度");
}
-(void)removed:(UIButton *)btn{
    NSString *extension = @"jpg";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSEnumerator *enumerator = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [enumerator nextObject])) {
        if ([[filename pathExtension] isEqualToString:extension]) {
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:nil];
        }
    }
    [_iv setImage:nil];
}
- (void)downloadTask
{
    //    图片下载：https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496309025805&di=48921c76a3f282c8ecdf78d7243d9250&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F9345d688d43f8794fb05122ed01b0ef41bd53a33.jpg
    //    压缩包下载
    NSString *path=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/image.jpg"]];
    NSURLSessionDownloadTask *task = [httpTool downloadWithUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496309025805&di=48921c76a3f282c8ecdf78d7243d9250&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F9345d688d43f8794fb05122ed01b0ef41bd53a33.jpg" saveToPath:path progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        //封装方法里已经回到主线程，所有这里不用再调主线程了
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress.progress = bytesProgress;
        });
        UIButton *btn=(UIButton *)[self.view viewWithTag:100];
        NSString * str=[NSString stringWithFormat:@"%.1f",1.0 * bytesProgress/totalBytesProgress];
        [btn setTitle:str forState:UIControlStateNormal];
        
    } success:^(id response) {
        NSLog(@"---------%@",response);
        if (response) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              @"image.jpg"];
            UIImage* image = [UIImage imageWithContentsOfFile:path];
          [_iv setImage:image];
        }
     
    } failure:^(NSError *error) {
        
    } showHUD:NO];
    _task = task;
    
}
-(void)startDownload:(id)sender
{
    [httpTool start:_task];
}

- (void)pauseDownload:(id)sender
{
    [httpTool pause:_task];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
