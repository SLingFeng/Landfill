//
//  RequestPost.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SLFResponseModel;

typedef void(^callBack)();

typedef void(^callDone)(BOOL done);

typedef void(^callDoneAndText)(BOOL done, NSString *text);

typedef void(^callDoneAndTextAndObj)(BOOL done, NSString *text, id obj);

@interface RequestPost : NSObject
/**
 * @author LingFeng, 2016-09-02 11:09:47
 *
 * 所有的请求，key是URLstring、value是task
 */
@property (strong, nonatomic) NSMutableDictionary * allTaskRequset;
/**
 * @author LingFeng, 2016-09-02 11:09:07
 *
 * 判断网络
 */
@property (copy, nonatomic) void(^networkStatus)(BOOL isGo);
/**
 * @author LingFeng, 2016-09-02 11:09:58
 *
 * 单例
 * @return 单例
 */
+(RequestPost *)shareTools;
/**
 网络请求类

 @return AFHTTPSessionManager
 */
+(AFHTTPSessionManager *)mySessionMageager;

/**
 GET请求

 @param URLString 接口
 @param parameters 字段
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure;
/**
 POST请求

 @param URLString 接口
 @param parameters 字段
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id) parameters success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure;
/**
 上传带图片

 @param URLString 接口
 @param parameters 字段
 @param block 图片回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URLString parameters:(id) parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(SLFResponseModel * response))success failure:(void (^)(NSError * error))failure;

/**
 * @author LingFeng, 2016-08-26 09:08:37
 *
 * 网络变化时的回调方法
 * @param networkStatus 网络变化时 YES 有网络 NO 没网络
 */
+(void)checkNetwork:(void(^)(BOOL isGo))networkStatus;
#pragma mark - 更新app
/**
 * @author LingFeng, 2016-08-19 10:08:29
 *
 * 更新app
 * @param callBackData trackName （名称）trackViewUrl = （下载地址）version （可显示的版本号）
 */
//+(void)requestToUpdateApp:(void(^)(NSString *versionStr, NSString *releaseNotes, NSString *trackViewUrl))callBackData;

//+(void)uploadImage:(UIImage *)image block:(void(^)())callBackData;
//+(void)uploadImageS:(NSArray <UIImage *>*)imageArray block:(void(^)())callBackData;
//返回错误信息(void(^)(ResumeDetailsModel * rd, BOOL isOff))
//@property (copy, nonatomic) void(^callBackData)(ResumeDetailsModel * rd, BOOL isOff);


@end
