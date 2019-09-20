//
//  HYViewController.h
//  自定义导航控制器
//
//  Created by Sekorm on 16/4/22.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//
/*
 可以继承这个ctrl写Ctrl 在ctrl 写 table 滑动table 导航栏会消失
 */
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, HYHidenControlOptions) {

    HYHidenControlOptionLeft = 0x01,
    HYHidenControlOptionTitle = 0x01 << 1,
    HYHidenControlOptionRight = 0x01 << 2,
    
};

@interface HYViewController : UIViewController

- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options;
/*
 导航栏显示隐藏
 */
//设置当有导航栏自动添加64的高度的属性为NO
/*
 http://www.jianshu.com/p/b8b70afeda81

 */
@end
