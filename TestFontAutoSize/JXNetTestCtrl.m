//
//  JXNetTestCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXNetTestCtrl.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "httpTool.h"
#import "YYCache.h"
#import "JXBaseCell.h"
#import "JXModel.h"
#define BASEURL @"http://121.43.165.214:9000/"
@interface JXNetTestCtrl ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *totalArr;
@property(nonatomic,assign)int pageNum;
@end

@implementation JXNetTestCtrl
-(NSMutableArray *)totalArr{
    if (!_totalArr) {
        _totalArr=[[NSMutableArray alloc]init];
    }
    return _totalArr;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
       _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
       // [_myTableView registerClass:[JXBaseCell class] forCellReuseIdentifier:@"newCell"];
        [self.view addSubview:_myTableView];
        //_myTableView.contentSize=CGSizeMake(0, [UIScreen mainScreen].bounds.size.height);
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _myTableView.emptyDataSetSource=self;
        _myTableView.emptyDataSetDelegate=self;
        _myTableView.scrollEnabled = YES;
    }
    return _myTableView;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.myTableView.mj_header beginRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"网络加载(缓存)";
    
    [self.view addSubview:self.myTableView];
    //https://github.com/321zhangyang/SPHttpWithYYCache
    YYCache *cache=[YYCache cacheWithName:@"theNewsList"];
    if ([cache containsObjectForKey:@"nanny"]) {
        [self analysisDataWithDictionary:(NSDictionary*)[cache objectForKey:@"nanny"] andType:YES];
        [self.myTableView reloadData];
    }
    
    self.pageNum=1;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.myTableView.mj_header.automaticallyChangeAlpha = YES;
    [self loadAgainData];
    [self loadMoreData];
   
   
}
#pragma mark --上拉加载
-(void)loadMoreData{
    __block typeof (self)weakSelf=self;
    // 上拉加载
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if ([weakSelf checkeNetStatue]) {
            [weakSelf loadDataWithBool:NO];
        }else{
            [weakSelf.myTableView.mj_footer endRefreshing];
            UILabel *headerLab=[UILabel new];
            headerLab.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
            headerLab.text=@"没有网络连接，请稍后重试";
            headerLab.backgroundColor=[UIColor colorWithRed:208/255.0f green:228/255.0f blue:240/255.0f alpha:1.0];
            headerLab.textColor=[UIColor colorWithRed:56/255.0f green:154/255.0f blue:216/255.0f alpha:1.0];
            headerLab.textAlignment=NSTextAlignmentCenter;
            weakSelf.myTableView.tableFooterView=headerLab;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.myTableView.tableFooterView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height+38, [UIScreen mainScreen].bounds.size.width, 0);
                    weakSelf.myTableView.tableFooterView=nil;
                } completion:^(BOOL finished) {
                    
                }];
                
            });
        }
        
        
        
    }];
}
#pragma mark --下拉刷新
-(void)loadAgainData{
    __block typeof (self)weakSelf=self;
    self.myTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([weakSelf checkeNetStatue]) {
            NSLog(@"网络连接成功");
            [weakSelf loadDataWithBool:YES];
        }else{
            [weakSelf.myTableView.mj_header endRefreshing];
            UILabel *headerLab=[UILabel new];
            headerLab.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
            headerLab.text=@"没有网络连接，请稍后重试";
            headerLab.backgroundColor=[UIColor colorWithRed:208/255.0f green:228/255.0f blue:240/255.0f alpha:1.0];
            headerLab.textColor=[UIColor colorWithRed:56/255.0f green:154/255.0f blue:216/255.0f alpha:1.0];
            headerLab.textAlignment=NSTextAlignmentCenter;
            weakSelf.myTableView.tableHeaderView=headerLab;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.myTableView.tableHeaderView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
                    weakSelf.myTableView.tableHeaderView=nil;
                } completion:^(BOOL finished) {
                    
                }];
                
            });
        }
        
        
    }];
}
#pragma mark --请求数据
-(void)loadDataWithBool:(BOOL)type{
    if (!type) {
        self.pageNum+=1;
    }else{
        self.pageNum=1;
    }
    
    NSString *paramStr=[NSString stringWithFormat:@"lifeShop/selectLifeShop.htm?mtype=%@&uid=%@&pageNow=%d",@"101",@"442",self.pageNum];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASEURL,paramStr];
    NSLog(@"%@",urlStr);
    [httpTool ZBGetNetDataWith:urlStr withDic:nil andSuccess:^(NSDictionary *dictionary) {
        //PPDemos
        
        [self analysisDataWithDictionary:dictionary andType:type];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        [self.myTableView reloadData];
        YYCache *cache=[YYCache cacheWithName:@"theNewsList"];
        [cache setObject:dictionary forKey:@"nanny"];
    } andFailure:^{
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    /*
     //从服务器获取页码
     totalPage = (int)[infoDict objectForKey:@"page"];
     
     
     
     self.maxtime = [infoDict objectForKey:@"maxtime"];
     
     if (page == 0) {
     [_pictures removeAllObjects];
     }
     //判断是否有菊花正在加载，如果有，判断当前页数是不是大于最大页数，是的话就不让加载，直接return；（因为下拉的当前页永远是最小的，所以直接return）
     if (isJuhua) {
     if (page >= totalPage) {
     [self endRefresh];
     }
     return ;
     }
     //没有菊花正在加载，所以设置yes
     isJuhua = YES;
     //显然下面的方法适用于上拉加载更多
     if (page >= totalPage) {
     [self endRefresh];
     return;
     }
     */
    /*lifeShop/selectLifeShop.htm?mtype=%@&uid=%@&pageNow=%d
     NSMutableDictionary *params=[NSMutableDictionary dictionary];
     params[@"mtype"]=@"101";
     params[@"uid"]=@"187";
     params[@"pageNow"]=self.pageNum;
     //101
     //187
     //1
     */
}
#pragma mark --处理数据
- (void)analysisDataWithDictionary:(NSDictionary*)dictionary andType:(BOOL)type{
    NSMutableArray *tempArry=[NSMutableArray array];
    NSArray*listArr=[dictionary objectForKey:@"data"];
    for (NSDictionary *dic in listArr) {
        JXModel *jxModel=[[JXModel alloc]initWithDic:dic];
        [tempArry addObject:jxModel];
    }
    type?(self.totalArr=[tempArry mutableCopy]):([_totalArr addObjectsFromArray:[tempArry copy]]);
}
#pragma mark --判断网络状态
- (BOOL)checkeNetStatue{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (appDelegate.status==AFNetworkReachabilityStatusNotReachable) {
        NSLog(@"请设置网络");
        return NO;
    }else{
        return YES;
    }
}
#pragma mark--tableViewDelegate/dateSourece
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JXBaseCell *cell=[JXBaseCell theShareCellWithTableView:tableView];
    cell.jxModel=self.totalArr[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXModel *jxModel=self.totalArr[indexPath.row];
    return [JXBaseCell getCellHeight:jxModel];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.totalArr.count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //  [self.navigationController pushViewController:[jiazhengmessageController new] animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //分割线补全
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark --EMPTY TABLE DELEGATE (空白数据)
/*
 //MARK:-EMPTY TABLE DELEGATE
 - (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
 {
 
 
 UIImage *image=[UIImage imageNamed:@"notask_icon"];
 return image;
 
 }
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSLog(@"buttonImageForEmptyDataSet:button_image");
    return [UIImage imageNamed:@"01"];
}
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = @"要闻为您服务";
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//
//}
#pragma mark -- 空白点击button 响应
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    if ([self checkeNetStatue]) {
        [self loadDataWithBool:YES];
    }else{
        
        UILabel *headerLab=[UILabel new];
        headerLab.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
        headerLab.text=@"没有网络连接，请稍后重试";
        headerLab.backgroundColor=[UIColor colorWithRed:208/255.0f green:228/255.0f blue:240/255.0f alpha:1.0];
        headerLab.textColor=[UIColor colorWithRed:56/255.0f green:154/255.0f blue:216/255.0f alpha:1.0];
        headerLab.textAlignment=NSTextAlignmentCenter;
        self.myTableView.tableFooterView=headerLab;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.myTableView.tableFooterView.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height+38, [UIScreen mainScreen].bounds.size.width, 0);
                self.myTableView.tableFooterView=nil;
            } completion:^(BOOL finished) {
                
            }];
            
        });
    }
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
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
