//
//  RTProgressCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/12.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "RTProgressCtrl.h"
#import "RTProgressView.h"
@interface RTProgressCtrl ()

@end

@implementation RTProgressCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     //kProgressStyleSpecial + isHorizontal
     
     NSArray *titleArr = @[@"提交申请",@"处理中",@"提现完成"];
     NSArray *detailArr = @[@"2016-06-12-14:40",@"2016-06-12-14:45",@""];
     
     RTProgressView *progress = [[RTProgressView alloc] initWithFrame:CGRectMake(0, 50, 380, 450)];
     [self.view addSubview:progress];
     
     [progress setNodeOrdinal:2 statusCodeError:YES];
     
     [progress showProgressViewWithTitleArray:titleArr detailArray:detailArr isHorizontal:YES style:kProgressStyleSpecial];
     
     */
    
    /*
     
     //kProgressStyleSpecial + vertical
     
     NSArray *titleArr = @[@"2016-06-12-14:40",@"2016-06-12-14:45",@"2016-06-12-15:30"];
     NSArray *detailArr = @[@"提现失败,主要是因为房东被列入黑名单",@"您的提现申请银行正在处理中,预计2016年6月10日15:26提交银行",@"您的提现申请已经成功提交"];
     
     RTProgressView *progress = [[RTProgressView alloc] initWithFrame:CGRectMake(0, 50, 380, 350)];
     [self.view addSubview:progress];
     
     [progress setNodeOrdinal:0 statusCodeError: YES];
     
     [progress showProgressViewWithTitleArray:titleArr detailArray:detailArr isHorizontal:NO style:kProgressStyleSpecial];
     
     */
    
    /* kProgressStyleNormal + vertical
     
     NSArray *titleArr = @[@"房东确认有房后,请在线支付全部房费",@"提前三天12:00前",@"5月2日11:00前",@"2月2日12点后"];
     NSArray *detailArr = @[@"",@"取消订单,可全额取消",@"取消订单,收取罚金为房费的3%",@"不允许取消订单"];
     
     RTProgressView *progress = [[RTProgressView alloc] initWithFrame:CGRectMake(0, 50, 380, 300)];
     [self.view addSubview:progress];
     
     [progress setWarningArray:@[@"%"]];
     
     [progress showProgressViewWithTitleArray:titleArr detailArray:detailArr isHorizontal:NO style:kProgressStyleNormal];
     */
    
    
    //kProgressStyleSpecial + isHorizontal
    
    NSArray *titleArr = @[@"房东确认有房后,请在线支付全部房费",@"5月2日11:00前",@"2月2日12点后"];
    NSArray *detailArr = @[@"",@"取消订单,收取罚金为房费的3%",@"不允许取消订单"];
    
    RTProgressView *progress = [[RTProgressView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 300)];
    [self.view addSubview:progress];
    
    [progress setWarningArray:@[@"%"]];
    
    [progress showProgressViewWithTitleArray:titleArr detailArray:detailArr isHorizontal:YES style:kProgressStyleNormal];
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
