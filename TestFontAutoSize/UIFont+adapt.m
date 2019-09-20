//
//  UIFont+adapt.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/2/23.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "UIFont+adapt.h"

@implementation UIFont (adapt)
+(void)load{
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
}


+(UIFont *)adjustFont:(CGFloat)fontSize{
    UIFont *newFont=nil;
    if (IS_IPHONE_6){
        newFont = [UIFont adjustFont:fontSize + IPHONE6_INCREMENT];
    }else if (IS_IPHONE_6_PLUS){
        newFont = [UIFont adjustFont:fontSize + IPHONE6PLUS_INCREMENT];
    }else{
        newFont = [UIFont adjustFont:fontSize];
    }
    return newFont;
}
@end
