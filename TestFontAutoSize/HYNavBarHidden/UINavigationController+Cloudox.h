//
//  UINavigationController+Cloudox.h
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//
//http://www.cocoachina.com/cms/wap.php?action=article&id=18944
//http://www.jianshu.com/p/454b06590cf1
//http://www.jianshu.com/p/d21189d9224b 简书 个人中心 
#import <UIKit/UIKit.h>
#pragma mark --手势冲突 平滑过渡
@interface UINavigationController (Cloudox) <UINavigationBarDelegate, UINavigationControllerDelegate>
@property (copy, nonatomic) NSString *cloudox;
- (void)setNeedsNavigationBackground:(CGFloat)alpha;
@end
