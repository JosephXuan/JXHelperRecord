//
//  JXPhotoBrowserCtrl.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/25.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXPhotoBrowserCtrl.h"
#import "AppTools.h"
#import "AppDelegate.h"
#import "JXPhotoPublishCtrl.h"
#import "PYPhotosView.h"
#import "PYPhotoBrowseView.h"
#import "PYProgressView.h"
#import "PYPhotoView.h"

@interface JXPhotoBrowserCtrl ()<PYPhotosViewDelegate>

@end

@implementation JXPhotoBrowserCtrl
// 初始化
- (void)setup
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishDidCicked)];
    self.title = @"示例控制器";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // 初始化
    [self setup];
    
    // 1. 创建图片链接数组
    NSMutableArray *thumbnailImageUrls = [NSMutableArray array];
    // 添加图片(缩略图)链接
    //https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1347148218,3465343736&fm=23&gp=0.jpg
    //http://ww3.sinaimg.cn/thumbnail/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg
    [thumbnailImageUrls addObject:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1347148218,3465343736&fm=23&gp=0.jpg"];
     [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
     [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
     [thumbnailImageUrls addObject:@"http://ww4.sinaimg.cn/thumbnail/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"];
     [thumbnailImageUrls addObject:@"http://ww2.sinaimg.cn/thumbnail/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
//     [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
//     [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
//     [thumbnailImageUrls addObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg"];
//     [thumbnailImageUrls addObject:@"http://ww1.sinaimg.cn/thumbnail/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];
    
    // 1.2 创建图片原图链接数组
    NSMutableArray *originalImageUrls = [NSMutableArray array];
    // 添加图片(原图)链接
    //
    [originalImageUrls addObject:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1347148218,3465343736&fm=23&gp=0.jpg"];
     [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
     [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
     [originalImageUrls addObject:@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"];
     [originalImageUrls addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
//     [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
//     [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/75b1a75fjw1f6bqn35ij6j20ck0g8jtf.jpg"];
//     [originalImageUrls addObject:@"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg"];
//     [originalImageUrls addObject:@"http://ww1.sinaimg.cn/large/86afb21egw1f6bq3lq0itj20gg0c2myt.jpg"];

    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
    // 设置缩略图数组
    flowPhotosView.thumbnailUrls = thumbnailImageUrls;
    // 设置原图地址
    flowPhotosView.originalUrls = originalImageUrls;
    flowPhotosView.delegate=self;
    // 设置分页指示类型
    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    //竖拍
    NSString*str=@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1347148218,3465343736&fm=23&gp=0.jpg";
    //横排
    NSString *newStr=@"http://wx4.sinaimg.cn/mw690/a131fc47gy1ffyjbsvlacj20zk0qotgj.jpg";
    CGSize size = [PYPhotosView getImageSizeWithURL:str];
    NSLog(@">>>%f>>>%f",size.width,size.height);
    CGFloat width;
    CGFloat hight;
    if (originalImageUrls.count==1) {
        
        if (hight>=width) {
            width =size.width/5;
            hight=size.height/5;
        }else{
            width=size.width/5;
            hight=size.height/5;
        }
        if(width!=0.f&&hight!=0.f){
            flowPhotosView.py_size=CGSizeMake(width, hight);
        }else{
            flowPhotosView.py_size=CGSizeMake(100, 100);
        }
        
        
    }
    flowPhotosView.py_centerX = self.view.py_centerX;
    flowPhotosView.py_y = 20 + 64;
    
    
    /*
      */
     // 2.2创建线性布局
     PYPhotosView *linePhotosView = [PYPhotosView photosViewWithThumbnailUrls:thumbnailImageUrls originalUrls:originalImageUrls layoutType:PYPhotosViewLayoutTypeLine];
     // 设置Frame
     linePhotosView.py_y = CGRectGetMaxY(flowPhotosView.frame) + PYMargin * 2;
     linePhotosView.py_x = PYMargin;
     linePhotosView.py_width = self.view.py_width - linePhotosView.py_x * 2;
     linePhotosView.photoWidth=200;
     linePhotosView.photoHeight=200;
    
    // 3. 添加到指定视图中
    [self.view addSubview:flowPhotosView];
    [self.view addSubview:linePhotosView];

}
#pragma mark --PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView willShowWithPhotos:(NSArray<PYPhoto *> *)photos index:(NSInteger)index{
    
}
- (void)photosView:(PYPhotosView *)photosView didShowWithPhotos:(NSArray<PYPhoto *> *)photos index:(NSInteger)index{
    
}

#pragma mark publishDidCicked
// 点击发布时调用
- (void)publishDidCicked
{
    
  
    JXPhotoPublishCtrl *publishVc = [[JXPhotoPublishCtrl alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:publishVc];
    [self presentViewController:nav animated:YES completion:nil];
      /*
     */
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
