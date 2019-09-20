//
//  JXDownLoadCollectionViewCell.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXDownLoadCollectionViewCell.h"
#import "MCDownloader.h"


@implementation JXDownLoadCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    
    return self;
}
-(void)setUpUI{
    _myBtn=[JXCustomDownLoadBtn buttonWithType:UIButtonTypeCustom];
    _myBtn.center=self.contentView.center;
    _myBtn.bounds=CGRectMake(0, 0, 70, 70);
  //  [_myBtn setBackgroundImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
  //  [_myBtn setBackgroundColor:[UIColor lightGrayColor]];
   // self.contentView.backgroundColor=[UIColor redColor];
    [_myBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_myBtn];
    
    _goodImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_selected"]];
    _goodImageView.center=self.contentView.center;
    _goodImageView.bounds=CGRectMake(0, 0, 40, 40);
    [self.contentView addSubview:_goodImageView];
    
}
//设置下载的url 一进入的设置 每一个cell
-(void)setUrl:(NSString *)url{
    _url = url;
    
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:url];
   // NSLog(@"%@", receipt.filePath);
    /*
     /Users/joseph_xuan/Library/Developer/CoreSimulator/Devices/55425825-6245-4803-8420-F03F5C2574FB/data/Containers/Data/Application/462AF85D-B41E-4B91-BB4E-8DD7890F3658/Documents/MCDownloadCache/eff2322fcb7bcd96cab5b6f118adb42c.mp4
     */
    
    if (receipt.state == MCDownloadStateDownloading || receipt.state == MCDownloadStateWillResume) {
        //正在下载 下载过暂停
        [_myBtn setBackgroundColor:[UIColor purpleColor]];
        self.contentView.backgroundColor=[UIColor greenColor];
    }else if (receipt.state == MCDownloadStateCompleted) {
        //下载完成
        [_myBtn setBackgroundColor:[UIColor greenColor]];
        self.contentView.backgroundColor=[UIColor greenColor];
        
    }else {
        //未下载 默认状态
        //未完成下载
        [_myBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.contentView.backgroundColor=[UIColor redColor];
    }
    
    __weak typeof(receipt) weakReceipt = receipt;
    receipt.downloaderProgressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSInteger speed, NSURL * _Nullable targetURL) {
        __strong typeof(weakReceipt) strongReceipt = weakReceipt;
        if ([targetURL.absoluteString isEqualToString:self.url]) {
            [_myBtn setBackgroundColor:[UIColor purpleColor]];
            self.contentView.backgroundColor=[UIColor greenColor];
            //正在下载
            /*
            self.bytesLable.text = [NSString stringWithFormat:@"%0.1fm/%0.1fm", receivedSize/1024.0/1024,expectedSize/1024.0/1024];
            self.progressView.progress = (receivedSize/1024.0/1024) / (expectedSize/1024.0/1024);
            self.speedLable.text = [NSString stringWithFormat:@"%@/s", strongReceipt.speed ?: @"0"];
             */
        }
        
    };
    
    receipt.downloaderCompletedBlock = ^(MCDownloadReceipt *receipt, NSError * _Nullable error, BOOL finished) {
        if (error) {
//            [self.button setTitle:@"Start" forState:UIControlStateNormal];
//            self.nameLabel.text = @"Download Failure";
        }else {
//            [self.button setTitle:@"Play" forState:UIControlStateNormal];
//            self.nameLabel.text = @"Download Finished";
        }
        
    };
    
    
}
#pragma mark --cell 点击
-(void)buttonClick:(UIButton *)btn{

    /*
     */
    
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:self.url];
    if (receipt.state == MCDownloadStateDownloading) {
        
        [[MCDownloader sharedDownloader] cancel:receipt completed:^{
           //正在下载状态转取消状态
            [_myBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.contentView.backgroundColor=[UIColor redColor];
            if (_clickCars) {
                _clickCars(_myBtn,2,_goodImageView);
            }
        }];
    }else if (receipt.state == MCDownloadStateCompleted) {
        //下载完成调代理方法
        if ([self.delegate respondsToSelector:@selector(cell:didClickedBtn:)]) {
            [self.delegate cell:self didClickedBtn:btn];
            if (_clickCars) {
                _clickCars(_myBtn,3,_goodImageView);
            }
        }
    }else {
       // 默认状态转下载状态
        [_myBtn setBackgroundColor:[UIColor purpleColor]];
        self.contentView.backgroundColor=[UIColor greenColor];
        if (_clickCars) {
            _clickCars(_myBtn,1,_goodImageView);
        }
        [self download];
    }
    
     
}

- (void)download {
    
    [[MCDownloader sharedDownloader] downloadDataWithURL:[NSURL URLWithString:self.url] progress:^(NSInteger receivedSize, NSInteger expectedSize, NSInteger speed, NSURL * _Nullable targetURL) {
        
    } completed:^(MCDownloadReceipt *receipt, NSError * _Nullable error, BOOL finished) {
        NSLog(@"==%@", error.description);
    }];
    
    
}
@end
