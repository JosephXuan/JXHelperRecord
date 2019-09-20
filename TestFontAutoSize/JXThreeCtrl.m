//
//  JXThreeCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/24.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXThreeCtrl.h"

@interface JXThreeCtrl ()

@end

@implementation JXThreeCtrl
-(void)viewWillAppear:(BOOL)animated{
       [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
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
