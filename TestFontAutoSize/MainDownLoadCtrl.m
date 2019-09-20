//
//  MainDownLoadCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/1.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "MainDownLoadCtrl.h"
#import "DownLoadListCtrl.h"
@interface MainDownLoadCtrl ()

@end

@implementation MainDownLoadCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)clicked:(UIButton *)btn{
    
    DownLoadListCtrl *dlvc=[[DownLoadListCtrl alloc]init];
   // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:dlvc];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //渐变出现
        dlvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        dlvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        dlvc.providesPresentationContextTransitionStyle = YES;
        dlvc.definesPresentationContext = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self presentViewController:dlvc animated:YES completion:nil];
        });
        
    });
    
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
