//
//  DownLoadTableViewCell.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/5.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "DownLoadTableViewCell.h"
#import "Masonry.h"
#import "MCDownloader.h"
@implementation DownLoadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//重写cell方法
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    _progressView=[[UIProgressView alloc]init];
    [self.contentView addSubview:_progressView];
    _nameLabel=[[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    _button=[JXCustomDownLoadBtn buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_button];
    _bytesLable=[[UILabel alloc]init];
    [self.contentView addSubview:_bytesLable];
    _speedLable=[[UILabel alloc]init];
    [self.contentView addSubview:_speedLable];
    _myImgView=[[MyImgView alloc]initWithImage:[UIImage imageNamed:@"08.jpeg"]];
    [self.contentView addSubview:_myImgView];
    [_myImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.height.offset(60);
        make.width.offset(60);
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myImgView.mas_right).offset(10);
        make.top.offset(10);
        make.right.offset(-10);
        make.height.offset(10);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myImgView.mas_bottom).offset(10);
        make.left.offset(10);
        
    }];
    [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_button setTitle:@"开始" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.equalTo(_progressView.mas_bottom).offset(10);
        make.width.offset(60);
        make.height.offset(40);
    }];
    [_speedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_button.mas_right).offset(-10);
        make.top.equalTo(_progressView.mas_top).offset(10);
    }];
    [_bytesLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_button.mas_left).offset(-10);
        make.top.equalTo(_speedLable.mas_bottom).offset(10);
    }];
    
    
}
- (void)setUrl:(NSString *)url {
    _url = url;
    
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:url];
    NSLog(@"%@", receipt.filePath);
    /*
     /Users/joseph_xuan/Library/Developer/CoreSimulator/Devices/55425825-6245-4803-8420-F03F5C2574FB/data/Containers/Data/Application/462AF85D-B41E-4B91-BB4E-8DD7890F3658/Documents/MCDownloadCache/eff2322fcb7bcd96cab5b6f118adb42c.mp4
     */
    
    self.nameLabel.text = receipt.truename;
    self.speedLable.text = nil;
    self.bytesLable.text = nil;
    self.progressView.progress = 0;
    
    self.progressView.progress = receipt.progress.fractionCompleted;
    if (receipt.totalBytesWritten!=0) {
        
        self.bytesLable.text=[NSString stringWithFormat:@"%0.1fm/%0.1fm", receipt.totalBytesWritten/1024.0/1024, receipt.totalBytesExpectedToWrite/1024.0/1024];
        NSString *writeStr=[NSString stringWithFormat:@"%0.1f",receipt.totalBytesWritten/1024.0/1024];
        NSString *totalStr=[NSString stringWithFormat:@"%0.1f",receipt.totalBytesExpectedToWrite/1024.0/1024];
        CGFloat wrtite=[ writeStr floatValue];
        CGFloat total=[totalStr floatValue];
        CGFloat number=wrtite/total;
        NSLog(@"%f",number);
       
        
        
        self.myImgView.progress=number;
    }
    
    
    //    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:receipt.filePath]];
    
    if (receipt.state == MCDownloadStateDownloading || receipt.state == MCDownloadStateWillResume) {
        [self.button setTitle:@"Stop" forState:UIControlStateNormal];
    }else if (receipt.state == MCDownloadStateCompleted) {
        [self.button setTitle:@"Play" forState:UIControlStateNormal];
        self.nameLabel.text = @"Download Finished";
        
    }else {
        [self.button setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    //防止重用block 数据 在加载
    __weak typeof(receipt) weakReceipt = receipt;
    receipt.downloaderProgressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSInteger speed, NSURL * _Nullable targetURL) {
        __strong typeof(weakReceipt) strongReceipt = weakReceipt;
        if ([targetURL.absoluteString isEqualToString:self.url]) {
            [self.button setTitle:@"Stop" forState:UIControlStateNormal];
            
            self.bytesLable.text = [NSString stringWithFormat:@"%0.1fm/%0.1fm", receivedSize/1024.0/1024,expectedSize/1024.0/1024];
            
            self.progressView.progress = (receivedSize/1024.0/1024) / (expectedSize/1024.0/1024);
            self.speedLable.text = [NSString stringWithFormat:@"%@/s", strongReceipt.speed ?: @"0"];
        }
        
    };
    
    receipt.downloaderCompletedBlock = ^(MCDownloadReceipt *receipt, NSError * _Nullable error, BOOL finished) {
        if (error) {
            [self.button setTitle:@"Start" forState:UIControlStateNormal];
            self.nameLabel.text = @"Download Failure";
        }else {
            [self.button setTitle:@"Play" forState:UIControlStateNormal];
            self.nameLabel.text = @"Download Finished";
        }
        
    };
    
    
}
#pragma mark --点击按钮
- (void)buttonAction:(UIButton *)sender {
    
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:self.url];
    if (receipt.state == MCDownloadStateDownloading) {
        
        [[MCDownloader sharedDownloader] cancel:receipt completed:^{
            [self.button setTitle:@"Start" forState:UIControlStateNormal];
        }];
        
    }else if (receipt.state == MCDownloadStateCompleted) {
        
        if ([self.delegate respondsToSelector:@selector(cell:didClickedBtn:)]) {
            [self.delegate cell:self didClickedBtn:sender];
        }
    }else {
        [self.button setTitle:@"Stop" forState:UIControlStateNormal];
        [self download];
    }
    
}
#pragma mark --开始下载
- (void)download {
    
    [[MCDownloader sharedDownloader] downloadDataWithURL:[NSURL URLWithString:self.url] progress:^(NSInteger receivedSize, NSInteger expectedSize, NSInteger speed, NSURL * _Nullable targetURL) {
        
    } completed:^(MCDownloadReceipt *receipt, NSError * _Nullable error, BOOL finished) {
        NSLog(@"==%@", error.description);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
