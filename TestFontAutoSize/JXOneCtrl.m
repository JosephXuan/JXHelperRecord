//
//  JXOneCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/24.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXOneCtrl.h"
#import "JXOneDetailCtrl.h"
@interface JXOneCtrl ()

@end

@implementation JXOneCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor purpleColor]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark --点击
-(void)clicked:(UIButton *)button{
    JXOneDetailCtrl *ovc=[[JXOneDetailCtrl alloc]init];
    
    [self.navigationController pushViewController:ovc animated:YES];
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
