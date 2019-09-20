//
//  JXNetTestCtrl.h
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/18.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//
//http://code.cocoachina.com/view/135362 上传json
//https://github.com/WadonLiu/ScrollViewNest scrollView嵌套
//https://github.com/mengzhihun6/JGTableviewCellTextView parameters 提交
//https://github.com/15997082670/ZBRequests 网络请求
//http://blog.csdn.net/iot_li/article/details/78789523 网络请求
//https://www.jianshu.com/p/366f41a34218 网络请求
//https://www.jianshu.com/p/6de056d3b052 单例 证书 AF

#import <UIKit/UIKit.h>

@interface JXNetTestCtrl : UIViewController
/*
 http://www.cocoachina.com/bbs/read.php?tid-1729864-page-2.html
- (void)POST:(NSString *)apiString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
     manager.requestSerializer.timeoutInterval = 30.0f;
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
                                                                            @"application/json",
                                                                                                                                                                 @"application/xml",
                                                                                                                                                                 @"text/html",
                                                                                                                                                                 @"text/json",
                                                                                                                                                                 @"text/plain",
                                                                                                                                                                 @"text/javascript",
                                                                                                                                                                 @"text/xml",
                                                                                                                                                                @"image/*"
                                                                                                                                                                ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ]];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    // 接口传递的参数加密处理
    //? ? if ([parameters isKindOfClass:[NSDictionary class]]) {
    //? ? ? ? NSEnumerator *enumerator = [parameters keyEnumerator];
    //? ? ? ? id key = [enumerator nextObject];
    // ? ? ? ?
    //? ? ? ? while (key) {
    //? ? ? ? ? ? NSData *data = [[parameters objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //? ? ? ? ? ? NSString *encoded = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    //? ? ? ? ? ? [parametersDic setObject:encoded forKey:key];
    //? ? ? ? ? ? key = [enumerator nextObject];
    // ? ? ? ? ? ?
    //? ? ? ? }
    //? ? }
    // json 化编码
    ? ? NSData *data = [NSJSONSerialization dataWithJSONObject:parameters
                        ?? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? options:NSJSONWritingPrettyPrinted
                        ?? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? error:nil];
    ? ? NSString *strJson = [[NSString alloc] initWithData:data
                             ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? encoding:NSUTF8StringEncoding];
    ? ? [parametersDic setValue:@"" forKey:strJson];
    // Request
    ? ? [manager POST:apiString parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        ? ? } success:^(NSURLSessionDataTask * _Nonnull task, id? _Nullable responseObject) {
            ? ? ? ? // 获取回调
            ? ? ? ? NSData *data = responseObject;
            ? ? ? ? NSString *result = [[NSString alloc] initWithData:data
                                        ?? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? encoding:NSUTF8StringEncoding];
            ? ? ? ? result = [result URLDecodedString];// URL 解码
            NSData *nsData = [result dataUsingEncoding:NSUTF8StringEncoding];
            ? ? ? ? NSDictionary *dataSource = [NSJSONSerialization JSONObjectWithData:nsData
                                                ?? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? options:NSJSONReadingMutableLeaves
                                                ?? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? error:nil];
            ? ? ? ? if (success) {
                ? ? ? ? ? ? success(dataSource);
                ? ? ? ? }
            ? ? } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                ? ? ? ? if (failure) {
                    ? ? ? ? ? ? failure(error);
                    ? ? ? ? ? ? [self requestFailed:error];
                    ? ? ? ? }
                ? ? ? ? else {
                    ? ? ? ? ? ? [self requestFailed:error];
                    ? ? ? ? }
                ? ? }];
}
*/

@end
