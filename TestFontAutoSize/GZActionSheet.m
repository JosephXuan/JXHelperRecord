//
//  代码地址: https://github.com/Gfengwei/GZActionSheet.git
//
//  GZActionSheet.m
//  GZActionSheet
//
//  Created by guifengwei on 2017/3/21.
//  Copyright © 2017年 Gfengwei. All rights reserved.
//

#import "GZActionSheet.h"

#define CellHeight 50.f  /** 按钮的高度 */
#define Space      5.0f  /** 取消按钮与其它按钮的间隔 */
#define LineSpace  0.5f  /** 按钮与按钮之间的间距 */

@interface GZActionSheet ()

@property (nonatomic, strong) NSArray   *titleArr;

@property (nonatomic, strong) UIView    *btnBgView;

@property (nonatomic,getter=isShow) BOOL  show;

@end

@implementation GZActionSheet

- (instancetype)initWithTitleArray:(NSArray *)titleArr andShowCancel:(BOOL)show{
    if (self = [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.titleArr  = titleArr; self.show = show;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
        [self addGestureRecognizer:tap];
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    
    // 按钮背景
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CGFloat baseHeight = (CellHeight + LineSpace)* self.titleArr.count;
    
    CGFloat bgHeight = self.isShow ? baseHeight + (CellHeight + Space) : baseHeight;
    
    self.btnBgView.frame = CGRectMake(0, size.height, size.width ,bgHeight);
    
    [self addSubview:self.btnBgView];
    
    
    // 取消
    CGFloat bgWidth = self.btnBgView.frame.size.width;
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = 0;
    
    btn.frame = CGRectMake(0, bgHeight - CellHeight, bgWidth, CellHeight);
    
    [self.btnBgView addSubview:btn];
    
    btn.hidden = !self.isShow;
    
    
    // 按钮
    for (int i = 0 ; i < self.titleArr.count; i++) {
        
        CGFloat btnX = 0;
        CGFloat btnY;
        
        CGFloat  btnSpace = bgHeight - (CellHeight + LineSpace) * (i + 1);
        
        btnY = self.isShow ? btnSpace - CellHeight - Space : btnSpace;
        
        CGFloat btnW = bgWidth;
        CGFloat btnH = CellHeight;
        
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.tag   = i+1;
        
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnBgView addSubview:btn];
        
    }
    
    // 显示
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y =  size.height - frame.size.height;
        self.btnBgView.frame = frame;
    }];
    
}

- (void)btnClickAction:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickButtonAtIndex:btn.tag];
    }
    
    if (self.ClickIndex) {
        self.ClickIndex(btn.tag);
    }
    [self hiddenSheet];
    
}

- (void)hiddenSheet {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.btnBgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.btnBgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];
    }
    return _btnBgView;
}

@end
