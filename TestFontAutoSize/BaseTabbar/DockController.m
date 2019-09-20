//
//  DockController.m
//  SinnaWeiBoDemo
//


#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width
#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])

#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#import "DockController.h"
@interface DockController ()<DockDelegate>

@end

@implementation DockController

#define kDockHeight   50

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1.添加Dock
    [self addDock];
}
-(void)addDock
{
    //1.添加Dock
    Dock *dock=[[Dock alloc] init];
    dock.backgroundColor = [UIColor whiteColor];
    dock.frame=CGRectMake(0,kHeight-kDockHeight,kWidth,kDockHeight);
    dock.delegate=self;
    [self.view addSubview:dock];
    _dock=dock;

}

#pragma Mark dock代理方法
-(void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to
{
    
    if(to<0 || to>=self.childViewControllers.count) return ;
    
    //0移除旧的控制器
    UIViewController *oldVx=self.childViewControllers[from];
    [oldVx.view removeFromSuperview];
    
    //1.取出即将显示的控制器
    UIViewController *newVc=self.childViewControllers[to];
    CGFloat width=kWidth;
    CGFloat height=kHeight-kDockHeight;
    newVc.view.frame=CGRectMake(0,0,width,height);
    
    //2.添加新控制器的View到MainControll上面
    [self.view addSubview:newVc.view];
    _selectedController = newVc;
    
    
}

@end
