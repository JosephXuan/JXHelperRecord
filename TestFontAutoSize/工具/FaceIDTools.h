//
//  FaceIDTools.h
//  TestFontAutoSize
//
//  Created by kk on 2019/1/23.
//  Copyright © 2019年 Joseph_Xuan. All rights reserved.
//
//三生三世
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//处理相机流
NS_ASSUME_NONNULL_BEGIN

@protocol CaptureDataOutputProtocol;

@interface FaceIDTools : NSObject

@property (nonatomic, readwrite, weak) id<CaptureDataOutputProtocol> delegate;

@property (nonatomic, readwrite, assign) BOOL runningStatus;

/**
 * 设定使用前置摄像头或者后置摄像头
 * AVCaptureDevicePositionFront 前置摄像头(默认)
 * AVCaptureDevicePositionBack 后置摄像头
 */
@property (nonatomic, readwrite, assign) AVCaptureDevicePosition position;

- (void)startSession;

- (void)stopSession;

- (void)resetSession;

@end

@protocol CaptureDataOutputProtocol <NSObject>

/**
 * 回调每一个分帧的image
 */
- (void)captureOutputSampleBuffer:(UIImage *)image;

- (void)captureError;

@end

NS_ASSUME_NONNULL_END
