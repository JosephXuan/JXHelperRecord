//
//  DownLoadListCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "DownLoadListCtrl.h"
#import "Masonry.h"
#import "JXDownLoadCollectionViewCell.h"
#import "MCDownloader.h"
#import "CacheDownLoadCtrl.h"
#import "PurchaseCarAnimationTool.h"
static NSString *cellIdentifier=@"newCell";
static int i=0;

@interface DownLoadListCtrl ()<UICollectionViewDelegate,UICollectionViewDataSource,TableViewCellDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *totalArr;
@property (strong, nonatomic) NSMutableArray *urls;
@end

@implementation DownLoadListCtrl
- (NSMutableArray *)urls
{
    if (!_urls) {
        self.urls = [NSMutableArray array];
        for (int i = 1; i<=10; i++) {
            [self.urls addObject:[NSString stringWithFormat:@"http://120.25.226.186:32812/resources/videos/minion_%02d.mp4", i]];
            
            //       [self.urls addObject:@"http://localhost/MJDownload-master.zip"];
        }
    }
    return _urls;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(130, 100);
        layout.sectionInset = UIEdgeInsetsMake(30, 40, 30, 40);
        layout.minimumLineSpacing = 30;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height/3*2) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
         [_collectionView registerClass:[JXDownLoadCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
-(NSMutableArray *)totalArr{
    if (!_totalArr) {
        _totalArr=[[NSMutableArray alloc]init];
    }
    return _totalArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor = [UIColor clearColor];
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.frame];
    
    alphaView.backgroundColor = [UIColor clearColor];
    
    baseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    
    // baseView.alpha = 0.7;
    
    [self.view addSubview:alphaView];
    [self.view addSubview:baseView];
    
    
    [self.view addSubview:self.collectionView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"全选" forState:UIControlStateNormal];
    btn.tag=100;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.mas_offset(0);
        make.width.offset(100);
        make.height.offset(50);
    }];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
   // btn1.frame = CGRectMake(100, 100, 100, 50);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"查看缓存" forState:UIControlStateNormal];
    btn1.tag=200;
    [btn1 addTarget:self action:@selector(pushVCClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.right.mas_offset(0);
        make.width.offset(100);
        make.height.offset(50);
    }];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self urls].count;
}

// 只要新的item显示  都会调用这个方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXDownLoadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
   // cell.contentView.backgroundColor=[UIColor redColor];
    [cell.myBtn setTitle: [NSString stringWithFormat:@"第%ld集",indexPath.row] forState:UIControlStateNormal];
    cell.url = [self urls][indexPath.row];
    cell.delegate = self;
    
    // typeof(JXDownLoadCollectionViewCell*) weakSelf = cell;
    
    cell.clickCars = ^(JXCustomDownLoadBtn *myBtn,int state,UIImageView *goodImgView){
        /*
          */
        //获取父类view
        UIView *v = [goodImgView superview];
        //获取cell
        JXDownLoadCollectionViewCell *cell = (JXDownLoadCollectionViewCell *)[v superview];
        //获取cell在当前collection的位置
        CGRect cellInCollection = [collectionView convertRect:cell.frame toView:collectionView];
        //获取cell在当前屏幕的位置
        CGRect rect = [collectionView convertRect:cellInCollection toView:self.view];
        
        rect.origin.y = rect.origin.y - [collectionView contentOffset].y;
        
        CGRect imageViewRect = goodImgView.frame;
        imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
        imageViewRect.origin.x=rect.origin.x+imageViewRect.origin.x;
/*
  CGRect rect = [goodImgView convertRect:goodImgView.bounds toView:self.view];
        rect.origin.y = rect.origin.y - [collectionView contentOffset].y;
        CGRect imageViewRect = goodImgView.frame;
        imageViewRect.origin.y = rect.origin.y+imageViewRect.origin.y;
 */
        [[PurchaseCarAnimationTool shareTool]startAnimationandView:goodImgView andRect:imageViewRect andFinisnRect:CGPointMake(ScreenWidth/4*2.5, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
            
           // UIView *tabbarBtn = self.tabBarController.tabBar.subviews[3];
           // [PurchaseCarAnimationTool shakeAnimation:tabbarBtn];
            if (state==1) {
             //下载
                
            }if (state==2) {
               //取消
                
            }if (state==3) {
                //完成
                
            }
            
        }];
        
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld个item",indexPath.row);
}
#pragma mark --全选/取消
-(void)clicked:(UIButton *)btn{
    //全选
    NSArray *urls = [self urls];
    UIButton *pushVCBtn=[self.view viewWithTag:200];
    if ([btn.titleLabel.text isEqualToString:@"全选"]) {
        
        btn.enabled = NO;
        for (NSString *url in urls) {
            
            [[MCDownloader sharedDownloader] downloadDataWithURL:[NSURL URLWithString:url] progress:^(NSInteger receivedSize, NSInteger expectedSize, NSInteger speed, NSURL * _Nullable targetURL) {
                
                NSLog(@">>>%@",targetURL);
            } completed:^(MCDownloadReceipt * _Nullable receipt, NSError * _Nullable error, BOOL finished) {
                NSLog(@"是否错误==%@", error.description);
            }];
            
        }
        
        btn.enabled = YES;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.titleLabel.text = @"取消";
        NSString *pushVCBtnTitleStr=[NSString stringWithFormat:@"%@%ld",@"查看缓存",urls.count];
        [pushVCBtn setTitle:pushVCBtnTitleStr forState:UIControlStateNormal];
        
    } else {
        //取消
         btn.enabled = NO;
        
        [[MCDownloader sharedDownloader] cancelAllDownloads];
        
        btn.enabled = YES;
          [btn setTitle:@"全选" forState:UIControlStateNormal];
         btn.titleLabel.text = @"全选";
        [pushVCBtn setTitle:@"查看缓存" forState:UIControlStateNormal];
    }
    [self.collectionView reloadData];
}
#pragma mark --查看缓存
-(void)pushVCClik:(UIButton *)btn{

    //查看缓存
   
    CacheDownLoadCtrl *cdvc=[[CacheDownLoadCtrl alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:cdvc];
    [self presentViewController:nav animated:YES completion:nil];
     /*
     */
}
//下载完成 调代理方法
- (void)cell:(JXDownLoadCollectionViewCell *)cell didClickedBtn:(UIButton *)btn {
    
   
    [btn setBackgroundColor:[UIColor greenColor]];
    cell.contentView.backgroundColor=[UIColor greenColor];
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:cell.url];
#pragma mark --下载完成获取路径
    
    /*
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:cell.url];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:receipt.filePath]];
    [vc presentViewController:mpc animated:YES completion:nil];
     */
}
#pragma mark --点击消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
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
