//
//  CollectionCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/27.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "CollectionCtrl.h"
#import "UIViewController+NavBarHidden.h"
#import "RDVTabBarController.h"
@interface CollectionCtrl ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UICollectionView * collectionView;

@end

@implementation CollectionCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    //2.设置导航条内容
    [self setUpNavBar];
    [self setUpCollectionView];
    [self setKeyScrollView:self.collectionView scrolOffsetY:600 options:HYHidenControlOptionTitle | HYHidenControlOptionLeft];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self hy_viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self hy_viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self hy_viewWillDisappear:animated];
}
#pragma mark - UI设置

- (void)setUpNavBar{
    
    [self setNavBarBackgroundImage:[UIImage imageNamed:@"2.jpg"]];
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"HelloYeah";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor redColor];
    self.navigationItem.titleView = titleLabel;
}

//初始化CollectionView
- (void)setUpCollectionView{
    
    //创建CollectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];;
    //设置item属性
    layout.itemSize = CGSizeMake(self.view.bounds.size.width * 0.4, 200);
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(270, 20, 20, 20);
    collectionView.backgroundColor = [UIColor whiteColor];
    //添加到控制器上
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [self setHeaderView];
    collectionView.dataSource = self;
    //成为collectionView代理,监听滚动.
    collectionView.delegate = self;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    
}

//设置头部视图
- (void)setHeaderView{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1.jpg" ofType:nil];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 250)];
    imageView.image = image;
    imageView.backgroundColor = [UIColor redColor];
    [self.collectionView addSubview:imageView];
}


#pragma mark - 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[self rdv_tabBarController] setTabBarHidden:!self.rdv_tabBarController.tabBarHidden animated:YES];
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
