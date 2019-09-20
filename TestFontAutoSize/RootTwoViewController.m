//
//  RootTwoViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "RootTwoViewController.h"
#import "UIImage+Extension.h"
#import "RDVTabBarController.h"  //tabbar 隐藏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
//tabbar 49  下方非安全区域 34+49
// kTabBarHeight kTabBarHeight 必须是 ScreenHeight 来减
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//状态栏+导航 64
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define iPhoneX      ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

//使用安全区域布局
#define SafeArea  ([UIScreen mainScreen].bounds.size.height == 812?[UIScreen mainScreen].bounds.size.height - 24 - 34:[UIScreen mainScreen].bounds.size.height)
@interface RootTwoViewController ()<UITableViewDataSource, UITableViewDelegate>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;

@end

@implementation RootTwoViewController
/*
 */
- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.backgroundColor = BXColor(253, 171, 47);
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kTopHeight);
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}



- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];

  //  [self hy_viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //[self.navigationItem setHidesBackButton:YES];
    //去掉分割线
   // self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark --自定义Nav
   
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
    self.tableView = tableView;

 //   [self setKeyScrollView:self.tableView scrolOffsetY:60 options: HYHidenControlOptionTitle];
    
     [self addNav];
    
   [self.view addSubview:self.navBarView];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"twoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"two -- %zd", indexPath.row];
    
    return cell;
}
-(void)addNav{
    

    
  //  [self.navigationController.navigationBar setBackgroundImage: [UIImage createImageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];

    
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    //左按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 40, 40);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
   // [self.navBarView addSubview:button];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //右按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width-60,10, 40, 40);
    [rightButton addTarget:self action:@selector(shareBtn2) forControlEvents:UIControlEventTouchUpInside];
    // [rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.adjustsFontSizeToFitWidth=YES;
   // [self.navBarView addSubview:rightButton];
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareBtn2{
    NSLog(@"提交");
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
