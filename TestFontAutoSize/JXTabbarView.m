//
//  JXTabbarView.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/19.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXTabbarView.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWeidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define MYWIDTH 360.0*ScreenWeidth
#define MYHEIGHT 667.0*ScreenHeight
@interface JXTabbarView ()

@property (nonatomic,strong) NSMutableArray *TabArr;

@property (nonatomic,strong)JXTabbarButton *selectedBtn;
@property(nonatomic , copy) NSString *judged;
@end

@implementation JXTabbarView{
    NSInteger oldindex;
    NSInteger reOldindex;
}
-(NSMutableArray *)TabArr {
    if (!_TabArr) {
        _TabArr = @[].mutableCopy;
    }
    return _TabArr;
}

-(void)setTabbarIt:(UITabBarItem *)tabbarIt {
    static int i =0;
    i++;
    JXTabbarButton *btn = [JXTabbarButton buttonWithType:UIButtonTypeCustom];
    self.usualBtn=btn;
    btn.tag=i;
    
    btn.ratio = 0.7;
    btn.tabbarItem = tabbarIt;
    
    [btn addTarget:self action:@selector(btnSelectDown:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    [self.TabArr addObject:btn];
    oldindex=0;
}
#pragma mark -- 点击 2
//按下的事件
- (void)btnSelectDown:(JXTabbarButton *)btn {
    
    
    NSInteger index = [self.TabArr indexOfObject:btn];
    if (_Block) {
        _Block(index);
    }
    
    //(@">>>>%ld",oldindex);
    reOldindex=oldindex;
    
    if (index == oldindex) {
        
    }else {
        /*
         for (int i = 0; i <_TabArr.count; i ++) {
         TabbarButton *btn = _TabArr[i];
         btn.userInteractionEnabled = YES;
         //在layout方法里设置的启动时自动选中第一个界面，点其他按钮是会取消以前选中的
         btn.selected = NO;
         }
         */
    }
    /*
     NSUserDefaults *deFaults=[NSUserDefaults standardUserDefaults];
     NSDictionary *dic =[deFaults objectForKey:@"userDic"];
     _judged=[dic objectForKey:@"success"];
     if (!_judged) {
     // (@"点击的上一个>>>>>>>>%ld",oldindex);
     if (index==1) {
     if (_Block) {
     _Block(index);
     //oldindex=index;
     }
     return;
     }
     }
     */
    
    JXTabbarButton *oldBtn = _TabArr[oldindex];
    //oldBtn.userInteractionEnabled = NO;
    oldBtn.selected=NO;
    
    //self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    
    oldindex = index;
    
    
    
    /*
     if (index==1) {
     oldBtn.userInteractionEnabled = YES;
     //(@"选择的第个...%ld",index);
     if (self.islimit==YES) {
     self.selectedBtn.selected=NO;
     btn.selected=YES;
     oldBtn.userInteractionEnabled = NO;
     
     }else{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
     TabbarButton *btn = _TabArr[0];
     btn.selected = YES;
     });
     
     self.selectedBtn.selected=YES;
     btn.selected = NO;
     }
     }else{
     
     }
     */
    
    
}
#pragma mark -- 设置限制进入 1
-(void)setIslimit:(BOOL)islimit{
    _islimit=islimit;
    
    if (islimit==YES) {
        
    }else{
        
        JXTabbarButton *oldBtn = _TabArr[1];
        oldBtn.selected=NO;
        // (@"限制进入>>%ld",reOldindex);
        
        //没到要求
        for (int i = 0; i <_TabArr.count; i ++) {
            JXTabbarButton *btn = _TabArr[i];
            
            if(i==0){
                if (btn.selected==YES) {
                    return;
                    
                }
            }if(i==1) {
                if (btn.selected==YES) {
                    return;
                    
                }
            }if(i==2) {
                if (btn.selected==YES) {
                    return;
                    
                }
            }
            
            //  btn.userInteractionEnabled = YES;
            //在layout方法里设置的启动时自动选中第一个界面，点其他按钮是会取消以前选中的
            // btn.selected = NO;
        }
        
        JXTabbarButton *oldBtn1 = _TabArr[reOldindex];
        
        oldBtn1.selected=YES;
        
        oldindex=reOldindex;
        
        
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = CGRectGetWidth(self.frame) / 3.0;
    CGFloat h = CGRectGetHeight(self.frame);
    
    for (int i = 0; i <self.TabArr.count; i ++) {
        JXTabbarButton *btn = self.TabArr[i];
        CGFloat x = w * i;
        
        btn.frame = CGRectMake(x, 0, w, h);
    }
    
    //代码只执行一次
    /*
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JXTabbarButton *btn = _TabArr[0];
        btn.selected = YES;
    });
    
    
}
-(void)setIsRedCircle:(BOOL)isRedCircle{
    _isRedCircle=isRedCircle;
    if (isRedCircle==YES) {
        JXTabbarButton *btn = self.TabArr[_indexViewBtn];
        
        if (btn.tag==1) {
            UIView *redView=[[UIView alloc]init];
            self.redView=redView;
            redView.backgroundColor=[UIColor redColor];
            redView.frame=CGRectMake(63/MYWIDTH, 9, 8, 8);
            redView.layer.cornerRadius=4.0f;
            redView.layer.masksToBounds=YES;
            [btn addSubview:redView];
        }if (btn.tag==2) {
            UIView *redView=[[UIView alloc]init];
            self.redView=redView;
            redView.backgroundColor=[UIColor redColor];
            redView.frame=CGRectMake(63/MYWIDTH, 9, 8, 8);
            redView.layer.cornerRadius=4.0f;
            redView.layer.masksToBounds=YES;
            [btn addSubview:redView];
        }if (btn.tag==3) {
            UIView *redView=[[UIView alloc]init];
            self.redView=redView;
            //ZHUTICOLOR
            redView.backgroundColor=[UIColor redColor];
            redView.frame=CGRectMake(63/MYWIDTH, 9, 8, 8);
            redView.layer.cornerRadius=4.0f;
            redView.layer.masksToBounds=YES;
            [btn addSubview:redView];
        }
        
    }else{
        self.redView.alpha=0;
        [self.redView removeFromSuperview];
    }
}
-(void)setIndexViewBtn:(NSInteger)indexViewBtn{
    _indexViewBtn=indexViewBtn;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
