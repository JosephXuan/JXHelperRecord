//
//  JXThreeCustomCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXThreeCustomCtrl.h"
#import "FloatView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface JXThreeCustomCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation JXThreeCustomCtrl
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /*
     * 设置状态栏颜色
     */
   
     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavWithTitle:@"发现" selectNavBgImgIndex:2 selectedTitleColorIndex:1 createMenuItem:^UIView *(int nIndex) {
        //黑底白字
        
        if(nIndex == 0) {
            
            //可添加控件 比如返回按钮。。。
        }
        if(nIndex == 1) {
            //同上
        }
        
        return nil;
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
     [self ImgTouch];
}
#pragma mark --增加touch
-(void)ImgTouch{
    FloatView *floatImgView=[[FloatView alloc]init];
    floatImgView.tag=101;
    [self.view addSubview:floatImgView];
    floatImgView.frame=CGRectMake(0, 200, 40, 40);
    [floatImgView facingScreenBorderWhenScrolling];
   floatImgView.isMove=NO;
    [floatImgView setTapActionWithBlock:^{
       
        NSLog(@"点我啊 点我啊");
    }];
    
    // 停靠左右两侧
    // STAYMODE_LEFTANDRIGHT = 0,
    // 停靠左侧
    // STAYMODE_LEFT = 1,
    // 停靠右侧
    //  STAYMODE_RIGHT = 2
    //  floatImgView.stayMode=STAYMODE_LEFT;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    UIColor *color = [UIColor blackColor];
    
    CGFloat scrollY =  scrollView.contentOffset.y;
    
    //滚动300以内都会变化，可根据需要调整
    CGFloat alphaScale =1-scrollView.contentOffset.y/300;
    
    if (scrollY == 0) {
        
        [self.navIV setBackgroundColor:[color colorWithAlphaComponent:1]];
        
    }else
    {
        [self.navIV setBackgroundColor:[color colorWithAlphaComponent:alphaScale]];
        
    }
    
    FloatView *floatImgView =( FloatView *)[self.view viewWithTag:101];
    [floatImgView facingScreenBorderWhenScrolling];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
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
