//
//  WCLImagePicker.m
//  WCLPictureClippingRotation
//
//  Created by wcl on 2016/12/28.
//  Copyright © 2016年 QianTangTechnology. All rights reserved.
//

#import "WCLImagePicker.h"
#import "WCLPictureViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WCLImagePicker()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,WCLCutPictureDelegate>{
    double _scale;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) WCLPictureViewController *imageCropperController;
@property (nonatomic,assign) BOOL isCropImage;

@end

@implementation WCLImagePicker

#pragma  mark -- 单例 --
+ (instancetype)sharedInstance
{
    static dispatch_once_t ETToken;
    static WCLImagePicker *sharedInstance = nil;
    dispatch_once(&ETToken, ^{
        sharedInstance = [[WCLImagePicker alloc] init];
        
    });
    return sharedInstance;
}
- (void)showImagePickerWithType:(NSInteger)type InViewController:(UIViewController *)viewController heightCompareWidthScale:(double)scale isCropImage:(BOOL)isCrop{
    if (type == 0) {
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if(scale>0 &&scale<=1.5){
        _scale = scale;
    }else{
        _scale = 1;
    }
    
    self.isCropImage = isCrop;
    [viewController presentViewController:_imagePickerController animated:YES completion:nil];
}
- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
    }
    return _imagePickerController;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageOrientation imageOrientation=image.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    if (self.isCropImage) {
        
        self.imageCropperController = [[WCLPictureViewController alloc] initWithImage:image cropFrame:CGRectMake(0, (ScreenHeight-ScreenWidth*_scale)/2, ScreenWidth, ScreenWidth*_scale)];
        self.imageCropperController.delegate = self;
        [picker pushViewController:self.imageCropperController animated:YES];
        
    }else{
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        if (_delegate && [_delegate respondsToSelector:@selector(imagePicker:didFinished:)]) {
            [_delegate imagePicker:self didFinished:image];
        }
        
    }
    
}


- (void)imageCropperDidCancel:(WCLPictureViewController *)cropperViewController{
    
    UIImagePickerController *picker = (UIImagePickerController *)cropperViewController.navigationController;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [cropperViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [cropperViewController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)imageCropper:(WCLPictureViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(imagePicker:didFinished:)]) {
        [_delegate imagePicker:self didFinished:editedImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(imagePickerDidCancel:)]) {
        
        [_delegate imagePickerDidCancel:self];
        
    }
}


@end
