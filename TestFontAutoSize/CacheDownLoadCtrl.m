//
//  CacheDownLoadCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/5.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "CacheDownLoadCtrl.h"
#import "DownLoadTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MCDownloader.h"
#import "FootView.h"
#import "Masonry.h"
#import "UIImage+Extension.h"
#import "DownLoadingCtrl.h"
@interface CacheDownLoadCtrl ()<UITableViewDelegate,UITableViewDataSource,DownLoadTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *urls;
@property(nonatomic,strong)FootView *footView;
@property (strong, nonatomic) NSMutableArray *deleteArr;
@property (assign, nonatomic) NSInteger deleteNum;
@property (weak, nonatomic) UIButton *deleteBtn;
@property (nonatomic,strong) NSMutableArray *totalArr;
@end
/*
 * 可以通过读取本地文件中的btye 来判断是否下载完成
 */
@implementation CacheDownLoadCtrl
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
-(NSMutableArray *)totalArr{
    if (!_totalArr) {
        _totalArr=[[NSMutableArray alloc]init];
    }
    return _totalArr;
}
-(NSMutableArray *)deleteArr{
    if (!_deleteArr) {
        _deleteArr=[[NSMutableArray alloc]init];
    }
    return _deleteArr;
}

-(UITableView *)tableView{
    if (!_tableView) {
        CGSize viewSize=[UIScreen mainScreen].bounds.size;
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height - 49*2) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //_tableView.editing = YES;
       [_tableView registerClass:[DownLoadTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(FootView *)footView{
    if (!_footView) {
        CGSize viewSize=[UIScreen mainScreen].bounds.size;
        _footView=[[FootView alloc]initWithFrame:CGRectMake(0, viewSize.height-49*2-20, viewSize.width, 49)];
        _footView.backgroundColor=[UIColor orangeColor];
        _footView.customHidden=YES;
        [_footView.allBtn addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footView.deletedBtn addTarget:self action:@selector(deletedClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
   
    [self.view addSubview:self.footView];
   // [self.view bringSubviewToFront:self.footView];
    self.title=@"查看缓存";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    
    for (int i=0; i<[self urls].count; i++) {
        NSString *url=[self urls][i];
        MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:url];
        if (receipt.state==MCDownloadStateCompleted) {
            [self.totalArr addObject:receipt.url];
        }
    }
    
    
    //左按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //右按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton addTarget:self action:@selector(shareBtn2:) forControlEvents:UIControlEventTouchUpInside];
    // [rightButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    rightButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self totalArr].count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.url = [self totalArr][indexPath.row];
    cell.delegate = self;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]init];
    UILabel * lab=[[UILabel alloc]init];
    lab.text=@"正在缓存  >";
    lab.frame=CGRectMake(0, 0, 100, 80);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clickHeader) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    [btn addSubview:lab];
    return bgView;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.editing) {
      return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.deleteArr removeAllObjects];
        MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:[self totalArr][indexPath.row]];
        NSLog(@">>>%@",receipt.filePath);
        [self.deleteArr addObject:[self.totalArr objectAtIndex:indexPath.row]];
        [[MCDownloader sharedDownloader] remove:receipt completed:^{
            [self.totalArr removeObjectsInArray:self.deleteArr];
            
            [self.tableView reloadData];
            
        }];
        
    }
}
#pragma mark --点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(tableView.editing){
        [self.deleteArr addObject:[self.totalArr objectAtIndex:indexPath.row]];
        self.deleteNum += 1;
        [_footView.deletedBtn  setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        return;
    }
   
    
    MCDownloadReceipt *cell=(MCDownloadReceipt *)[tableView cellForRowAtIndexPath:indexPath];
    
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:cell.url];
   // receipt.filename 可以输出一下 看一下路径
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:receipt.filePath]];
    [self.navigationController pushViewController:mpc animated:YES];
   // [self presentViewController:mpc animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning 自定义cell选中方式请打开下面注释（第一种方式）
    //  NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
    //    for (id subCell in subviews) {
    //        if ([subCell isKindOfClass:[UIControl class]]) {
    //
    //            for (UIImageView *circleImage in [subCell subviews]) {
    //
    //                circleImage.image = [UIImage imageNamed:@"CellButton"];
    //
    //            }
    //        }
    //
    //    }
     if(tableView.editing){
         [self.deleteArr removeObject:[self.totalArr objectAtIndex:indexPath.row]];
         self.deleteNum -= 1;
         [_footView.deletedBtn  setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
     }
   
}
//下载完成
- (void)cell:(DownLoadTableViewCell *)cell didClickedBtn:(UIButton *)btn {
   
    MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:cell.url];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:receipt.filePath]];
    [vc presentViewController:mpc animated:YES completion:nil];
}
#pragma mark --点击消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  //  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --右上角编辑
-(void)shareBtn2:(UIButton *)btn{
    if ([self totalArr].count==0) {
        return;
    }
     CGSize viewSize=[UIScreen mainScreen].bounds.size;
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        _footView.customHidden = NO;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        //防止当全部选择时，点击取消编辑，再次进入第一次点击全部选择会无效
        [_footView.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        _footView.allBtn.selected = NO;
    }else {
        
        _footView.customHidden = YES;
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    //让tableView进入编辑模式
    [_tableView setEditing:!_tableView.isEditing animated:YES];
    
    if (_tableView.isEditing) {
        
        [_tableView setFrame:CGRectMake(0, 0, viewSize.width, viewSize.height - 49*2)];
    }else {
        
        [_tableView setFrame:CGRectMake(0, 0, viewSize.width, viewSize.height-49)];
    }
    
}
#pragma mark--全选按钮点击
-(void)allClick:(UIButton *)btn{
    if (!btn.selected) {
        btn.selected = YES;
        [self.deleteArr removeAllObjects];
        for (int i = 0; i < [self totalArr].count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
           
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
#warning 自定义cell选中方式请打开下面注释（第一种方式）
            //            NSArray *subviews = [[self.tableView cellForRowAtIndexPath:indexPath] subviews];
            //            for (id subCell in subviews) {
            //                if ([subCell isKindOfClass:[UIControl class]]) {
            //
            //                    for (UIImageView *circleImage in [subCell subviews]) {
            //                        circleImage.image = [UIImage imageNamed:@"CellButtonSelected"];
            //                    }
            //                }
            //
            //            }
            
        }
        
        [self.deleteArr addObjectsFromArray:self.totalArr];
        self.deleteNum = [self totalArr].count;
        [_footView.deletedBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        [_footView.allBtn setTitle:@"取消全选" forState:UIControlStateNormal];
    }else{
        btn.selected = NO;
        [self.deleteArr removeAllObjects];
        for (int i = 0; i < [self totalArr].count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
            //            cell.selected = NO;
        }
        self.deleteNum = 0;
        [_footView.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_footView.deletedBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
    }
    //根据偏移量计算是否滑动到tableView最后一行 count为无符号整型 强转一下
    /*
     if (_tableView.contentOffset.y > 50.0000000*(NSInteger)(_cellArray.count - 12 - 2)) {
     //cell高度*(模型数组个数 - 页面展示总cell数 + 2) = 滑动到tableView倒数第二行的偏移量
     
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_cellArray indexOfObject:[_cellArray lastObject]] inSection:0];
     
     [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
     }
     */
}
#pragma mark --删除
-(void)deletedClick{
    
    if (self.tableView.editing) {
        //删除
        
        NSLog(@"%ld", self.deleteArr.count);
        for (int i = 0; i < self.deleteArr.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
           MCDownloadReceipt *receipt = [[MCDownloader sharedDownloader] downloadReceiptForURLString:[self totalArr][indexPath.row]];
            NSLog(@">>>%@",receipt.filePath);
          
           [[MCDownloader sharedDownloader] remove:receipt completed:^{
               [self.totalArr removeObjectsInArray:self.deleteArr];
               [self.tableView reloadData];
            }];
            /*
           */
        }
        
        
        self.deleteNum = 0;
        [_footView.deletedBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        
        _footView.allBtn.selected=NO;
        [_footView.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        //            你的网络请求
        
       
       // [[MCDownloader sharedDownloader] removeAllComplted];
    }
}
#pragma mark --点击区头
-(void)clickHeader{
    DownLoadingCtrl *dlc=[[DownLoadingCtrl alloc]init];
    [self.navigationController pushViewController:dlc animated:YES];
    
}
#pragma mark --返回
-(void)back{
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
