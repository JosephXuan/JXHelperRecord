//
//  MainController.m
//  SinnaWeiBoDemo
//


#import "MainController.h"
#import "Dock.h"
#import "BaseNavigationController.h"
#import "JXOneCustomCtrl.h"
#import "JXTwoCustomCtrl.h"
#import "JXThreeCustomCtrl.h"
#import "JXFourCustomCtrl.h"
@interface MainController ()<DockDelegate,UINavigationControllerDelegate>

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.初始化所有子控制器控志器
    
   [self addChildViewControll];
    
    //初始化DockItem
    [self addDockItem];
 
}

-(void)addChildViewControll
{
    //1.
    JXOneCustomCtrl *oneVC=[[JXOneCustomCtrl alloc] init];
    BaseNavigationController *oneNav=[[BaseNavigationController alloc] initWithRootViewController:oneVC];
    oneNav.delegate=self;
    [self addChildViewController:oneNav];
    
    //2.
    JXTwoCustomCtrl *twoVC=[[JXTwoCustomCtrl alloc] init];
    BaseNavigationController *twoNav=[[BaseNavigationController alloc] initWithRootViewController:twoVC];
    twoNav.delegate=self;
    [self addChildViewController:twoNav];

    //3.
    JXThreeCustomCtrl *threeVC=[[JXThreeCustomCtrl alloc] init];
    BaseNavigationController *threeNav=[[BaseNavigationController alloc] initWithRootViewController:threeVC];
    threeNav.delegate=self;
    [self addChildViewController:threeNav];
    
    //4.
    JXFourCustomCtrl *fourVC=[[JXFourCustomCtrl alloc] init];
    BaseNavigationController *fourNav=[[BaseNavigationController alloc] initWithRootViewController:fourVC];
    threeNav.delegate=self;
    [self addChildViewController:fourNav];


}
#pragma mark  UInavgationDelegate
//导航控制器即将展示新的控制器
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root=navigationController.viewControllers[0];
    if(root!=viewController){ //不是根控制器
        //如果显示的不是根控制器，就需要拉长导航控制器View的高度
        CGRect frame=navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].applicationFrame.size.height+20;//除去状态栏的高度
        navigationController.view.frame=frame;
    
        // 添加Dock到跟控制器的View上面
        [_dock removeFromSuperview];
        CGRect dockFrame=_dock.frame;
        dockFrame.origin.y=root.view.frame.size.height-_dock.frame.size.height;

        if([root.view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scroller=(UIScrollView *)root.view;
            dockFrame.origin.y+=scroller.contentOffset.y;
        }
        //调整dock 的y 值
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
    }
    
}
- (void)back
{
    [self.childViewControllers[_dock.selectIndex] popViewControllerAnimated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (root==viewController) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height+20 - _dock.frame.size.height;
        navigationController.view.frame = frame;
        
        // 2.添加Dock到根控制器的View上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
}

-(void)addDockItem
{
    // 2.往Dock  里面填充内容
    
    [_dock addItemWithIcon:@"icon-shouye" selectedIcon:@"icon-shouyexuanzhong" title:@"首页" andSelectedTitleColor:[UIColor blueColor]];
    
    [_dock  addItemWithIcon:@"second_normal" selectedIcon:@"second_selected"  title:@"动态" andSelectedTitleColor:[UIColor blueColor]];
    
    [_dock  addItemWithIcon:@"third_normal" selectedIcon:@"third_selected"  title:@"我的" andSelectedTitleColor:[UIColor blueColor]];
    
     [_dock  addItemWithIcon:@"third_normal" selectedIcon:@"third_selected"  title:@"他的" andSelectedTitleColor:[UIColor blueColor]];
}
#warning 变换状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
