//
//  JXBaseViewCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width
#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])

#define StatusbarSize [[UIApplication sharedApplication] statusBarFrame].size.height

#define iPhoneX      ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#import "JXBaseViewCtrl.h"
#import "AppDelegate.h"
#import "MainController.h"
#import "InsuranceViewController.h"
#import "UIImage+Extension.h"
@interface JXBaseViewCtrl ()<UITableViewDelegate,UITableViewDataSource>
{
    float _nSpaceNavY;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation JXBaseViewCtrl
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [[self navigationController] setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    
    _statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,kWidth, 0.f)];
    _nSpaceNavY = 20;
    if(iPhoneX){
        _nSpaceNavY = 44;
    }
    
    
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        _statusBarView.frame = CGRectMake(_statusBarView.frame.origin.x, _statusBarView.frame.origin.y, _statusBarView.frame.size.width, 20.f);
        _statusBarView.backgroundColor = [UIColor clearColor];
        ((UIImageView *)_statusBarView).backgroundColor = [UIColor clearColor];
        [self.view addSubview:_statusBarView];
        _nSpaceNavY = 0;
    }
    
    
    
}


/*
 
 创建导航栏,
 szTitle为导航栏标题，如果导航栏要调整为非标题样式，可写为 @"" ;
 
 bgIndex为自定义导航栏样式（可按需求自定义）,传 0 背景色为灰色，传 1 在导航栏上添加一张图片，如果图片尺寸不符，请自行添加一个UIImageView，添加在self.navIV上，传 2 导航栏为黑色（按需求自定义）,传 3 横屏时使用 ;
 
 titleIndex为改变导航栏标题样式（同样按需求自定义）,传 0 黑色字体，传 1 白色字体 传其他值 横屏使用 ;
 
 menuItem 在导航栏添加其他控件，详细可见控制器代码。
 
 */

- (void)createNavWithTitle:(NSString *)szTitle selectNavBgImgIndex:(NSInteger )bgIndex  selectedTitleColorIndex:(NSInteger)titleIndex  createMenuItem:(UIView *(^)(int nIndex))menuItem
{
    CGFloat height;
    height=64;
    if (iPhoneX) {
        height=88;
    }
    
    self.navIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nSpaceNavY, self.view.frame.size.width, height - _nSpaceNavY)];
    if(bgIndex==0){
        
        [self.navIV setBackgroundColor:[UIColor grayColor]];
        
    }else if(bgIndex==1){
        
        _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth - 56)/2, (44 - 17)/2+18, 56, 17)];
        [self.navIV addSubview:_titleImage];
        
    }else if (bgIndex == 2) {
        
        [self.navIV setBackgroundColor:[UIColor blackColor]];
        
    }else if (bgIndex == 3) {
        
        //横屏
        self.navIV.frame =CGRectMake(0, _nSpaceNavY, self.view.frame.size.height, height - _nSpaceNavY);
        [self.navIV setBackgroundColor:[UIColor blackColor]];
        
    }
    [self.view addSubview:self.navIV];
    
    /* { 导航条 } */
    CGFloat navHeight;
    navHeight=44;
    if (iPhoneX) {
        navHeight=44;
    }
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize,kWidth, 44.f)];
    ((UIImageView *)_navView).backgroundColor = [UIColor redColor];
   // clear
    [self.view addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    
    UILabel *titleLabel;
    if (szTitle != nil)
    {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_navView.frame.size.width - 200)/2, (_navView.frame.size.height - 40)/2, 200, 40)];
        [titleLabel setText:szTitle];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        if(titleIndex==0){
            [titleLabel setTextColor:[UIColor blackColor]];
        }else if(titleIndex == 1){
            [titleLabel setTextColor:[UIColor whiteColor]];
        }else {
            //横屏
            _navView.frame = CGRectMake(0, StatusbarSize, kHeight, 44.f);
            titleLabel.frame = CGRectMake((kHeight - 200)/2, 2, 200, 40);
            [titleLabel setText:szTitle];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
            [titleLabel setTextColor:[UIColor whiteColor]];
        }
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [_navView addSubview:titleLabel];
    }
    self.titleLabel=titleLabel;
    UIView *item1 = menuItem(0);
    if (item1 != nil)
    {
        [_navView addSubview:item1];
    }
    UIView *item2 = menuItem(1);
    if (item2 != nil)
    {
        [_navView addSubview:item2];
    }
    UIView *item3 = menuItem(2);
    if (item3 != nil)
    {
        [_navView addSubview:item3];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.backgroundColor = indexPath.row % 2 ? [UIColor orangeColor]:[UIColor greenColor];
    
    cell.textLabel.text = @"zzzz";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
    InsuranceViewController *setVc = [[InsuranceViewController alloc] init];
    
    [self.navigationController pushViewController:setVc animated:YES];
}

//呈现主页面
-(void)presentMainView
{
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController=[MainController new];
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
