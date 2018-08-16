//
//  RequestPost.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "RequestPost.h"
#import <Reachability/Reachability.h>

#define Key @"qplskdjcvj"

static RequestPost * rp = nil;
@implementation RequestPost

+(RequestPost *)shareTools {
    @synchronized(self){
        if (rp == nil) {
            //重写 alloc
            rp = [[super allocWithZone:NULL]init];
            rp.allTaskRequset = [[NSMutableDictionary alloc] initWithCapacity:10];
        }
        return rp;
    }
}
//重写 alloc
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self shareTools];
}
//重写 copy
+(id)copyWithZone:(struct _NSZone *)zone{
    return self;
}

+(AFHTTPSessionManager *)mySessionMageager {
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
#ifdef DEBUG
    session.requestSerializer.timeoutInterval = 15;
    //#else
    //    session.requestSerializer.timeoutInterval = 60;
#endif
    session.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/javascript", @"application/x-javascript", @"text/x-javascript", @"text/x-json", @"application/x-www-form-urlencoded", @"multipart/form-data", @"image/jpeg", @"image/png", nil];
//    [RequestPost setHttpHeader:session];
    
    [session setSecurityPolicy:[RequestPost customSecurityPolicy]];
    return session;
}

#pragma mark - 设置HTTPHeader
+(void)setHttpHeader:(AFHTTPSessionManager *)session {
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    NSString * device = @"device_1.0.0";
//    NSString * md = [NSString stringWithFormat:@"%@%@%@",timeSp, Key, device];
//    NSString *codeAll = [NSString MD5:md isUp:0];
//    NSString *code = [codeAll substringToIndex:28];
//    [session.requestSerializer setValue:timeSp forHTTPHeaderField:@"check-time"];
//    [session.requestSerializer setValue:code forHTTPHeaderField:@"check-md5"];
//    if ([GVUserDefaults standardUserDefaults].ygbUserToken != nil && ![[GVUserDefaults standardUserDefaults].ygbUserToken isEqualToString:@""]) {
//        [session.requestSerializer setValue:[GVUserDefaults standardUserDefaults].ygbUserToken forHTTPHeaderField:@"check-token"];
//    }
}
#pragma mark - 证书
+(AFSecurityPolicy *)customSecurityPolicy {     //简单封装一下
    //2 设置证书模式
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"mnchip" ofType:@"cer"];
    NSData *cerDat = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //允许自检证书
    securityPolicy.allowInvalidCertificates = YES;
    //域名与服务器一致
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerDat, nil];
    return securityPolicy;
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    //AFNetworking中的处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        NSLog(@"是服务器信任的证书");
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        NSLog(@"不是服务器信任的证书");
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
+ (SLFResponseModel *)successBlock:(NSDictionary *)responseObject task:(NSURLSessionDataTask *)task {
    
    
    [SLFHUD hideHud];
    NSDictionary * data = responseObject;
    NSError *error;
    SLFResponseModel *response = [[SLFResponseModel alloc] initWithDictionary:data error:&error];
    
    if ([RequestPost check:data]) {
        //请求成功
        if ([response.code isEqualToString:@"101"]) {
            response.success = YES;
        }else {
            response.data = @{};
            response.success = NO;
        }
        
        if (error == nil) {
            return response;
        }else {
            [task cancel];
        }
    }
    return nil;
}

+ (BOOL)check:(NSDictionary *)request {
    if ([request[@"code"] integerValue] == 969) {
        [SLFAlert showSystemAlertWithTitle:request[@"msg"] text:@"请重新登录" determineTitle:@"去登录" alertClick:^(BOOL rightClick) {
            [SLFCommonTools exit];
            [[GVUserDefaults standardUserDefaults] removeUserInfo];
        }];
        return 0;
    }else {
        return 1;
    }
}

+ (NSError *)failureBlock:(NSError *)error task:(NSURLSessionDataTask *)task {
    [SLFHUD hideHud];
    [task cancel];
    NSLog(@"error---->\n:%@", error);
    //    NSLog(@"errorCode---->:\n%ld", (long)error.code);
    //    NSLog(@"Error: %@", [error debugDescription]);
    //    NSLog(@"Error: %@", [error localizedDescription]);
    return error;
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    
    [SLFHUD showLoading];
    [[RequestPost mySessionMageager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([RequestPost successBlock:responseObject task:task]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([RequestPost failureBlock:error task:task]);
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(id) parameters success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    
    [SLFHUD showLoading];
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([RequestPost successBlock:responseObject task:task]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([RequestPost failureBlock:error task:task]);
    }];
    
}
//没有转圈圈
+ (void)noPOST:(NSString *)URLString parameters:(id) parameters success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success([RequestPost successBlock:responseObject task:task]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([RequestPost failureBlock:error task:task]);
    }];
    
}
//进度
+ (void)noPOST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))up success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        up(uploadProgress);
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success([RequestPost successBlock:responseObject task:task]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([RequestPost failureBlock:error task:task]);
    }];
}
//上传进度
+ (void)POST:(NSString *)URLString
  parameters:(id) parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    
    
    [SLFHUD showLoading];
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([RequestPost successBlock:responseObject task:task]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([RequestPost failureBlock:error task:task]);
    }];
    
}
#pragma mark - 网络连接
+(void)checkNetwork:(void(^)(BOOL isGo))networkStatus {
    
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    reach.reachableBlock = ^(Reachability * reach) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
            if (networkStatus) {
                networkStatus(YES);
            }
        });
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        if (networkStatus) {
            networkStatus(NO);
        }
        NSLog(@"UNREACHABLE!");
    };
    [reach startNotifier];
    
}

#pragma mark - 更新app
#define APP_URL @"http://itunes.apple.com/cn/lookup?id=1152760635"
+(void)requestToUpdateApp:(void(^)(NSString *versionStr, NSString *releaseNotes, NSString *trackViewUrl))callBackData {
    NSString * appUrl = APP_URL;
    kWeakObj(weakAppUrl, appUrl);
    //    [RequestPost requestToUpdateAppLink:^(NSString *linkAppUpdate) {
    
    //        if (linkAppUpdate != nil) {
    //            if ([linkAppUpdate isEqualToString:@""]) {
    //
    //            }else {
    //                weakAppUrl = linkAppUpdate;
    //            }
    [[RequestPost mySessionMageager] GET:weakAppUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"%@",responseObject);
        /*responseObject是个字典{}，有两个key
         
         KEYresultCount = 1//表示搜到一个符合你要求的APP
         results =（）//这是个只有一个元素的数组，里面都是app信息，那一个元素就是一个字典。里面有各种key。其中有 trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）等等
         */
        //具体实现为
        NSArray *arr = [responseObject objectForKey:@"results"];
        NSDictionary *dic = [arr firstObject];
        NSString *versionStr = [dic objectForKey:@"version"];
        NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
        
        //NSString* buile = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*) kCFBundleVersionKey];build号
        NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        if ([RequestPost compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]) {
            
            if (callBackData) {
                callBackData(versionStr, releaseNotes, trackViewUrl);
            }
        }else {
            if (callBackData) {
                callBackData(nil, nil, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---->\n:%@", error);
        [task cancel];
        if (callBackData) {
            callBackData(nil, nil, nil);
        }
    }];
    //        }
    
    //    }];
    
}
//比较版本的方法，在这里我用的是Version来比较的
+ (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    if (AppStoreVersion == nil) {
        return littleSunResult;
    }
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}
/*
 #pragma mark - 上传图片
 
 +(void)POST:(NSString *)URLString
 parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  _Nonnull formData))constructingBody success:(void (^)(id _Nullable response))success failure:(void (^)(BOOL isError))failure {
 [[RequestPost mySessionMageager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
 if (constructingBody) {
 constructingBody(formData);
 }
 } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 //        NSDictionary *dic = responseObject;
 //        if (dic[@"success"]) {
 //
 if (success) {
 success(responseObject);
 }
 //        }else{
 //            //            取消这次的请求
 //            [task cancel];
 //        }
 
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 if (failure) {
 failure(YES);
 }
 NSLog(@"error-->:\n%@", error);
 }];
 
 
 }
 //单张
 +(void)uploadImage:(UIImage *)image block:(void(^)())callBackData {
 [RequestPost POST:@""  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
 NSData *imgData = UIImageJPEGRepresentation(image, 1);
 //        上传的参数名
 NSString *name = @"myUpload";
 //上传的filename
 //2. 利用时间戳当做图片名字
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 formatter.dateFormat = @"yyyyMMddHHmmss";
 NSString *imageName = [formatter stringFromDate:[NSDate date]];
 NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
 [formData appendPartWithFileData:imgData
 name:name
 fileName:fileName
 mimeType:@"image/jpeg"];
 } success:^(id  _Nullable response) {
 //        [AccessImageModel setUp];
 //        AccessImageModel *accessImage = [AccessImageModel mj_objectWithKeyValues:response];
 //        if (callBackData) {
 //            callBackData(accessImage);
 //        }
 } failure:^(BOOL isError) {
 
 }];
 }
 
 +(void)uploadImageS:(NSArray <UIImage *>*)imageArray block:(void(^)())callBackData {
 [RequestPost POST:@""  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
 for (int i = 0; i<imageArray.count; i++) {
 UIImage *uploadImage = imageArray[i];
 [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadImage, 1) name:[NSString stringWithFormat:@"参数%d",i+1] fileName:@"test.jpg" mimeType:@"image/jpg"];
 }
 
 } success:^(id  _Nullable response) {
 //        [AccessImageModel setUp];
 //        AccessImageModel *accessImage = [AccessImageModel mj_objectWithKeyValues:response];
 //        if (callBackData) {
 //            callBackData(accessImage);
 //        }
 } failure:^(BOOL isError) {
 
 }];
 }*/



@end
