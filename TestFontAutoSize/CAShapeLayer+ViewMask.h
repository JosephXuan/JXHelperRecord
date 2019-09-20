//
//  CAShapeLayer+ViewMask.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAShapeLayer (ViewMask)
+ (instancetype)createMaskLayerWithView : (UIView *)view;
@end
