//
//  JXFourCustomCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/26.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXFourCustomCtrl.h"
#import "PushVC.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define TMThemeColor UIColorFromRGB(0x39414d)
@interface JXFourCustomCtrl ()
@property (nonatomic, strong)UISearchBar *searchBar;
@end

@implementation JXFourCustomCtrl
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 //   [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    [self createNavWithTitle:@"" selectNavBgImgIndex:0 selectedTitleColorIndex:0 createMenuItem:^UIView *(int nIndex) {
        
        if(nIndex == 0) {
            
            //可添加控件 比如返回按钮。。。
            
            
        }
        if(nIndex == 1) {
            //同上
        }
        
        return nil;
    }];
    
    //可在导航栏添加需要的控件
    //颜色方法
    
    
   
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.frame =CGRectMake(48,7,kWidth - 100,30);
    
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    //设置背景图片
    [_searchBar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchBar setBackgroundColor:[UIColor yellowColor]];
    //设置文本框背景
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
//    _searchBar.barTintColor = TMThemeColor;
//    _searchBar.backgroundColor=TMThemeColor;
    _searchBar.placeholder = @"搜索";
    _searchBar.layer.cornerRadius=15;
    _searchBar.layer.masksToBounds=YES;
    [_searchBar.layer setBorderWidth:1];
    [self.navView addSubview:_searchBar];
    
    [self.searchBar becomeFirstResponder];
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    pushBtn.frame = CGRectMake(20, 144, kWidth - 40, 40);
    [pushBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    pushBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:pushBtn];
}
-(UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


-(void)pushVC{
    
    PushVC *pvc=[[PushVC alloc]init];
    
    [self.navigationController pushViewController:pvc animated:YES];
    // self.hidesBottomBarWhenPushed=NO;
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
