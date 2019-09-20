//
//  TZTestCollCell.m
//  TestFontAutoSize
//
//  Created by kk on 2018/5/30.
//  Copyright © 2018年 Joseph_Xuan. All rights reserved.
//

#import "TZTestCollCell.h"

@implementation TZTestCollCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        self.clipsToBounds = YES;
        _imageView.frame = self.bounds;
    }
    return self;
}
@end
