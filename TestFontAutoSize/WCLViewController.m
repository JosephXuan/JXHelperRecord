//
//  WCLViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/12.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "WCLViewController.h"

@interface WCLViewController ()

@end

@implementation WCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"裁剪图片" style:UIBarButtonItemStyleDone target:self action:@selector(gotoSelectPhotoViewController)];
    self.navigationItem.rightBarButtonItem = item;
    
    //裁剪完成图片显示
    self.finshIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    self.finshIV.layer.borderWidth = 1;
    self.finshIV.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:self.finshIV];
}
- (void)gotoSelectPhotoViewController{
    
    WCLActionSheet *actionSheet = [[WCLActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"从相册选择", nil];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [actionSheet showInView:window];
}


#pragma -mark WCLActionSheetDelegate
- (void)actionImageSheet:(WCLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    WCLImagePicker *imagePicker = [WCLImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self heightCompareWidthScale:1.0 isCropImage:YES];
    
}
#pragma -mark WCLImagePickerDelegate
- (void)imagePicker:(WCLImagePicker *)imagePicker didFinished:(UIImage *)editedImag{
    
    self.finshIV.image = editedImag;
};

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
