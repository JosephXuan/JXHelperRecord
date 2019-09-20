//
//  DownLoadTableViewCell.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/5.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCustomDownLoadBtn.h"
#import "MyImgView.h"
@class DownLoadTableViewCell;
@protocol DownLoadTableViewCellDelegate <NSObject>

- (void)cell:(DownLoadTableViewCell *)cell didClickedBtn:(UIButton *)btn;
@end

@interface DownLoadTableViewCell : UITableViewCell
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)JXCustomDownLoadBtn *button;
@property(nonatomic,strong)UILabel *bytesLable;
@property(nonatomic,strong)UILabel *speedLable;
@property(nonatomic,strong)MyImgView *myImgView;
@property (nonatomic, weak) id <DownLoadTableViewCellDelegate> delegate;
@property (nonatomic,copy)NSString *url;
@end
