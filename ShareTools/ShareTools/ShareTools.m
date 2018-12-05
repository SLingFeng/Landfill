//
//  ShareTools.m
//  MyShare
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 LingFeng. All rights reserved.
//



#import "ShareTools.h"
#import "ShareMainView.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
//默认的分享视图
#import <ShareSDKUI/ShareSDKUI.h>
//#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>

///在ShareSDK官网生成的AppKey传入
NSString *const AppKey = @"29120e7d114fa";
//Appkey:  29120e7d114fa
//App Secret:  d6882dc58092fe415b03fb1ee508d291
///在QQ开放平台申请的ID
NSString *const QQAppID = @"1107935685";

///在QQ开放平台申请的Key
NSString *const QQAppKey = @"t5pxlAfgDRvz4JxR";

///在微信开放平台申请的ID
NSString *const WXAppID = @"wx8c7221864ed696ee";

///在微信开放平台申请的应用密钥
NSString *const WXAppSecretKey = @"a2d8cb1d44ea669881a70c6f6c97b68d";
//AppID: wx8c7221864ed696ee
//AppSecret: a2d8cb1d44ea669881a70c6f6c97b68d 复制
//我已经了解AppSecret不再明文储存在开放平台上，并且已经复制保存好该AppSecret
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
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
/**
 * @author LingFeng, 2016-07-14 09:07:42
 *
 * 微信SDK头文件
 */
//#import "WXApi.h"
/**
 * @author LingFeng, 2016-07-14 09:07:29
 *
 * 新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
 */
//#import "WeiboSDK.h"

@implementation ShareTools

+(void)registerShare {
    
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        [platformsRegister setupQQWithAppId:QQAppID appkey:QQAppKey];
        
        [platformsRegister setupWeChatWithAppId:WXAppID appSecret:WXAppSecretKey];
        
//        [platformsRegister setupSinaWeiboWithAppkey:WeiboAppKey appSecret:WeiboAppSecretKey redirectUrl:WeiboAppRedirectURL];
    }];
    
//    [ShareSDK registerApp:AppKey activePlatforms:@[@(SSDKPlatformSubTypeQQFriend),
//                                                   @(SSDKPlatformTypeSinaWeibo),
//                                                   @(SSDKPlatformSubTypeWechatTimeline)]
//                 onImport:^(SSDKPlatformType platformType) {
//                     switch (platformType) {
//                         case SSDKPlatformTypeQQ:
//                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                             break;
//                         case SSDKPlatformTypeWechat:
//                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                             break;
//                         case SSDKPlatformTypeSinaWeibo:
//                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                             break;
//                         default:
//                             break;
//                     }
//    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//        switch (platformType) {
//            case SSDKPlatformTypeQQ:
//                [appInfo SSDKSetupQQByAppId:QQAppID appKey:QQAppKey authType:SSDKAuthTypeBoth];
//                break;
//            case SSDKPlatformTypeWechat:
//                [appInfo SSDKSetupWeChatByAppId:WXAppID appSecret:WXAppSecretKey];
//                break;
//            case SSDKPlatformTypeSinaWeibo:
//                [appInfo SSDKSetupSinaWeiboByAppKey:WeiboAppKey appSecret:WeiboAppSecretKey redirectUri:WeiboAppRedirectURL authType:SSDKAuthTypeBoth];
//                break;
//            default:
//                break;
//        }
//    }];

}

+(void)showShareActionSheetToController:(UIViewController *)controller view:(UIView *)view shareImageArray:(NSArray <UIImage *> *)image title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url {
//    __weak __typeof(&*view) weakView = view;
//    __weak __typeof(&*controller) weakVC = controller;
    
    
  
    
//    NSMutableDictionary * shareparams = [NSMutableDictionary dictionary];
    
    if (nil == title) {
        title = @"赶墟网";
    }
    if (nil == text) {
        text = @"赶墟网是一款为广大用户提供同城二手相关信息的APP客户端。其中包含二手房、二手车、闲置物品、爱心公益等。全方位为广大用户提供二手信息。欢迎广大商家加盟平台！";
    }
    if (nil == url) {
        url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1367304433"];
    }
//    设置分享参数
//    [shareparams SSDKSetupShareParamsByText:text images:image url:url title:title type:SSDKContentTypeAuto];
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareLogo"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:title
                                         images:imageArray
                                            url:url
                                          title:text
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        
        //大家请注意：4.1.2版本开始因为UI重构了下，所以这个弹出分享菜单的接口有点改变，如果集成的是4.1.2以及以后版本，如下调用：
        [ShareSDK showShareActionSheet:nil customItems:@[@(SSDKPlatformSubTypeWechatSession),
                                                         @(SSDKPlatformSubTypeWechatTimeline),
                                                         @(SSDKPlatformSubTypeQQFriend),
                                                         @(SSDKPlatformSubTypeQZone)] shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    [SLFHUD showHint:@"分享成功"];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
    }
//    弹出分享Sheet
//    [ShareSDK showShareActionSheet:weakView items:@[@(SSDKPlatformSubTypeQQFriend),
//                                                    @(SSDKPlatformTypeSinaWeibo),
//                                                    @(SSDKPlatformSubTypeWechatTimeline)] shareParams:shareparams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//        switch (state) {
////                开始分享
//            case SSDKResponseStateBegin:
//            {
//
//            }
//                break;
//
////                分享成功
//            case SSDKResponseStateSuccess:
//            {
//                //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
//                if (platformType == SSDKPlatformTypeFacebookMessenger)
//                {
//                    break;
//                }
//
//                [SLFCommonTools showAlertViewTo:weakVC title:@"分享成功" text:nil cancel:0];
//            }
//                break;
//
////                分享失败
//            case SSDKResponseStateFail:
//            {
//                if (platformType == SSDKPlatformTypeSMS && [error code] == 201) {
//
//                    [SLFCommonTools showAlertViewTo:weakVC title:@"分享失败" text:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。" cancel:0];
//                    break;
//                } else if(platformType == SSDKPlatformTypeMail && [error code] == 201) {
//
//                    [SLFCommonTools showAlertViewTo:weakVC title:@"分享失败" text:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；" cancel:0];
//                    break;
//                } else {
//                    [SLFCommonTools showAlertViewTo:weakVC title:@"分享失败" text:[NSString stringWithFormat:@"%@",error] cancel:0];
//                    break;
//                }
//            }
//                break;
//
//            default:
////                [MyMBProgressHUD hudForText:@"分享取消" view:view];
//                break;
//        }
//    }];
    
}

+(void)showShareViewToController:(UIViewController *)controller title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url image:(UIImage *)image {
    if (nil == title) {
        title = @"赶墟网";
    }
    if (nil == text) {
        text = @"赶墟网是一款为广大用户提供同城二手相关信息的APP客户端。其中包含二手房、二手车、闲置物品、爱心公益等。全方位为广大用户提供二手信息。欢迎广大商家加盟平台！";
    }
    if (nil == url) {
        url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1367304433"];
    }
    
    ShareMainView * smv = [[ShareMainView alloc] init];
    //    [controller.view addSubview:smv];
    [[UIApplication sharedApplication].keyWindow addSubview:smv];
    [smv show];
    smv.formType = ^(SSDKPlatformType type) {
        NSLog(@"%ld", type);
        if (type == SSDKPlatformTypeUnknown) {
            [UIPasteboard generalPasteboard].string = @"https://itunes.apple.com/cn/app/id1367304433";
            [SLFHUD showHint:@"复制链接成功"];
        }else {
            
            //创建分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:text
                                             images:[UIImage imageNamed:@"shareLogo"] //传入要分享的图片
                                                url:url
                                              title:title
                                               type:SSDKContentTypeAuto];
            
            //进行分享
            [ShareSDK share:type //传入分享的平台类型
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
                 
                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         [SLFHUD showHint:@"分享成功"];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                         [alert show];
                         break;
                     }
                     default:
                         break;
                 }
             }];
        }
        
//        UMSocialMessageObject *messageObject = [UMengShareTools creatMessageObjectTitle:title contentText:text url:nil image:nil type:0];
//        //调用分享接口
//
//        [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//            //            NSString *message = nil;
//            if (!error) {
//                //                message = [NSString stringWithFormat:@"分享成功"];
//                [MyMBProgressHUD hudForText:@"分享成功"];
//            }
//            else{
//                //                if (error) {
//                if ((int)error.code == 2010) {
//                    [MyMBProgressHUD hudForText:@"分享取消"];
//                }else if ((int)error.code == 2009) {
//                    [MyMBProgressHUD hudForText:@"分享取消"];
//                }else {
//                    [MyMBProgressHUD hudForText:[NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code] delay:5];
//
//                    //                        message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
//                }
//                //                }
//                //                else{
//                //                    message = [NSString stringWithFormat:@"分享失败"];
//                //                }
//            }
//            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
//            //                                                            message:message
//            //                                                           delegate:nil
//            //                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//            //                                                  otherButtonTitles:nil];
//            //            [alert show];
//
//        }];
//
    };
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
//    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeWechatSession];
//    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeQQFriend];
//    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
//    [ShareSDK cancelAuthorize:SSDKPlatformSubTypeWechatTimeline];
    
}

@end
