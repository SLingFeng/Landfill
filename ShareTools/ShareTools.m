//
//  ShareTools.m
//  MyShare
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 LingFeng. All rights reserved.
//



#import "ShareTools.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
//默认的分享视图
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>

///在ShareSDK官网生成的AppKey传入
NSString *const AppKey = @"14efec786cfe8";

///在QQ开放平台申请的ID
NSString *const QQAppID = @"1105469013";

///在QQ开放平台申请的Key
NSString *const QQAppKey = @"xriF1MKvqFwhU1qY";

///在微信开放平台申请的ID
NSString *const WXAppID = @"wx3384dcd482639685";

///在微信开放平台申请的应用密钥
NSString *const WXAppSecretKey = @"e21b7df01d1347ed0623153825c1c616";

///在微博开放平台申请的Key
NSString *const WeiboAppKey = @"1348075922";

///在微博开放平台申请的应用密钥
NSString *const WeiboAppSecretKey = @"9c0d94a1971e4fb8bd2925502179a6a2";

///在微博开放平台申请的回调地址
NSString *const WeiboAppRedirectURL = @"http://www.zlqxm.com";
/**
 * @author LingFeng, 2016-07-14 09:07:40
 *
 * 腾讯QQSDK头文件
 */
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
/**
 * @author LingFeng, 2016-07-14 09:07:42
 *
 * 微信SDK头文件
 */
#import "WXApi.h"
/**
 * @author LingFeng, 2016-07-14 09:07:29
 *
 * 新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
 */
#import "WeiboSDK.h"

@implementation ShareTools

+(void)registerShare {
    
    [ShareSDK registerApp:AppKey activePlatforms:@[@(SSDKPlatformSubTypeQQFriend),
                                                   @(SSDKPlatformTypeSinaWeibo),
                                                   @(SSDKPlatformSubTypeWechatTimeline)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppID appKey:QQAppKey authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WXAppID appSecret:WXAppSecretKey];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:WeiboAppKey appSecret:WeiboAppSecretKey redirectUri:WeiboAppRedirectURL authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];

}

+(void)showShareActionSheetToController:(UIViewController *)controller view:(UIView *)view shareImageArray:(NSArray <UIImage *> *)image title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url {
    __weak __typeof(&*view) weakView = view;
    __weak __typeof(&*controller) weakVC = controller;
    NSMutableDictionary * shareparams = [NSMutableDictionary dictionary];
    
    if (nil == title) {
        title = @"分享";
    }
    if (nil == text) {
        text = @"分享内容";
    }
    if (nil == url) {
        url = [NSURL URLWithString:@"http://www.zlqxm.com"];
    }
//    设置分享参数
    [shareparams SSDKSetupShareParamsByText:text images:image url:url title:title type:SSDKContentTypeAuto];
//    弹出分享Sheet
    [ShareSDK showShareActionSheet:weakView items:@[@(SSDKPlatformSubTypeQQFriend),
                                                    @(SSDKPlatformTypeSinaWeibo),
                                                    @(SSDKPlatformSubTypeWechatTimeline)] shareParams:shareparams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
//                开始分享
            case SSDKResponseStateBegin:
            {
                
            }
                break;
            
//                分享成功
            case SSDKResponseStateSuccess:
            {
                //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                if (platformType == SSDKPlatformTypeFacebookMessenger)
                {
                    break;
                }
                
                [CommonTools showAlertViewTo:weakVC title:@"分享成功" text:nil cancel:0];
            }
                break;
            
//                分享失败
            case SSDKResponseStateFail:
            {
                if (platformType == SSDKPlatformTypeSMS && [error code] == 201) {

                    [CommonTools showAlertViewTo:weakVC title:@"分享失败" text:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。" cancel:0];
                    break;
                } else if(platformType == SSDKPlatformTypeMail && [error code] == 201) {

                    [CommonTools showAlertViewTo:weakVC title:@"分享失败" text:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；" cancel:0];
                    break;
                } else {
                    [CommonTools showAlertViewTo:weakVC title:@"分享失败" text:[NSString stringWithFormat:@"%@",error] cancel:0];
                    break;
                }
            }
                break;
            
            default:
                [MyMBProgressHUD hudForText:@"分享取消" view:view];
                break;
        }
    }];
    
}

+(void)loginToWeiBo:(void(^)(NSString *uid, NSString *name))callBackData {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            if (callBackData) {
                callBackData(user.credential.uid, user.nickname);
            }
        }else {
            NSLog(@"%@", error);
        }
    }];
}

+(void)loginToQQ:(void(^)(NSString *openid, NSString *name))callBackData {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            if (callBackData) {
                callBackData(user.credential.uid, user.nickname);
            }
        }else {
            NSLog(@"%@", error);
        }
    }];
}

+(void)loginToWeiXinFriend:(void(^)(NSString *openid, NSString *name))callBackData {
    [ShareSDK getUserInfo:SSDKPlatformSubTypeWechatTimeline onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            if (callBackData) {
                callBackData(user.credential.uid, user.nickname);
            }
        }else {
            NSLog(@"%@", error);
        }
    }];
}

+(void)cancelAllPlatform {
    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeWechatSession];
    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeQQFriend];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeWechatTimeline];
    
}

@end
