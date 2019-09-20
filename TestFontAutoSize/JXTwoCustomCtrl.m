//
//  JXTwoCustomCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXTwoCustomCtrl.h"

@interface JXTwoCustomCtrl ()

@end

@implementation JXTwoCustomCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createNavWithTitle:@"" selectNavBgImgIndex:1 selectedTitleColorIndex:0 createMenuItem:^UIView *(int nIndex) {
        
        //示例图片尺寸为56 X 17 如需调整 请到JLBaseViewController.m 中 bgIndex==1处修改
        [self.titleImage setImage:[UIImage imageNamed:@"fabu"]];
        
        if(nIndex == 0) {
            
            //可添加控件 比如返回按钮。。。
        }
        if(nIndex == 1) {
            //同上
        }
        
        return nil;
    }];
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
