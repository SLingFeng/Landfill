//
//  RequestPost.m
//  RenCaiKu
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "RequestPost.h"
#import <Reachability/Reachability.h>

static RequestPost * rp = nil;
@implementation RequestPost

+(RequestPost *)shareTools {
    @synchronized(self){
        if (rp == nil) {
            //重写 alloc
            rp = [[super allocWithZone:NULL]init];
//            [[NSNotificationCenter defaultCenter] addObserver:rp selector:@selector(afNetworkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
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
    session.requestSerializer.timeoutInterval = 10;
    session.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/javascript", @"application/x-javascript", @"text/x-javascript", @"text/x-json", @"application/x-www-form-urlencoded", @"multipart/form-data", nil];
    return session;
}

+ (void)GET:(NSString *)URLString
                   parameters:(id)parameters success:(void (^)(id _Nullable response))success failure:(void (^)(BOOL isError))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    for (NSString * temp in [[RequestPost shareTools].allTaskRequset allKeys]) {
        if ([URLString isEqualToString:temp]) {
            return;
        }
    }
    NSURLSessionDataTask * nowTask = [[RequestPost mySessionMageager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * data = responseObject;
        if (data != nil) {
            if (success) {
                success();
            }
        }else {
            
            [task cancel];
        }
        for (NSURLSessionDataTask * tempTask in [[RequestPost shareTools].allTaskRequset allValues]) {
            if (tempTask == task) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MyMBProgressHUD hudForText:@"請檢測您的網絡"  delay:0.5];
        NSLog(@"error---->\n:%@", error);
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        if (failure) {
            failure(YES);
        }
        [task cancel];
        for (NSURLSessionDataTask * tempTask in [[RequestPost shareTools].allTaskRequset allValues]) {
            if (tempTask == task) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    }];
    [[RequestPost shareTools].allTaskRequset setObject:nowTask forKey:URLString];
}

+ (void)POST:(NSString *)URLString
                    parameters:(id) parameters success:(void (^)(id _Nullable response))success failure:(void (^)(BOOL isError))failure {
    NSLog(@"URLString->%@\n<--------------------------------------->\nparameters->%@\n", URLString, parameters);
    for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
        if ((NSDictionary *)parameters == temp) {
            return;
        }
    }
    [[RequestPost mySessionMageager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * data = responseObject;
        if (data != nil) {
            if (success) {
                success(responseObject);
            }
        }else {
//            [MyMBProgressHUD hudForText:data[@"resultObject"] [@"mess"] delay:1];
            [task cancel];
        }
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-->:\n%@", error);
        NSLog(@"Error: %@", [error debugDescription]);
        NSLog(@"Error: %@", [error localizedDescription]);
        if (failure) {
            failure(YES);
        }
        [task cancel];
        for (NSDictionary * temp in [[RequestPost shareTools].allTaskRequset allValues]) {
            if ((NSDictionary *)parameters == temp) {
                [[RequestPost shareTools].allTaskRequset removeObjectForKey:URLString];
            }
        }
    }];
    if (parameters != nil) {
        [[RequestPost shareTools].allTaskRequset setObject:(NSDictionary *)parameters forKey:URLString];
    }
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
    __block kWEAKOBJ(weakAppUrl, appUrl);
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
                //            [MyMBProgressHUD hudForText:@"請檢測您的網絡"  delay:1];
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
}

#pragma mark - 登录

#pragma mark - 注册


#pragma mark - 获取验证码

#pragma mark - 判断验证码


#pragma mark - 密码修改


#pragma mark - 17密码重置


#pragma mark - 19 获取banner
//+(void)requestForBanner:(void(^)(BannerModel * bm, BOOL isGo))callBack {
//    [RequestPost GET:kURL_Banner parameters:nil success:^(id  _Nullable response) {
//        NSDictionary * data = response;
//        NSError * error;
//        BannerModel * bm = [[BannerModel alloc] initWithDictionary:data[@"resultObject"] [@"data"] error:&error];
//        if (callBack) {
//            callBack(bm, YES);
//        }
//    } failure:^(BOOL isError) {
//        if (callBack) {
//            callBack(nil, NO);
//        }
//    }];
//}
#pragma mark - 20 获取获取版本更新


#pragma mark - 热门企业

#pragma mark - 搜索公司
//+(void)requestForSearchCompany:(NSString *)name pageNum:(NSString *)pageNum callBack:(void(^)(HomeJobDatailedModel * homejdm, BOOL isOff))callBackData {
//    
//    NSMutableDictionary * nowdata = [NSMutableDictionary dictionaryWithCapacity:0];
//    if (nil != name) {
//        [nowdata setObject:name forKey:@"mCompanyName"];
//    }
//    if (nil != pageNum) {
//        [nowdata setObject:pageNum forKey:@"pageNumber"];
//    }
//    [nowdata setObject:@"10" forKey:@"pageSize"];
//    [nowdata setObject:@"0" forKey:@"mIId"];
//    [nowdata setObject:@"0" forKey:@"mJIsShow"];
//    [RequestPost POST:kURL_FINDMEMBER_JOBBYPAGE_POST parameters:nowdata success:^(id  _Nullable response) {
//        NSDictionary * data = response;
//        NSError * error;
//        HomeJobDatailedModel * homejdm = [[HomeJobDatailedModel alloc] initWithDictionary:data[@"resultObject"][@"data"] error:&error];
//        if (callBackData) {
//            callBackData(homejdm,NO);
//        }
//    } failure:^(BOOL isError) {
//        if (callBackData) {
//            callBackData(nil,YES);
//        }
//    }];
//}



@end
