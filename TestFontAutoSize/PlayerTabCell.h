//
//  PlayerTabCell.h
//  TestFontAutoSize
//
//  Created by kk on 2018/4/19.
//  Copyright © 2018年 Joseph_Xuan. All rights reserved.
//
//播放器
#import <UIKit/UIKit.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PlayerTabCell : UITableViewCell
/** 播放 */
@property(nonatomic,strong)UIImageView *headerImgView;



/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;
@end
