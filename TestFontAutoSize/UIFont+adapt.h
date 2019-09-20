//
//  UIFont+adapt.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/2/23.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
//runtime
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)

// 这里设置iPhone6放大的字号数（现在是放大2号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为17）
#define IPHONE6_INCREMENT 2

// 这里设置iPhone6Plus放大的字号数（现在是放大3号，也就是iPhone4s和iPhone5上字体为15时，iPhone6上字号为18）
#define IPHONE6PLUS_INCREMENT 3

@interface UIFont (adapt)

+(UIFont *)adjustFont:(CGFloat)fontSize;

@end
