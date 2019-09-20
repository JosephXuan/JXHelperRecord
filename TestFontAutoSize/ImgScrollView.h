//
//  ImgScrollView.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImgScrollViewDelegate <NSObject>

- (void) tapImageViewTappedWithObject:(id) sender;

@end

@interface ImgScrollView : UIScrollView
@property (weak) id<ImgScrollViewDelegate> i_delegate;

- (void) setContentWithFrame:(CGRect) rect;
- (void) setImage:(UIImage *) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;

@end
