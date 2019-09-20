//
//  PlayerViewOtherCtrl.m
//  TestFontAutoSize
//
//  Created by kk on 2018/4/19.
//  Copyright © 2018年 Joseph_Xuan. All rights reserved.
//

#import "PlayerViewOtherCtrl.h"

//#import "UITableView+WebVideoCache.h"
//#import "UITableViewCell+WebVideoCache.h"
#import "PlayerTabCell.h"
#import "PlayerViewOtherCtrl.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *homeApplianceLifeCellID=@"homeApplianceLifeCellID";
@interface PlayerViewOtherCtrl ()<UITableViewDelegate,UITableViewDataSource>
/**
 * Arrary of video paths.
 * 播放路径数组集合.
 */
@property(nonatomic, strong, nonnull)NSArray *pathStrings;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PlayerViewOtherCtrl

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight-64-44) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[PlayerTabCell class]  forCellReuseIdentifier:homeApplianceLifeCellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setUP];
    [self.view addSubview:self.tableView];
}

#pragma mark - Data Srouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return self.pathStrings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerTabCell *cell=[PlayerTabCell cellWithTableView:tableView withIdentifier:homeApplianceLifeCellID indexPath:indexPath];
    cell.headerImgView.image = [UIImage imageNamed:@"01"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
//    NSURL *url = [NSURL URLWithString:self.pathStrings[indexPath.row]];
//    [cell.headerImgView jp_playVideoWithURL:url
//                       options:kNilOptions
//       configurationCompletion:nil];
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
    
//    PlayerViewOtherCtrl *vc=[[PlayerViewOtherCtrl alloc]init];
//
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
}

/**
 * Called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
   // [self.tableView jp_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

/**
 * Called on tableView is static after finger up if the user dragged and tableView is scrolling.
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   // [self.tableView jp_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // [self.tableView jp_scrollViewDidScroll];
}


#pragma mark - JPTableViewPlayVideoDelegate

- (void)tableView:(UITableView *)tableView willPlayVideoOnCell:(UITableViewCell *)cell {
//    [cell.jp_videoPlayView jp_resumeMutePlayWithURL:cell.jp_videoURL
//                                 bufferingIndicator:nil
//                                       progressView:nil
//                            configurationCompletion:nil];
}
#pragma mark --数据源
-(void)setUP{
    //self.tableView.jp_delegate = self;
    //JPScrollPlayStrategyTypeBestCell
   // self.tableView.jp_scrollPlayStrategyType =JPScrollPlayStrategyTypeBestCell;
    
    self.pathStrings = @[
                         @"http://p11s9kqxf.bkt.clouddn.com/iPhone.mp4",
                         @"http://p11s9kqxf.bkt.clouddn.com/faceid.mp4",
                         @"http://p11s9kqxf.bkt.clouddn.com/lavameface.mp4",
                         
                         ];
}
- (void)dealloc {
    
//    if (self.tableView.jp_playingVideoCell) {
//        [self.tableView.jp_playingVideoCell.jp_videoPlayView jp_stopPlay];
//    }
    
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
