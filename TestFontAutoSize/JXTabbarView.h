//
//  JXTabbarView.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/19.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXTabbarButton.h"
@interface JXTabbarView : UIView
@property (nonatomic,strong)UITabBarItem *tabbarIt;

@property (nonatomic,assign)BOOL isRedCircle;

@property (nonatomic,strong)UIView *redView;

@property (nonatomic,strong)JXTabbarButton *usualBtn;

@property (nonatomic,assign)NSInteger indexViewBtn;

@property (nonatomic,assign)BOOL islimit;

@property (nonatomic,copy) void(^Block)(NSInteger index);
@end
