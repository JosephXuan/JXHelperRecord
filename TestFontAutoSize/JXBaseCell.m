//
//  JXBaseCell.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXBaseCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWeidth [[UIScreen mainScreen] bounds].size.width
#define MYWIDTH 360.0*ScreenWeidth
#define MYHEIGHT 667.0*ScreenHeight
@implementation JXBaseCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        
        [self createView];
        self.contentView.backgroundColor=[UIColor whiteColor];
        
    }
    
    return self;
    
}
#pragma mark --customView
-(void)createView{
    
    _nameLab =[[UILabel alloc]init];
    
    
    _ageLab =[[UILabel alloc]init];

    _moneyLab =[[UILabel alloc]init];
    _homeLab =[[UILabel alloc]init];
    _homeDetailLab =[[UILabel alloc]init];
    _schoolLab =[[UILabel alloc]init];
    
    
    _lineBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _phoneBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _headerImgView =[[UIImageView alloc]init];
    //头像
    _headerImgView.contentMode=UIViewContentModeScaleAspectFill;
    _headerImgView.clipsToBounds=YES;
    [self.contentView addSubview:_headerImgView];
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.width.offset(60/MYWIDTH);
        make.height.offset(80/MYHEIGHT);
        
    }];
    
    //名字
    _nameLab.font =[UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nameLab];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImgView.mas_right).offset(10);
        make.top.offset(10+3);
    }];
    
    //工资
    _moneyLab.font =[UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:_moneyLab];
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).offset(10-5);
        make.left.equalTo(_headerImgView.mas_right).offset(10);
    }];
    
    // 年龄
    _ageLab.font =[UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:_ageLab];
    [_ageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameLab.mas_bottom).offset(5);
        make.left.equalTo(_moneyLab.mas_right).offset(10+5);
        
    }];
    
    
    
    //学历
    _schoolLab.font=[UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:_schoolLab];
    [_schoolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_moneyLab.mas_bottom).offset(5);
        make.left.equalTo(_headerImgView.mas_right).offset(10);
        
    }];
    
    //籍贯详细
    _homeDetailLab.font=[UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:_homeDetailLab];
    [_homeDetailLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_schoolLab.mas_bottom).offset(5);
        make.left.equalTo(_headerImgView.mas_right).offset(10);
    }];
    
    //籍贯
    _homeLab.text =@"(籍贯)";
    _homeLab.font =[UIFont systemFontOfSize:10.0];
    [self.contentView addSubview:_homeLab];
    CGSize homeLabSize =[_homeLab.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
    _homeLab.textColor =[UIColor lightGrayColor];
    [_homeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_homeDetailLab.mas_right).offset(3);
        make.centerY.equalTo(_homeDetailLab.mas_centerY);
        make.height.offset(homeLabSize.height);
        make.width.offset(ceilf(homeLabSize.width));
    }];
 

    
    //电话联系
    _phoneBtn.backgroundColor =[UIColor orangeColor];
    [self.contentView addSubview:_phoneBtn];
    [_phoneBtn setTitle:@"电话联系" forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    _phoneBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_phoneBtn addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.offset(-10);
        make.width.offset(60/MYWIDTH);
        make.height.offset(20/MYHEIGHT);
    }];
    
    //在线订单
    _lineBtn.backgroundColor =[UIColor orangeColor];
    [self.contentView addSubview:_lineBtn];
    [_lineBtn setTitle:@"在线预约" forState:UIControlStateNormal];
    [_lineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _lineBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    _lineBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [_lineBtn addTarget:self action:@selector(lineClick:) forControlEvents:UIControlEventTouchUpInside];
    [_lineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.right.equalTo(_phoneBtn.mas_left).offset(-10-5);
        make.width.offset(60/MYWIDTH);
        make.height.offset(20/MYHEIGHT);
    }];
   

}
#pragma mark --加载
-(void)setJxModel:(JXModel *)jxModel{
    _jxModel=jxModel;
    //SDWebImageAllowInvalidSSLCertificates
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:jxModel.headurl] placeholderImage:[UIImage imageNamed:@"AppIcon"]options:0];
    //姓名
    int isSex =[jxModel.sex intValue];
    NSString *manOrWomanStr;
    if(isSex==0){
        //男
        manOrWomanStr =@"保姆";
    }
    else{
        manOrWomanStr =@"阿姨";
    }
    if (jxModel.surname.length!=0) {
        NSString *nameStr =[NSString stringWithFormat:@"%@%@",jxModel.surname,manOrWomanStr];
        self.nameLab.text = nameStr;
    }
    
    //工资
    NSString *priceStr;
    if (jxModel.price.length==0) {
        priceStr=@"价格面议";
    }else{
        priceStr=[NSString stringWithFormat:@"%@%@",jxModel.price,@"元/月"];
    }
    self.moneyLab.text = priceStr;
    //年龄
    NSString *ageStr =[NSString stringWithFormat:@"%@%@",jxModel.birthday,@"岁"];
    self.ageLab.text = ageStr;
   
    //学历
    if (jxModel.record.length!=0) {
        self.schoolLab.text = jxModel.record;
    }
    if (jxModel.jiguan.length!=0) {
        self.homeDetailLab.text =jxModel.jiguan;
    }
}
+ (instancetype)theShareCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"newCell";
    JXBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JXBaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;;
    }
    /*
    cell.opaque=YES;
    cell.layer.drawsAsynchronously=YES;
    cell.layer.rasterizationScale=[UIScreen mainScreen].scale;
     */
    return cell;
}
+ (CGFloat)getCellHeight:(JXModel *)model{
    
    return 100;
}
#pragma mark--phone
-(void)phoneClick:(UIButton*)btn{
    JXModel *jxModel=_jxModel;
    NSString *telPhoneStr=[NSString stringWithFormat:@"%@%@",@"tel://",jxModel.tel];
    NSLog(@"%@",telPhoneStr);
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
}
#pragma mark--line
-(void)lineClick:(UIButton*)btn{
    JXModel *jxModel=_jxModel;
    NSString *telPhoneStr=[NSString stringWithFormat:@"%@%@",@"tel://",jxModel.tel];
    NSLog(@"%@",telPhoneStr);
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoneStr]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
