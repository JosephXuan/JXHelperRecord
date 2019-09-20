//
//  MyImgView.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "MyImgView.h"

@implementation MyImgView

/*

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}
-(void)setProgress:(float)progress{
    _progress = progress;
#pragma mark --要添加btn 试一试 看易聊
    _coverView=[[UIView alloc]init];
    _coverView.center=self.center;
    _coverView.bounds=CGRectMake(0, 0, 60, 60);
    _coverView.backgroundColor = [UIColor redColor];
    _coverView.alpha = 0.5;
    _coverView.userInteractionEnabled = NO;
    [self addSubview:_coverView];
    // 更改按钮的标题
    NSString *title = [NSString stringWithFormat:@"%.2f%%",self.progress * 100];
    
    //[self setTitle:title forState:UIControlStateNormal];
    
    
    // 更改蒙版 高度
    // 根据进度 改变蒙版
    CGRect rect = self.frame;
    rect.origin.y += 60 * progress;
    
    rect.size.height = 60 * (1-progress);
    NSLog(@"   %f    %f",rect.origin.y,rect.size.height);
    _coverView.frame = rect;
    
}
/*
- (void) removeFromSuperview {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
        [self setFrame:CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0)];
        
    }completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
 */
@end
