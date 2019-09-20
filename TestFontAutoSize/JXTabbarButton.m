//
//  JXTabbarButton.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/19.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXTabbarButton.h"
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWeidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define MYWIDTH 360.0*ScreenWeidth
#define MYHEIGHT 667.0*ScreenHeight
@implementation JXTabbarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //UIViewContentModeScaleToFill
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setTabbarItem:(UITabBarItem *)tabbarItem {
    
    NSString *titleStr = tabbarItem.title;
    UIImage *img = tabbarItem.image;
    UIImage *selImg = tabbarItem.selectedImage;
    [self setTitle:titleStr forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self setImage:img forState:UIControlStateNormal];
    [self setImage:selImg forState:UIControlStateSelected];
    
    _tabbarItem = tabbarItem;
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = CGRectGetMidX(contentRect)-11;//0
    CGFloat y = 10;
    CGFloat w = 20/MYWIDTH;//CGRectGetWidth(contentRect)
    CGFloat h = 20/MYWIDTH;//CGRectGetHeight(contentRect) * _ratio
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x = -1;
    CGFloat y = CGRectGetHeight(contentRect) * _ratio;
    CGFloat w = CGRectGetWidth(contentRect);
    CGFloat h = CGRectGetHeight(contentRect) *(1-_ratio);
    return  CGRectMake(x, y, w, h);
}

/*
 -(CGRect)imageRectForContentRect:(CGRect)contentRect {
 CGFloat x = 0;
 CGFloat y = 0;
 CGFloat w = CGRectGetWidth(contentRect);
 CGFloat h = CGRectGetHeight(contentRect) * _ratio;
 return CGRectMake(x, y, w, h);
 }
 
 - (CGRect)titleRectForContentRect:(CGRect)contentRect {
 CGFloat x = 0;
 CGFloat y = CGRectGetHeight(contentRect) * _ratio;
 CGFloat w = CGRectGetWidth(contentRect);
 CGFloat h = CGRectGetHeight(contentRect) *(1-_ratio);
 return  CGRectMake(x, y, w, h);
 }
 //原版
 */

@end
