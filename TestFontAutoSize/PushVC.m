//
//  PushVC.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "PushVC.h"

#import "SGTopTitleView.h"
#import "JXOneChildCtrl.h"
#import "JXTwoChildCtrl.h"
#import "JXThirdChildCtrl.h"
//UINavigationController+Cloudox
@interface PushVC ()<UINavigationControllerDelegate,SGTopTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation PushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self createNavWithTitle:@"pushVC" selectNavBgImgIndex:0 selectedTitleColorIndex:0 createMenuItem:^UIView *(int nIndex) {
        
        if(nIndex == 0) {
            
            //可添加控件 比如返回按钮。。。
            UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [pushBtn setTitle:@"返回" forState:UIControlStateNormal];
            [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            pushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            pushBtn.frame = CGRectMake(0, 0, 40, 40);
            [pushBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
            pushBtn.backgroundColor = [UIColor blackColor];
            [self.navView addSubview:pushBtn];
        }
        if(nIndex == 1) {
            //同上
            UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [pushBtn setTitle:@"点击" forState:UIControlStateNormal];
            [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            pushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            pushBtn.frame = CGRectMake(300, 0, 40, 40);
            [pushBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
            pushBtn.backgroundColor = [UIColor blackColor];
            [self.navView addSubview:pushBtn];
        }
        
        return nil;
    }];
    /*
     * tabbar不消失
     */
    self.navigationController.delegate=self;
    self.view.backgroundColor=[UIColor whiteColor];
    
   // [self.tableView removeFromSuperview];
    
    [self setUpView];
}
#pragma mark --设置子视图
-(void)setUpView{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    self.titles = @[@"油烟机清洗", @"燃气灶清洗", @"空调清洗"];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.titleAndIndicatorColor=[UIColor redColor];
    _topTitleView.isHiddenIndicator = NO;
    _topTitleView.delegate_SG = self;
    [self.view addSubview:_topTitleView];
    
    // [self showBottomImg];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    [self showVc:0];
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    // 油烟机
    JXOneChildCtrl *oneVC = [[JXOneChildCtrl alloc] init];
    [self addChildViewController:oneVC];
    
    
    
    // 燃气灶
    JXTwoChildCtrl *twoVC = [[ JXTwoChildCtrl alloc] init];
    [self addChildViewController:twoVC];
    
    // 空调
    JXThirdChildCtrl *threeVC = [[JXThirdChildCtrl alloc] init];
    [self addChildViewController:threeVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    NSLog(@">>>>%ld",index);
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    // 4.每次都刷新数据
    UIViewController *vc = self.childViewControllers[index];
    [self reloadDataSoureWith:vc];
    
}
//刷新控制器的View
-(void)reloadDataSoureWith:(UIViewController *)vc{
    if (vc.isViewLoaded==YES) {
        [vc viewWillAppear:YES];
        
    }
    
}
#pragma mark -- delegateForNav
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@"系统导航>>>>>代理 显示tabbar");
    
}
-(void)pushVC{
    // [self.navigationController popViewControllerAnimated:YES];
    
    [self presentMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
