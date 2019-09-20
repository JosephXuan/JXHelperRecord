//
//  PlayerTabCell.m
//  TestFontAutoSize
//
//  Created by kk on 2018/4/19.
//  Copyright © 2018年 Joseph_Xuan. All rights reserved.
//

#import "PlayerTabCell.h"
#import "Masonry.h"

@implementation PlayerTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    PlayerTabCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    /*
     cell.opaque=YES;
     cell.layer.drawsAsynchronously=YES;
     cell.layer.rasterizationScale=[UIScreen mainScreen].scale;
     */
    return cell;
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    _headerImgView=[[UIImageView alloc]init];
    _headerImgView.contentMode=UIViewContentModeScaleAspectFill;
    _headerImgView.clipsToBounds=YES;
    [self.contentView addSubview:_headerImgView];
    _headerImgView.backgroundColor=[UIColor yellowColor];
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        //
        make.height.offset(240);
        //
        make.width.offset(kScreenWidth-20);
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
