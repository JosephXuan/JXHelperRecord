//
//  UIView+BJYNetworkError.m
//  NewFuture
//
//  Created by 李乃对 on 2019/8/7.
//  Copyright © 2019 BaiJiaYun. All rights reserved.
//

#import "UIView+BJYNetworkError.h"
#import <objc/runtime.h>
#import "Masonry/Masonry.h"

static NSString *const kNetImageName     = @"courseDe_empty";
static NSString *const kNetTitle         = @" 网络不给力，请稍后重试~";
static NSString *const kNetClickTitle    = @"重新加载";
static const CGFloat kClickCornerRadium  = 4;
static const CGFloat kNetSpace           = 16;
static const CGFloat kNetTitleSize       = 14.0f;
static const CGFloat kClickBtnWidth      = 90;
static const CGFloat kClickBtnHeight     = 30;

@interface UIView ()

@property (nonatomic, copy) void(^reloadAction)(void);

@end

@implementation UIView (BJYNetworkError)

- (void)setReloadAction:(void (^)(void))reloadAction {
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))reloadAction {
    return objc_getAssociatedObject(self, _cmd);
}

//BJYNetworkErrorPageView
- (void)setNetworkErrorView:(BJYNetworkErrorPageView *)networkErrorView {
    
    [self willChangeValueForKey:NSStringFromSelector(@selector(networkErrorView))];
    objc_setAssociatedObject(self, @selector(networkErrorView), networkErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(networkErrorView))];
}

- (BJYNetworkErrorPageView *)networkErrorView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)bjy_configReloadAction:(ClickReloadBlock)block {
    self.reloadAction = block;
    if (self.networkErrorView && self.reloadAction) {
        self.networkErrorView.reloadBlock = self.reloadAction;
    }
}

- (void)bjy_showNetworkErrorView {
    
    if (!self.networkErrorView) {
        self.networkErrorView = [[BJYNetworkErrorPageView alloc] initWithFrame:self.bounds];
        if (self.reloadAction) {
            self.networkErrorView.reloadBlock = self.reloadAction;
        }
    }
    [self addSubview:self.networkErrorView];
    // 将子视图放在父类视图最上层
    [self bringSubviewToFront:self.networkErrorView];
}

- (void)bjy_hideNetworkErrorView {
    
    if (self.networkErrorView) {
        [self.networkErrorView removeFromSuperview];
        self.networkErrorView = nil;
    }
}

@end

#pragma mark -- BJYNetworkErrorPageView
@interface BJYNetworkErrorPageView ()

@property (nonatomic, weak) UIImageView *errorImageView;
@property (nonatomic, weak) UILabel *errorTipLabel;
@property (nonatomic, weak) UIButton *reloadButton;

@end

@implementation BJYNetworkErrorPageView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubview];
    }
    return self;
}


- (void)setupSubview {
    
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kNetImageName]];
    [self addSubview:errorImageView];
    _errorImageView = errorImageView;
    
    UILabel *errorTipLabel = [[UILabel alloc] init];
    errorTipLabel.text = kNetTitle;
    errorTipLabel.textColor = [UIColor lightGrayColor];
    errorTipLabel.font = [UIFont boldSystemFontOfSize:kNetTitleSize];
    [self addSubview:errorTipLabel];
    _errorTipLabel = errorTipLabel;
    
    //KAppThemeColor
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadButton setTitle:kNetClickTitle forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reloadButton.titleLabel.font = [UIFont boldSystemFontOfSize:kNetTitleSize];
    reloadButton.backgroundColor = [UIColor redColor];
    reloadButton.layer.cornerRadius = kClickCornerRadium;
    reloadButton.layer.masksToBounds = YES;
    [reloadButton addTarget:self action:@selector(clickToReloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadButton];
    _reloadButton = reloadButton;
    
    [errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        //AppNavBarHeight
        make.centerY.equalTo(self.mas_centerY).offset(-64);
    }];
    
    [errorTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(errorImageView.mas_bottom).offset(kNetSpace);
    }];
    
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(kClickBtnHeight);
        make.width.mas_equalTo(kClickBtnWidth);
        make.top.equalTo(errorTipLabel.mas_bottom).offset(kNetSpace);
    }];
}
 
- (void)clickToReloadAction:(UIButton *)sender {
    
    if (_reloadBlock) {
        _reloadBlock();
    }
}

@end

