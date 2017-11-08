//
//  RequestPost.h
//  RenCaiKu
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^callBack)();

typedef void(^callDone)(BOOL done);

typedef void(^callDoneAndText)(BOOL done, NSString *text);

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
+(void)requestToUpdateApp:(void(^)(NSString *versionStr, NSString *releaseNotes, NSString *trackViewUrl))callBackData;

+(void)uploadImage:(UIImage *)image block:(void(^)())callBackData;
+(void)uploadImageS:(NSArray <UIImage *>*)imageArray block:(void(^)())callBackData;
//返回错误信息(void(^)(ResumeDetailsModel * rd, BOOL isOff))
//@property (copy, nonatomic) void(^callBackData)(ResumeDetailsModel * rd, BOOL isOff);

@end
