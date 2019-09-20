//
//  BaseNavigationController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navBar=[UINavigationBar appearance];
    //2.设置导航栏字体的颜色
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSShadowAttributeName:[NSValue valueWithUIOffset:UIOffsetZero]}];
    [navBar setBarTintColor:[UIColor whiteColor]];
    navBar.tintColor = [UIColor blackColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil]];
}
#pragma mark --返回状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
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
