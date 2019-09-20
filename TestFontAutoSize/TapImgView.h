//
//  TapImgView.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TapImageViewDelegate <NSObject>

- (void) tappedWithObject:(id) sender;

@end

@interface TapImgView : UIImageView
@property (nonatomic, strong) id identifier;

@property (weak) id<TapImageViewDelegate> t_delegate;
@end
