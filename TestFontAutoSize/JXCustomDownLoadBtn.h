//
//  JXCustomDownLoadBtn.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/2.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

//防止 连续点击
//https://github.com/strivever/UIButton-touch
#import <UIKit/UIKit.h>

@interface JXCustomDownLoadBtn : UIButton
@property (nonatomic,assign)NSTimeInterval clickDurationTime;
@end
