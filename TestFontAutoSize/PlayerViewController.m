//
//  PlayerViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/15.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "PlayerViewController.h"


#import "PlayerTabCell.h"
#import "PlayerViewOtherCtrl.h"

#import "Masonry.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


static NSString *homeApplianceLifeCellID=@"homeApplianceLifeCellID";
@interface PlayerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSIndexPath *_lastIndexPath;
}
/**
 * Arrary of video paths.
 * 播放路径数组集合.
 */
@property(nonatomic, strong, nonnull)NSArray *pathStrings;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PlayerViewController
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
   
    
   // [[JPVideoPlayerManager sharedManager] setPlayerMute:YES];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= self.tabBarController.tabBar.bounds.size.height;
  //  self.tableView.jp_tableViewVisibleFrame = tableViewFrame;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   // [self.tableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
  //  [self.tableView jp_playVideoInVisibleCellsIfNeed];
    
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.tableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.tableView.delegate = nil;
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
    /*
     W微博
     */
   // cell.jp_videoURL = [NSURL URLWithString:self.pathStrings[indexPath.row]];
    NSLog(@">>%@<<",self.pathStrings[indexPath.row]);
    if (_lastIndexPath==indexPath) {
        cell.contentView.backgroundColor=[UIColor redColor];
    }else{
       cell.contentView.backgroundColor=[UIColor blackColor];
    }
   //
    /*
    cell.jp_videoPlayView = cell.headerImgView;
    cell.jp_videoPlayView.userInteractionEnabled=YES;
    [tableView jp_handleCellUnreachableTypeForCell:cell atIndexPath:indexPath];
    */
    
    return cell;
}


#pragma mark - TableView Delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"table 点击");
    
  //  PlayerViewOtherCtrl *vc=[[PlayerViewOtherCtrl alloc]init];
    
 //   [self.navigationController pushViewController:vc animated:YES];
    
}
 */

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
    /*
    [cell.jp_videoPlayView jp_resumePlayWithURL:cell.jp_videoURL
                           bufferingIndicator:nil
                                  controlView:[[JPVideoPlayerDetailControlView alloc] initWithControlBar:nil blurImage:nil]
                                 progressView:nil
                      configurationCompletion:^(UIView *view, JPVideoPlayerModel *playerModel) {
                        //  self.muteSwitch.on = ![self.videoContainer jp_muted];
                      }];
     */
    
    
    /*
     //有声音
    [cell.jp_videoPlayView jp_playVideoWithURL:cell.jp_videoURL
                                       options:kNilOptions
                       configurationCompletion:nil];
    */
    /*
     //有声音
    [cell.jp_videoPlayView jp_resumePlayWithURL:cell.jp_videoURL
options:kNilOptions
configurationCompletion:nil];
     */
    
    
    /*
     //有声音
     [cell.jp_videoPlayView jp_playVideoWithURL:cell.jp_videoURL
     bufferingIndicator:nil
     controlView:nil
     progressView:nil
     configurationCompletion:nil];
     */
    
    
    //有声音
    /*
    [cell.jp_videoPlayView jp_resumePlayWithURL:cell.jp_videoURL
                             bufferingIndicator:nil
                                    controlView:nil
                                   progressView:nil
                        configurationCompletion:nil];
    
     */
    
    /*
     有声音然后
    
    PlayerTabCell *mycell =(PlayerTabCell *)cell;
    NSIndexPath *currIndex=[tableView indexPathForCell:mycell];
    _lastIndexPath=currIndex;
    [self.tableView reloadData];
    mycell.contentView.backgroundColor=[UIColor redColor];
    [cell.jp_videoPlayView jp_playVideoMuteWithURL:cell.jp_videoURL
                bufferingIndicator:nil
                      progressView:nil
                           configurationCompletion:^(UIView * _Nonnull view, JPVideoPlayerModel * _Nonnull playerModel) {
                               //有声音
                               [[[JPVideoPlayerManager sharedManager] videoPlayer] setMuted:NO];
                               playerModel.muted=NO;
                               playerModel.volume=0.7;
                               
                               [[[JPVideoPlayerManager sharedManager] videoPlayer] setVolume:0.7];
                           }];
    
     */

    /*
     //无声
    [cell.jp_videoPlayView jp_resumeMutePlayWithURL:cell.jp_videoURL
                                 bufferingIndicator:nil
                                       progressView:nil
                            configurationCompletion:nil];
   
    */
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // [[JPVideoPlayerManager sharedManager] setPlayerMute:YES];
    NSLog(@"zzz");
   // [[[JPVideoPlayerManager sharedManager] videoPlayer] setMuted:NO];
    static int i=0;
    i++;
    if (i%2==0) {
    //  [[[JPVideoPlayerManager sharedManager] videoPlayer] setVolume:0.0];
    }else{
    //   [[[JPVideoPlayerManager sharedManager] videoPlayer] setVolume:0.7];
    }
    
}
#pragma mark --数据源
-(void)setUP{
   // self.tableView.jp_delegate = self;
  //  self.tableView.jp_videoPlayerDelegate = self;
    //JPScrollPlayStrategyTypeBestCell
    // self.tableView.jp_scrollPlayStrategyType =JPScrollPlayStrategyTypeBestCell;
    
    self.pathStrings = @[
                         @"http://p11s9kqxf.bkt.clouddn.com/faceid.mp4",
                         @"http://p11s9kqxf.bkt.clouddn.com/iPhone.mp4",
                         @"http://p11s9kqxf.bkt.clouddn.com/lavameface.mp4",
                        
                         ];
}
- (void)dealloc {
    /*
    if (self.tableView.jp_playingVideoCell) {
        [self.tableView.jp_playingVideoCell.jp_videoPlayView jp_stopPlay];
    }
    */
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
