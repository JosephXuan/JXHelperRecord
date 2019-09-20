//
//  WCLViewController.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/12.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
//http://code.cocoachina.com/view/133845
#import <UIKit/UIKit.h>
#import "WCLActionSheet.h"
#import "WCLImagePicker.h"
@interface WCLViewController : UIViewController<WCLActionSheetDelegate,WCLImagePickerDelegate>

@property (nonatomic,strong) UIImageView *finshIV;

@end
