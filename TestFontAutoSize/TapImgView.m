//
//  TapImgView.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "TapImgView.h"

@implementation TapImgView
- (void)dealloc
{
    _t_delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
        [self addGestureRecognizer:tap];
        
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void) Tapped:(UIGestureRecognizer *) gesture
{
    if ([self.t_delegate respondsToSelector:@selector(tappedWithObject:)])
    {
        [self.t_delegate tappedWithObject:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
