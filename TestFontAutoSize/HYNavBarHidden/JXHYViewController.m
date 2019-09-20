//
//  JXHYViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/27.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXHYViewController.h"
#import "RDVTabBarController.h"
#import "NewViewController.h"
@interface JXHYViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation JXHYViewController

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor blueColor];
    
    [self.view addSubview:self.tableView];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 250)];
    imageView.image = [UIImage imageNamed:@"lol.jpg"];
    self.tableView.tableHeaderView = imageView;
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    //HYHidenControlOptionRight 控制 隐藏消失
    [self setKeyScrollView:self.tableView scrolOffsetY:600 options:HYHidenControlOptionLeft | HYHidenControlOptionTitle];
    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    /*
     * 中间的
     */
    self.navigationItem.titleView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    /*
     * 左边的
     */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    self.tableView.rowHeight = 100;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton addTarget:self action:@selector(shareBtn2) forControlEvents:UIControlEventTouchUpInside];
    // [rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
   
}
-(void)shareBtn2{
    NSLog(@"提交");
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
    NewViewController *setVc = [[NewViewController alloc] init];
    
    [self.navigationController pushViewController:setVc animated:YES];
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
