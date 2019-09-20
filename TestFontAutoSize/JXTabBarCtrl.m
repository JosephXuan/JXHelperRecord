//
//  JXTabBarCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/19.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXTabBarCtrl.h"
#import "JXNavigationCtrl.h"
#import "JXOneCtrl.h"
#import "JXTwoCtrl.h"
#import "JXThreeCtrl.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface JXTabBarCtrl ()

@end

@implementation JXTabBarCtrl
- (JXTabbarView *)customTabbar {
    if (!_customTabbar) {
        JXTabbarView *tabbar = [[JXTabbarView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 49)];
        self.tabBar.alpha =0.9;//自定义
        self.customTabbar = tabbar;
        __weak typeof (self) weakSelf = self;
        _customTabbar.Block = ^(NSInteger index){
            weakSelf.selectedIndex = index;
            /*
             if (index==1) {
             
             NSUserDefaults *deFaults=[NSUserDefaults standardUserDefaults];
             NSDictionary *dic =[deFaults objectForKey:@"userDic"];
             _judged=[dic objectForKey:@"success"];
             
             if(!weakSelf.judged){
             //weakSelf.selectedIndex = index;
             weakSelf.customTabbar.islimit=NO;
             [weakSelf addIsToRgistOrLogin];
             
             }else{
             
             [weakSelf judeLimitNeiBor2With:index];
             }
             
             }else{
             weakSelf.selectedIndex = index;
             }
             */
            
        };
        
        [self.tabBar addSubview:tabbar];
    }
    return _customTabbar;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:tabBarButtonClass]) {
            [view removeFromSuperview];
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //http://blog.csdn.net/fightper/article/details/7164636 tabbar 背景颜色

    CGRect frame = CGRectMake(0, 0,self.view.frame.size.width, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    UIImage *img = [UIImage imageNamed:@"2.jpg"];
    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
    v.backgroundColor = color;
    [self.tabBar insertSubview:v atIndex:0];
    self.tabBar.opaque = YES;
    /*
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"2.jpg"]];
     */
    //生活服务
    JXOneCtrl * MVC =[[JXOneCtrl  alloc]init];
    JXNavigationCtrl *nav1 =[[JXNavigationCtrl alloc]initWithRootViewController:MVC];
    UIImage *image1 =[[UIImage imageNamed:@"first_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    UIImage *selectImg1 =[[UIImage imageNamed:@"first_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"生活服务" image:image1 selectedImage:selectImg1];
    [MVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [MVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    self.customTabbar.tabbarIt = MVC.tabBarItem;
    //分享
    JXTwoCtrl *SVC =[[JXTwoCtrl alloc]init];
    JXNavigationCtrl *nav2 =[[JXNavigationCtrl alloc]initWithRootViewController:SVC];
    UIImage *image2 =[[UIImage imageNamed:@"second_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    UIImage *selectIm2 =[[UIImage imageNamed:@"second_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"邻里共享" image:image2 selectedImage:selectIm2];
    [SVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [SVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    self.customTabbar.tabbarIt = SVC.tabBarItem;
    //我的
    JXThreeCtrl * MMVC =[[JXThreeCtrl alloc]init];
    JXNavigationCtrl *nav3 =[[JXNavigationCtrl alloc]initWithRootViewController:MMVC];
    UIImage *image3 =[[UIImage imageNamed:@"third_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectIm3 =[[UIImage imageNamed:@"third_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MMVC.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"我的"image:image3 selectedImage:selectIm3];
    [MMVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [MMVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    self.customTabbar.tabbarIt = MMVC.tabBarItem;
    // MMVC.tabBarItem.badgeValue=@"1";
    
    self.viewControllers =@[nav1,nav2,nav3];
    
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBar.barTintColor =[UIColor whiteColor];
    self.tabBar.translucent = NO;
    //self.tabBar.delegate=self;
    self.tabBar.alpha =0.9;
    
    
    //#warning 调接口判断 是否有信息
    //0 1 2 (设置哪个item圆点)
    //self.customTabbar.indexViewBtn=2;
    // self.customTabbar.isRedCircle=YES;
    /*
    if (!_judged) {
        //没有登录
        //  self.customTabbar.islimit=YES;
    }else{
        //登录以后判断数量
        // 调一个接口 判断数量
        // [self judeLimitNeiBor];
        
        // self.customTabbar.islimit=YES;
        
    }

     */
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
