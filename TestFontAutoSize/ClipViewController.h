//
//  ClipViewController.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/12.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
////http://code.cocoachina.com/view/133432
//https://github.com/kenshin03/KTSecretTextView
#import <UIKit/UIKit.h>
@protocol ClipViewControllerDelegate <NSObject>

- (void)didSuccessClipImage:(UIImage *)clipedImage;

@end

@interface ClipViewController : UIViewController

@property (nonatomic, strong) UIImage *needClipImage;
@property (nonatomic, weak) id<ClipViewControllerDelegate> delegate;
@end
