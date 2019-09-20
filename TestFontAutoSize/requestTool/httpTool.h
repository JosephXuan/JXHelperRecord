//
//  httpTool.h
//  DaGuanJia
//
//  Created by 张斌 on 16/11/30.
//  Copyright © 2016年 ck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

typedef enum{
    
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}NetworkStatus;

typedef void( ^ LXResponseSuccess)(id response);

typedef void( ^ LXResponseFail)(NSError *error);

//上传进度
typedef void( ^ LXUploadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

//下载进度
typedef void( ^ LXDownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask LXURLSessionTask;

@interface httpTool : NSObject
/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  获取网络
 */
@property (nonatomic,assign)NetworkStatus networkStats;

/**
 *  封装的get请求
 *
 *  @param str          url
 *  @param dic          🐹
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (LXURLSessionTask *)ZBGetNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;
/**
 *  封装的post请求
 *
 *  @param str          url
 *  @param dic          参数
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (LXURLSessionTask *)ZBPostNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock;
/**
 *  3.图片上传
 */
+ (LXURLSessionTask *)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType  progress:(LXUploadProgress)progress success:(void (^)(id responseObject))success fail:(void (^)())fail;
//多张图片一次上传服务器
+ (LXURLSessionTask *)postUploadWithUrl:(NSString *)urlStr  uploadImages:(NSArray *)images progress:(LXUploadProgress)progress completion:(void(^)(NSString *url,NSError *error))uploadBlock andPramaDic:(NSDictionary *)paramaDic;
/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (NSURLSessionDownloadTask  *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(LXDownloadProgress )progressBlock
                              success:(LXResponseSuccess )success
                              failure:(LXResponseFail )fail
                              showHUD:(BOOL)showHUD;


//获取当前时区的当前时间
+ (NSString*)nowTime:(NSString*)dateType;
//暂停
+(void)pause:(NSURLSessionDownloadTask *)task;
//开始
+(void)start:(NSURLSessionDownloadTask *)task;
@end
