//
//  JXBaseCell.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXModel.h"
@protocol JXCellDelegate <NSObject>
/*
 *在线预约 (未使用代理)
 */
-(void)lineClick:(UIButton*)btn;
/*
 *电话联系 (未使用代理)
 */
-(void)phoneClick:(UIButton*)btn;

@end
@interface JXBaseCell : UITableViewCell
@property(nonatomic,strong)JXModel*jxModel;

//头像
@property(nonatomic,retain)UIImageView *headerImgView;
@property(nonatomic,retain)UILabel *nameLab;
//年龄 工资 籍贯 学历 就业中
@property(nonatomic,retain)UILabel *ageLab,*moneyLab,*homeLab,*homeDetailLab,*schoolLab;
//在线订单 电话联系 评价
@property(nonatomic,retain)UIButton *lineBtn,*phoneBtn;
+ (instancetype)theShareCellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(JXModel *)model;
@end
