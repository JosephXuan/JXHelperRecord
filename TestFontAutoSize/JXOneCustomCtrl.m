//
//  JXOneCustomCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXOneCustomCtrl.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface JXOneCustomCtrl ()<UIScrollViewDelegate>
@property(nonatomic,strong)UITextView *myTextView;
@end

@implementation JXOneCustomCtrl
-(UITextView *)myTextView{
    if (!_myTextView) {
        _myTextView=[[UITextView alloc]init];
    }
    return _myTextView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    
    [self createNavWithTitle:@"首页" selectNavBgImgIndex:0 selectedTitleColorIndex:0 createMenuItem:^UIView *(int nIndex) {
        
        if(nIndex == 0) {
            
            //可添加控件 比如返回按钮。。。
        }
        if(nIndex == 1) {
            //同上
        }
        
        return nil;
    }];
    self.myTextView.frame=CGRectMake(20, 144, kWidth - 40, 40);
   // self.myTextView.
    [self.view addSubview:self.myTextView];
    self.myTextView.showsHorizontalScrollIndicator=YES;
    self.myTextView.contentSize=CGSizeMake(2000, 0);
  // self.myTextView.textContainer.maximumNumberOfLines=1;
    self.myTextView.textContainer.lineBreakMode=NSLineBreakByTruncatingHead;
    self.myTextView.text=@"aFSFSFWFSAF很快的看aFSFSFWFSAF很快的看aFSFSFWFSAF很快的看aFSFSFWFSAF很快的看aFSFSFWFSAF很快的看";
    
   
    
  //  self.tableView.delegate=self;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
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
