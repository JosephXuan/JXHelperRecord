//
//  DragViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/7.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "DragViewController.h"
#import "UIView+YLView.h"
#import "YLDragZoomCycleView.h"
#import "GKFadeNavigationController.h"
#import "ImgScrollView.h"
#import "TapImgView.h"
@interface DragViewController ()<UITableViewDelegate, UITableViewDataSource,GKFadeNavigationControllerDelegate,YLDroagViewDelegate,TapImageViewDelegate,ImgScrollViewDelegate>
@property(nonatomic, strong) YLDragZoomCycleView *dragView;
@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic) GKFadeNavigationControllerNavigationBarVisibility navigationBarVisibility;
@property(nonatomic,strong)ImgScrollView *scrollView;
@property(nonatomic,strong)TapImgView *imageView;
@property(nonatomic,strong)UIView *bgView;
@end
#pragma mark -- macro

#define kHeaderHeight 200
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f

@implementation DragViewController
- (NSArray *)getimageSource {
    
    return @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880401999&di=ba4990f6e6d89d66dcea9832ea01c217&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F78%2Fd%2F250.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880450952&di=e0386e70958b230adec0a063a871bb0d&imgtype=0&src=http%3A%2F%2Fwww.qihualu.net.cn%2FVimages%2Fbd1938384.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880489400&di=1805f04fa8b90a7145bee610af129fa1&imgtype=0&src=http%3A%2F%2Fwww.bz55.com%2Fuploads%2Fallimg%2F100722%2F0933553a9-2.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495880548256&di=66722048d74180758bff742f9855caf4&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F162%2F48%2F9TZ0JJK73519.jpg"];
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        //判断数据个数，来确定tableView的高度
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Raindew";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}
#pragma mark -- set UI
- (void)setupUI {
    
    //添加表格
    [self.view addSubview:self.tableView];
    //下面这行代码必须在这里设置。否则会影响导航栏颜色的更换。不能放在懒加载
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    
    //创建轮播图
    self.dragView = [[YLDragZoomCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight) andDataSource:[self getimageSource] autoScroll:YES scrollInterval:2];
    self.dragView.tag=200;
    self.dragView.delegate = self;
    [self.view addSubview:self.dragView];
    
    //设置导航栏自动隐藏  下面的代码请放在方法的最后  否则影响导航栏判断
    GKFadeNavigationController *navigationController = (GKFadeNavigationController *)self.navigationController;
    [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
   self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    
}

- (void)didSelectedItem:(NSInteger)item withView:(UIImageView *)imageView{
    
    NSLog(@"选择了第%ld张图片",item+1);
    _bgView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bgView];
    _bgView.backgroundColor=[UIColor blackColor];
    NSString *urlStr=[self getimageSource][item];
    _scrollView = [[ImgScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _scrollView.backgroundColor=[UIColor blackColor];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*[self getimageSource].count, [UIScreen mainScreen].bounds.size.height);
    _scrollView.tag=100;
    _scrollView.i_delegate=self;
    //    设置放大的最大倍数
    _scrollView.maximumZoomScale = 100;
    //    设置缩小的最大倍数
    _scrollView.minimumZoomScale = 1;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled=YES;
    [_bgView addSubview:_scrollView];
    
    _imageView=(TapImgView*)imageView;
    //_imageView.t_delegate=self;
    /*
     * 点击图片和 滚动视图点击冲突
     */
    [_scrollView addSubview:imageView];
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        return _imageView;
    }
    return nil;
}
#pragma mark--tapImgDelegate
-(void)tappedWithObject:(id)sender{
    NSLog(@"点击了图片");
}
#pragma mark --tapScrollView
- (void) tapImageViewTappedWithObject:(id) sender{
    ImgScrollView *tmpImgView = sender;
    [UIView animateWithDuration:0.5 animations:^{

        _bgView.alpha=0;
       // [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        tmpImgView.alpha=0;
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行\t上下滑动试试~",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag==100) {
        //点击放大
    }if(scrollView.tag==200){
        //滚动视图banner
    }else{
        //tablView
        CGFloat scrollOffsetY = kHeaderHeight-scrollView.contentOffset.y;
        // Show or hide the navigaiton bar
        if (scrollOffsetY-kHeaderHeight < kGKHeaderVisibleThreshold) {//或者<64
            self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityVisible;
        } else {
            self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
        }
        //告诉dragView表格滑动了
        CGFloat offset = scrollView.contentOffset.y + kHeaderHeight;
        [self.dragView dragViewWithOffset:offset];
    }
    
    
}
//正在拖拽的时候停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag==100) {
        
    }else{
       [self.dragView stopScroll];
    }
    
}
//停止滑动开启自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag==100) {
        
    }else{
       [self.dragView startScroll];
    }
    
}


#pragma mark - Accessors

- (void)setNavigationBarVisibility:(GKFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility {
    
    if (_navigationBarVisibility != navigationBarVisibility) {
        // Set the value
        _navigationBarVisibility = navigationBarVisibility;
        
        // Play the change
        GKFadeNavigationController *navigationController = (GKFadeNavigationController *)self.navigationController;
        if (navigationController.topViewController) {
            [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
        }
    }
}

#pragma mark <GKFadeNavigationControllerDelegate>

- (GKFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility {
    return self.navigationBarVisibility;
}

- (void)dealloc {
    NSLog(@"Raindew控制器销毁了");
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
