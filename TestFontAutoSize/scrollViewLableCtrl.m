//
//  scrollViewLableCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/28.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "scrollViewLableCtrl.h"
#import "SXMarquee.h"
#import "UIColor+Wonderful.h"
@interface scrollViewLableCtrl ()

@end

@implementation scrollViewLableCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    SXMarquee *mar = [[SXMarquee alloc]initWithFrame:CGRectMake(20, 255, 335, 35) speed:4 Msg:@"重大活动，天猫的双十一，然而并没卵用" bgColor:[UIColor salmonColor] txtColor:[UIColor whiteColor]];
    [mar changeMarqueeLabelFont:[UIFont systemFontOfSize:26]];
    [mar changeTapMarqueeAction:^{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"点击事件" message:@"可以设置弹窗，当然也能设置别的" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }];
    [mar start];
     [self.view addSubview:mar];
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
