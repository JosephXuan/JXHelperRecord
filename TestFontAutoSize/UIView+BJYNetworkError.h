//
//  UIView+BJYNetworkError.h
//  NewFuture
//
//  Created by 李乃对 on 2019/8/7.
//  Copyright © 2019 BaiJiaYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BJYNetworkErrorPageView;

typedef void(^ClickReloadBlock)(void);

@interface UIView (BJYNetworkError)

// BJYNetworkErrorPageView
@property (nonatomic, strong) BJYNetworkErrorPageView *networkErrorView;

- (void)bjy_configReloadAction:(ClickReloadBlock)block;

- (void)bjy_showNetworkErrorView;
- (void)bjy_hideNetworkErrorView;

@end

#pragma mark -- BJYNetworkErrorPageView
@interface BJYNetworkErrorPageView : UIView
@property (nonatomic, copy) ClickReloadBlock reloadBlock;

@end
