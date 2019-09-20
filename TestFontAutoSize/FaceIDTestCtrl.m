//
//  FaceIDTestCtrl.m
//  TestFontAutoSize
//
//  Created by kk on 2019/1/23.
//  Copyright © 2019年 Joseph_Xuan. All rights reserved.
//

#import "FaceIDTestCtrl.h"
#import <IDLFaceSDK/IDLFaceSDK.h>
#import "FaceParameterConfig.h"

#import "FaceIDTools.h"
#define scaleValue 0.7

#define ScreenRect [UIScreen mainScreen].bounds
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface FaceIDTestCtrl ()<CaptureDataOutputProtocol>


@property (nonatomic, readwrite, retain) FaceIDTools *videoCapture;
//图片
@property (nonatomic, readwrite, retain) UIImageView *displayImageView;
//提示语lab
@property (strong, nonatomic) UILabel *titleLab;
//是否结束录制
@property (nonatomic, readwrite, assign) BOOL hasFinished;

@property (nonatomic, readwrite, assign) CGRect previewRect;

@property (nonatomic, readwrite, assign) CGRect detectRect;
@end

@implementation FaceIDTestCtrl

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.hasFinished = YES;
    self.videoCapture.runningStatus = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _hasFinished = NO;
    self.videoCapture.runningStatus = YES;
    [self.videoCapture startSession];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"人脸识别";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self registFaceForBiDu];
}
#pragma mark -- 注册

-(void)registFaceForBiDu{
    NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:licensePath], @"license文件路径不对，请仔细查看文档");
    [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    NSLog(@"canWork = %d",[[FaceSDKManager sharedInstance] canWork]);
    NSLog(@"version = %@",[[FaceVerifier sharedInstance] getVersion]);
    
    [self setBaseViewUI];
}

#pragma mark --调用 设置UI
-(void)setBaseViewUI{
    
    _hasFinished=NO;
    // 初始化相机处理类
    self.videoCapture = [[FaceIDTools alloc] init];
    self.videoCapture.delegate = self;
    
  // CGRect detectRect = CGRectMake(ScreenWidth*(1-scaleValue)/2.0, ScreenHeight*(1-scaleValue)/2.0, ScreenWidth*scaleValue, ScreenHeight*scaleValue);
    self.detectRect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    // CGRectMake(circleRect.origin.x - circleRect.size.width*(1/scaleValue-1)/2.0, circleRect.origin.y - circleRect.size.height*(1/scaleValue-1)/2.0 - 60, circleRect.size.width/scaleValue, circleRect.size.height/scaleValue);
    self.previewRect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
   
    self.displayImageView = [[UIImageView alloc] initWithFrame:self.detectRect];
    self.displayImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.displayImageView];
    
    self.titleLab=[[UILabel alloc]init];
    self. titleLab.frame=CGRectMake(0, 100, ScreenWidth, 50);[self.view addSubview:self.titleLab];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    //配置
    [self setCustomSDK];
}
#pragma mark --
-(void)setCustomSDK{
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:200];
    
    // 设置截取人脸图片大小
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:400];
    
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
    
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:40];
    
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.7];
    
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:10 yaw:10 roll:10];
    
    // 设置是否进行人脸图片质量检测
    [[FaceSDKManager sharedInstance] setIsCheckQuality:YES];
    
    // 设置超时时间
    [[FaceSDKManager sharedInstance] setConditionTimeout:10];
    
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
    
    // 设置照片采集张数
    [[FaceSDKManager sharedInstance] setMaxCropImageNum:1];
}

- (void)captureOutputSampleBuffer:(UIImage *)image {
    if (_hasFinished) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.displayImageView.image = image;
    });
    [self faceProcesss:image];
}

- (void)captureError {
    NSString *errorStr = @"出现未知错误，请检查相机设置";
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        errorStr = @"相机权限受限,请在设置中启用";
    }
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"知道啦");
        }];
        [alert addAction:action];
        UIViewController* fatherViewController = weakSelf.presentingViewController;
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [fatherViewController presentViewController:alert animated:YES completion:nil];
        }];
    });
}

#pragma mark --获取id的实现方法

- (void)faceProcesss:(UIImage *)image {
    if (self.hasFinished) {
        return;
    }
    /*不论带不带黑边，取图片都是：images[@"bestImage"]*/
    //带黑边的方法
    __weak typeof(self) weakSelf = self;
    [[IDLFaceDetectionManager sharedInstance] detectStratrgyWithQualityControlImage:image previewRect:self.previewRect detectRect:self.detectRect completionHandler:^(FaceInfo *faceinfo, NSDictionary *images, DetectRemindCode remindCode) {
        switch (remindCode) {
            case DetectRemindCodeOK: {
                weakSelf.hasFinished = YES;
                [self warningStatus:0 warning:@"非常好"];
                if (images[@"bestImage"] != nil && [images[@"bestImage"] count] != 0) {
                    NSData* data = [[NSData alloc] initWithBase64EncodedString:[images[@"bestImage"] lastObject] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage* bestImage = [UIImage imageWithData:data];
                    NSLog(@"bestImage = %@",bestImage);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //
                    /*
                    [UIView animateWithDuration:0.5 animations:^{
                        weakSelf.animaView.alpha = 1;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.5 animations:^{
                            weakSelf.animaView.alpha = 0;
                        } completion:^(BOOL finished) {
                     [weakSelf closeAction];
                        }];
                        
                    }];
                     */
                });
                [self jumpSuccessCtrl];
                break;
            }
            case DetectRemindCodePitchOutofDownRange:
                [self warningStatus:0 warning:@"建议略微抬头"];
                
                break;
            case DetectRemindCodePitchOutofUpRange:
                [self warningStatus:0 warning:@"建议略微低头"];
               
                break;
            case DetectRemindCodeYawOutofLeftRange:
                [self warningStatus:0 warning:@"建议略微向右转头"];
               
                break;
            case DetectRemindCodeYawOutofRightRange:
                [self warningStatus:0 warning:@"建议略微向左转头"];
                
                break;
            case DetectRemindCodePoorIllumination:
                [self warningStatus:0 warning:@"光线再亮些"];
                
                break;
            case DetectRemindCodeNoFaceDetected:
                [self warningStatus:0 warning:@"把脸移入框内"];
               
                break;
            case DetectRemindCodeImageBlured:
                [self warningStatus:0 warning:@"请保持不动"];
               
                break;
            case DetectRemindCodeOcclusionLeftEye:
                [self warningStatus:0 warning:@"左眼有遮挡"];
                
                break;
            case DetectRemindCodeOcclusionRightEye:
                [self warningStatus:0 warning:@"右眼有遮挡"];
                
                break;
            case DetectRemindCodeOcclusionNose:
                [self warningStatus:0 warning:@"鼻子有遮挡"];
                
                break;
            case DetectRemindCodeOcclusionMouth:
                [self warningStatus:0 warning:@"嘴巴有遮挡"];
                
                break;
            case DetectRemindCodeOcclusionLeftContour:
                [self warningStatus:0 warning:@"左脸颊有遮挡"];
               
                break;
            case DetectRemindCodeOcclusionRightContour:
                [self warningStatus:0 warning:@"右脸颊有遮挡"];
                
                break;
            case DetectRemindCodeOcclusionChinCoutour:
                [self warningStatus:0 warning:@"下颚有遮挡"];
               
                break;
            case DetectRemindCodeTooClose:
                [self warningStatus:0 warning:@"手机拿远一点"];
               
                break;
            case DetectRemindCodeTooFar:
                [self warningStatus:0 warning:@"手机拿近一点"];
               
                break;
            case DetectRemindCodeBeyondPreviewFrame:
                [self warningStatus:0 warning:@"把脸移入框内"];
                
                break;
            case DetectRemindCodeVerifyInitError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyDecryptError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyInfoFormatError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyExpired:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyMissRequiredInfo:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyInfoCheckError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyLocalFileError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeVerifyRemoteDataError:
                [self warningStatus:0 warning:@"验证失败"];
                break;
            case DetectRemindCodeTimeout: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"remind" message:@"超时" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* action = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSLog(@"知道啦");
                    }];
                    [alert addAction:action];
                    UIViewController* fatherViewController = weakSelf.presentingViewController;
                    [weakSelf dismissViewControllerAnimated:YES completion:^{
                        [fatherViewController presentViewController:alert animated:YES completion:nil];
                    }];
                });
                break;
            }
            case DetectRemindCodeConditionMeet: {
               // self.circleView.conditionStatusFit = true;
            }
                break;
            default:
                break;
        }
        if (remindCode == DetectRemindCodeConditionMeet || remindCode == DetectRemindCodeOK) {
           // self.circleView.conditionStatusFit = true;
        }else {
           // self.circleView.conditionStatusFit = false;
        }
    }];
}

#pragma mark --提示语
- (void)warningStatus:(NSInteger)status warning:(NSString *)warning{
    NSLog(@">>>%@",warning);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLab.text=warning;
    });
}

#pragma mark --成功跳界面
-(void)jumpSuccessCtrl{
    
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
