//
//  FootView.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/5.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "FootView.h"
#import "Masonry.h"
@implementation FootView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /*
           */
        _allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.backgroundColor=[UIColor darkGrayColor];
        [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self addSubview:_allBtn];
        [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(self.frame.size.width/2);
            make.left.offset(0);
            make.top.offset(0);
            make.height.offset(self.frame.size.height);
        }];
        
        
        _deletedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _deletedBtn.backgroundColor=[UIColor lightGrayColor];
        [_deletedBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self addSubview:_deletedBtn];
        [_deletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(self.frame.size.width/2);
            make.right.offset(0);
            make.top.offset(0);
            make.height.offset(self.frame.size.height);
        }];
       
        
    }
   
    return self;
}
-(void)setCustomHidden:(BOOL)customHidden{
    _customHidden=customHidden;
    __weak FootView *weakSelf = self;
    //动画block
    void (^block)() = ^{
        CGSize viewSize = [UIScreen mainScreen].bounds.size;
        CGFloat tabBarStartingY = viewSize.height;
        CGFloat tabBarHeight = CGRectGetHeight([weakSelf frame]);
        
        if (!tabBarHeight) {
            tabBarHeight = 49;
        }
        
        if (!weakSelf.customHidden) {
            
            tabBarStartingY = viewSize.height - tabBarHeight*2-20;
            [weakSelf setHidden:NO];
        }
        
        [weakSelf setFrame:CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight)];
        
    };
    
    void (^completion)(BOOL) = ^(BOOL finished){
        if (weakSelf.customHidden) {
            [weakSelf setHidden:YES];
        }
    };
    
    //完成block
    [UIView animateWithDuration:0.24 animations:block completion:completion];
    /*
     if(weakSelf.customHidden){
     [self setHidden:YES];
     
     }else{
     self.alpha=1;
     [self setHidden:NO];
     }
     */
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 
 
 }
 */

@end
