//
//  RootOneViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "RootOneViewController.h"
#import "UIImage+Extension.h"
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
/** 滚动到多少高度开始出现 */
static CGFloat const startH = 0;
/** 距离底部距离 49 */
static CGFloat const tableBottom = 0;

@interface RootOneViewController () <UITableViewDataSource, UITableViewDelegate>

/** 导航条View */
@property (nonatomic, weak) UIView *navBarView;

@end

@implementation RootOneViewController

- (UIView *)navBarView {
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc] init];
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kTopHeight);
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    tableView.contentInset = UIEdgeInsetsMake(imageH, 0, tableBottom, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, tableBottom, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    UIImageView *headerImage = [[UIImageView alloc] init];
    headerImage.frame = CGRectMake(0, -imageH, [UIScreen mainScreen].bounds.size.width, imageH);
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    [tableView insertSubview:headerImage atIndex:0];
    self.headerImage = headerImage;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.titleName) {
        self.navigationItem.title = @"";
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > -imageH + startH) {
        CGFloat alpha = MIN(1, 1 - ((-imageH + startH + kTopHeight - offsetY) / kTopHeight));
        
        self.navBarView.backgroundColor = BXAlphaColor(253, 171, 47, alpha);
        if (offsetY >= (-imageH + startH + kTopHeight)){
            if (self.titleName) {
                self.navigationItem.title = self.titleName;
            }
        }
    } else {
        self.navBarView.backgroundColor = BXAlphaColor(253, 171, 47, 0);
    }
    
    // ------------------------------华丽的分割线------------------------------------
    // 设置头部放大
    // 向下拽了多少距离
    CGFloat down = - imageH - scrollView.contentOffset.y;
    if (down < 0) return;
    
    CGRect frame = self.headerImage.frame;
    frame.origin.y = - imageH - down;
    frame.size.height = imageH + down;
    self.headerImage.frame = frame;
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"oneCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    return cell;
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
