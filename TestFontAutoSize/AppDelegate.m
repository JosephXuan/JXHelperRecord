//
//  AppDelegate.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/2/23.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ViewController.h"
/*
#import "GKFadeNavigationController.h"
//数据库使用
#import "FmdbViewCtrl.h"
//跑马灯
#import "scrollViewLableCtrl.h"
//回复评论
#import "CommentViewController.h"
//拖拽
#import "DragViewController.h"

//基本下载AF
#import "DownLoadViewController.h"
//调用手机地图导航
#import "JXMapViewController.h"
//滑动隐藏(2)(有问题,莫用)
#import "CustomTableViewController.h"
#import "CollectionCtrl.h"
#import "JXHYViewController.h"
//滑动隐藏(1)
#import "InsuranceViewController.h"
//网络加载
#import "JXNetTestCtrl.h"
//自定义 tabbar(2)
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
//自定义 tabbar(1)
#import "JXTabBarCtrl.h"
//图片浏览
#import "JXPhotoBrowserCtrl.h"
//tz
#import "TZTestImgCtrl.h"
#import "TZTestImgPublishCtrl.h"
//图片选取上传
#import "JXPhotoPublishCtrl.h"
//自定义 NAV(1)   比较好的demo
#import "MainController.h"

 // 自定义 tabbar(2)

#import "JXOneCtrl.h"
#import "JXTwoCtrl.h"
#import "JXThreeCtrl.h"
//
#import "PlayerViewController.h"
 
//人脸识别测试
#import "FaceIDTestCtrl.h"
*/
//下载
#import "MainDownLoadCtrl.h"

@interface AppDelegate ()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
/*
 * 自定义 tabbar(2)
 */
@property (strong, nonatomic) UIViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     *网络监测,配合网络加载使用
     */
    [self judgeNet];
    /*
     
     //viewcontroll
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    */
    
    /*
     * 数据库的使用
    
    FmdbViewCtrl *oneView = [[FmdbViewCtrl alloc]init];
    //UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = oneView;
     */
    /*
     * 跑马灯
     
    scrollViewLableCtrl *oneView = [[scrollViewLableCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
     */
    /*
     * 回复评论 三角
    
    
    CommentViewController *oneView = [[CommentViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
      */
    /*
     * 视频
     
    PlayerViewController*oneView = [[PlayerViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
    */
    /*
     *拖拽 滚动
    DragViewController *dvc=[[DragViewController alloc]init];
    GKFadeNavigationController *navc = [[GKFadeNavigationController alloc]initWithRootViewController:dvc];
    self.window.rootViewController = navc;
     */
    
    /*
     * 下载
     
     */
    
    MainDownLoadCtrl *mdlvc=[[MainDownLoadCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:mdlvc];
    self.window.rootViewController = navc;
    /*
     * 基本下载
     
    DownLoadViewController *dlvc=[[DownLoadViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:dlvc];
    self.window.rootViewController = navc;
    */
    
   /*
    * 调用手机地图
    
    JXMapViewController *oneView =[[JXMapViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
    */
    /*
     * 自定义Nav(1)
     
    MainController *nav = [[MainController alloc]init];
    self.window.rootViewController =nav;
    */
     
    
     /*
      //图片浏览
    JXPhotoBrowserCtrl *oneView = [[JXPhotoBrowserCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
    */
    /*
    TZTestImgPublishCtrl *oneView = [[TZTestImgPublishCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
     */
    /*
     * 图片浏览
    JXPhotoPublishCtrl *oneView = [[JXPhotoPublishCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
     */
    /*
     * 自定义 tabbar(2)
    
    [self setupViewControllers];
    self.window.rootViewController =self.viewController;
     */
    /*
     *自定义 tabbar(1)
    
    JXTabBarCtrl *jxTabbar=[[JXTabBarCtrl alloc]init];
    self.window.rootViewController =jxTabbar;
      */
    /*
     *网络加载
     
    JXNetTestCtrl *oneView = [[JXNetTestCtrl alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
     */
   
     // 滑动显示隐藏(1) 没问题
       /*
    InsuranceViewController *oneView = [[InsuranceViewController alloc]init];
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = navc;
   
   */
    //人脸识别测试
    /*
    FaceIDTestCtrl *oneView = [[FaceIDTestCtrl alloc]init];
   // UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneView];
    self.window.rootViewController = oneView;
    */
    /*
     * 滑动隐藏(2)
   
   [self setupViewControllersForHide];
    self.window.rootViewController = self.viewController;
      */
    /*
    ViewController *ctrl=[[ViewController alloc]init]; UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:ctrl];
    self.window.rootViewController=nav;
     */
     [self.window makeKeyAndVisible];
     
    return YES;
}
#pragma mark - Methods
/*
- (void)setupViewControllers {
    UIViewController *firstViewController = [[JXOneCtrl alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[JXTwoCtrl alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[JXThreeCtrl alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]initWithRootViewController:thirdViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}
#pragma mark -滑动隐藏2
- (void)setupViewControllersForHide {
    
    UIViewController *firstViewController = [[CustomTableViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[CollectionCtrl alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[JXHYViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]initWithRootViewController:thirdViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        //item标题都是"我的"
        item.title=@"我的";
        
        index++;
    }
}
 */
#pragma mark  -- 网络监测
- (void)judgeNet
{
    self.manager = [AFNetworkReachabilityManager manager];
    //__weak typeof(self) weakSelf = self;
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
              //
                NSLog(@"网络不可用");
                _status=status;
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
              //
                NSLog(@"wifi已开启");
                _status=status;
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                //
                NSLog(@"您现在正在使用流量");
                _status=status;
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {
               //
                NSLog(@"未知的网络");
                _status=status;
                break;
            }
                
            default:
                break;
        }
    }];
    [self.manager startMonitoring];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
