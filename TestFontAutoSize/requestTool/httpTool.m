//
//  httpTool.m
//  DaGuanJia
//
//  Created by 张斌 on 16/11/30.
//  Copyright © 2016年 ck. All rights reserved.
//
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#import "httpTool.h"
#import "AFNetworking.h"
static NSMutableArray *tasks;

@implementation httpTool

+ ( httpTool *)sharedLXNetworking
{
    static  httpTool *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[ httpTool alloc] init];
    });
    return handler;
}

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}
/**
 *  封装的get请求
 *
 *  @param str          url
 *  @param dic          🐹
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (LXURLSessionTask *)ZBGetNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock{
DLog(@"请求地址----%@\n    请求参数----%@",str,dic);
    if (str==nil) {
        return nil;
    }
    NSString *urlStr=[NSURL URLWithString:str]?str:[self strUTF8Encoding:str];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *netManager = [AFHTTPSessionManager manager];
    netManager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval=15.0;
    
    LXURLSessionTask *sessionTask=nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
     sessionTask =[netManager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //DLog(@"请求结果=%@",responseObject);
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        // NSData转为NSString
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        DLog(@"转化结果>>>>%@",jsonStr);
         [[self tasks] removeObject:sessionTask];
        if (successBlock) {
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failueBlock) {
            failueBlock();
        }
    }];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}
/**
 *  封装的post请求
 *
 *  @param str          url
 *  @param dic          参数
 *  @param successBlock 请求成功的回调
 *  @param failueBlock  请求失败的回调
 */
+ (LXURLSessionTask *)ZBPostNetDataWith:(NSString*)str withDic:(NSDictionary*)dic andSuccess:(void(^)(NSDictionary* dictionary))successBlock  andFailure:(void(^)())failueBlock{
    
    AFHTTPSessionManager *netManager   = [AFHTTPSessionManager manager];
    netManager.requestSerializer      = [AFHTTPRequestSerializer serializer];
    netManager.responseSerializer     = [AFHTTPResponseSerializer serializer];
    netManager.requestSerializer.timeoutInterval=15.0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    LXURLSessionTask *sessionTask=nil;
    NSString *urlStr=[NSURL URLWithString:str]?str:[self strUTF8Encoding:str];
    sessionTask =[netManager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (successBlock) {
            successBlock(dic);
        }
        [[self tasks] removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failueBlock) {
            failueBlock();
        }
        [[self tasks] removeObject:sessionTask];

    }];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

/**
 *  3.图片上传
 */
+(LXURLSessionTask *)postUploadWithUrl:(NSString *)urlStr parameters:(id)parameters fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName fileType:(NSString *)fileType  progress:(LXUploadProgress)progress success:(void (^)(id responseObject))success fail:(void (^)())fail{
    
    if (urlStr==nil) {
        return nil;
    }
    AFJSONResponseSerializer *serializer  = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager *manager       = [AFHTTPSessionManager manager];
    manager.responseSerializer         = serializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 15;
     NSString *strUrl=[NSURL URLWithString:urlStr]?urlStr:[self strUTF8Encoding:urlStr];
    LXURLSessionTask *sessionTask=[manager POST:strUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSString *imageFileName = fileName;
        if (fileName == nil || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        //name >>服务器的路径文件名
        //imageFileName 图片名
        //fileType @"image/jpeg"|@"image/png"
        [formData appendPartWithFileData:fileData name:name fileName:imageFileName mimeType:fileType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [[self tasks] removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail();
        }
         [[self tasks] removeObject:sessionTask];
    }];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}
//多张图片一次上传服务器
+(LXURLSessionTask *)postUploadWithUrl:(NSString *)urlStr  uploadImages:(NSArray *)images progress:(LXUploadProgress)progress completion:(void(^)(NSString *url,NSError *error))uploadBlock andPramaDic:(NSDictionary *)paramaDic
{
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    AFHTTPSessionManager * manager     = [AFHTTPSessionManager manager];
    manager.responseSerializer        = serializer;
    
    LXURLSessionTask *sessionTask=[manager POST:urlStr parameters:paramaDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 添加一个标记 去分图片名称
        for(NSInteger i = 0; i < images.count; i++){
            UIImage * image = [images objectAtIndex: i];
            // 压缩图片
            
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            if (data.length>100*1024)
            {
                if (data.length>1024*1024) {//1M以及以上
                    data = UIImageJPEGRepresentation(image, 0.1);
                }else if (data.length>512*1024) {//0.5M-1M
                    data = UIImageJPEGRepresentation(image, 0.5);
                }else if (data.length>200*1024) {//0.25M-0.5M
                    data = UIImageJPEGRepresentation(image, 0.9);
                }
            }
            // 上传的参数名
            NSString *now = [self nowTime:@"yyyyMMddHHmmss"];
            // 后台参数
            NSString * Name = [NSString stringWithFormat:@"%@%zi",now,i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:data name:Name fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    return sessionTask;
    
}
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
                             progress:(LXDownloadProgress)progressBlock
                              success:(LXResponseSuccess)success
                              failure:(LXResponseFail)fail
                              showHUD:(BOOL)showHUD{
    DLog(@"请求地址----%@\n    ",url);
    if (url==nil) {
        return nil;
    }
    /*
    if (showHUD==YES) {
        [MBProgressHUD showHUD];
    }
    */
    //1.设置请求
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //    2.初始化
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask  *sessionTask = nil;
    
    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            DLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载文件成功");
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
                /*
                if (error.code == -1005)
                {
                    message = @"网络异常";
                    
                    NSLog(@"网络异常");
                }else if (error.code == - 1001)
                {
                    message = @"请求超时";
                    
                }else
                {
                    message = @"未知错误";
                    
                }
                 */
            }
        }
        /*
        if (showHUD==YES) {
            [MBProgressHUD dissmiss];
        }
        */
    }];
    
    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

//获取当前时区的当前时间
+ (NSString*)nowTime:(NSString*)dateType
{
    NSDate * date = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    //[dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformat setDateFormat:dateType];
    NSString * newDate= [dateformat stringFromDate:date];
    return newDate;
}
//中文地址
+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
#pragma makr - 开始监听网络连接
/**
 *  获取网络
 */
/**
 *  开启网络监测
 */
+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                [ httpTool sharedLXNetworking].networkStats=StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"没有网络");
                [ httpTool sharedLXNetworking].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                [ httpTool sharedLXNetworking].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [ httpTool sharedLXNetworking].networkStats=StatusReachableViaWiFi;
                DLog(@"WIFI--%d",[httpTool sharedLXNetworking].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}
+ (void)pause:(NSURLSessionDownloadTask *)task
{
    [task suspend];
}

+ (void)start:(NSURLSessionDownloadTask *)task
{
    [task resume];
}
@end
