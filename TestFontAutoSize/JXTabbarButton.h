//
//  JXTabbarButton.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/19.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTabbarButton : UIButton

@property (nonatomic,strong)UITabBarItem *tabbarItem;

//图片和文字的比例
@property (nonatomic,assign)CGFloat ratio;
@end
