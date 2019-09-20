//
//  ClipViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/12.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "ClipViewController.h"
#import "ClipImageView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface ClipViewController ()
@property (nonatomic, strong) ClipImageView *clipImageView;
@end

@implementation ClipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片裁剪";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClipImage:)];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(successClipImage:)];
    
    self.view.backgroundColor = [UIColor blackColor];
#warning 加载 原图
    [self.view addSubview:self.clipImageView];
    self.clipImageView.clipImage = self.needClipImage;
    
    /*
     * 第一步 上一界面写跳转页面实现代理方法 (点击取消 ,完成 界面消失)
     ClipViewController *clipVC = [[ClipViewController alloc] init];
     
     clipVC.delegate = self;
     clipVC.needClipImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
     [picker pushViewController:clipVC animated:YES];
     */
    /*
     * 上一界面实现的代理方法
     #pragma mark  -- ClipViewControllerDelegate
     
     - (void)didSuccessClipImage:(UIImage *)clipedImage
     {
     self.clipedImageView.backgroundColor = [UIColor redColor];
     self.clipedImageView.contentMode = UIViewContentModeScaleAspectFit;
     self.clipedImageView.image = clipedImage;
     
     [self dismissViewControllerAnimated:YES completion:nil];
     整体 相册 dissmiss
     }
     */
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 从相机界面跳转会默认隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
}

// 取消裁剪
- (void)cancelClipImage:(UIBarButtonItem *)sender
{
    if([self.delegate respondsToSelector:@selector(didSuccessClipImage:)])
    {
        [self.delegate didSuccessClipImage:nil];
    }
}

// 裁剪成功
- (void)successClipImage:(UIBarButtonItem *)sender
{
    UIImage *clipedImage = [self.clipImageView getClipedImage];
    if([self.delegate respondsToSelector:@selector(didSuccessClipImage:)])
    {
        [self.delegate didSuccessClipImage:clipedImage];
    }
}



#pragma mark -- getter

- (ClipImageView *)clipImageView
{
    if(!_clipImageView)
    {
        
        //CGRectMake(0, 100, Screen_Width, 400) 矩形
        _clipImageView = [ClipImageView initWithFrame:CGRectMake(0, 100, Screen_Width, 400)];
        //_clipImageView.contentMode = UIViewContentModeScaleAspectFit;
        _clipImageView.midLineColor = [UIColor redColor];
        _clipImageView.clipType = ClipAreaViewTypeArc;
        //ClipAreaViewTypeRect
        //
    }
    return _clipImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     NSLog(@"didReceiveMemoryWarning");
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
