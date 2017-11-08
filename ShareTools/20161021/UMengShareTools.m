//
//  ShareTools.m
//  MyShare
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 LingFeng. All rights reserved.
//



#import "UMengShareTools.h"

///在友盟官网生成的AppKey传入
NSString *const AppKey = @"580890241c5dd00c4300074b";

///在QQ开放平台申请的ID
NSString *const QQAppID = @"1105587808";

///在QQ开放平台申请的Key
NSString *const QQAppKey = @"hF4US56afOVEQ8cM";

///在微信开放平台申请的ID
NSString *const WXAppID = @"wxa8e64a7d639fa08a";

///在微信开放平台申请的应用密钥
NSString *const WXAppSecretKey = @"44f1af6c03de0eafd578c4202cf248f3";

///在微博开放平台申请的Key
NSString *const WeiboAppKey = @"1289934305";

///在微博开放平台申请的应用密钥
NSString *const WeiboAppSecretKey = @"b0310db6aef022d8d56e09abde4e7a6d";

///在微博开放平台申请的回调地址
NSString *const WeiboAppRedirectURL = @"http://sns.whalecloud.com/sina2/callback";


@implementation UMengShareTools

+(void)registerShare {
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:AppKey];
    
    //各平台的详细配置
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecretKey redirectURL:nil];
    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID  appSecret:QQAppKey redirectURL:nil];
    //设置新浪的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WeiboAppKey  appSecret:WeiboAppSecretKey redirectURL:WeiboAppRedirectURL];
}

+(void)showShareActionSheetToController:(UIViewController *)controller view:(UIView *)view shareImageArray:(UIImage *)image title:(NSString *)title contentText:(NSString *)text url:(NSURL *)url type:(int)type {
    __weak __typeof(&*view) weakView = view;
//    __weak __typeof(&*controller) weakSelf = controller;
    
//    设置分享参数
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        
        UMSocialMessageObject *messageObject = [UMengShareTools creatMessageObjectTitle:title contentText:text url:nil image:image type:type];
        //调用分享接口
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {

            
            if (!error) {
                [MyMBProgressHUD hudForText:@"分享成功"];
            }
            else{
                if (error) {
                    if ((int)error.code == 2010) {
//                        message = @"分享取消";
                        [MyMBProgressHUD hudForText:@"分享取消" ];
                    }else {
                        NSString * message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                                        message:message
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                }
                else{
//                    message = [NSString stringWithFormat:@"分享失败"];
                    [MyMBProgressHUD hudForText:@"分享失败"];
                }
                
            }
            
        }];

    }];
}

//创建分享内容对象
+ (UMSocialMessageObject *)creatMessageObjectTitle:(NSString *)title contentText:(NSString *)text url:(NSString *)urlStr image:(UIImage *)image type:(int)type
{
    if (nil == title) {
        title = @"拓才网";
    }
    if (nil == text) {
        text = @"找工作就到拓才网";
    }
    if (nil == urlStr) {
        urlStr = @"http://hrk.com.cn";//@"http://wsq.umeng.com";
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    image = [UIImage imageNamed:@"iocn-logo"];
    if (title) {
        //纯文本分享
        messageObject.text = text;
    }
    switch (type) {
        case 0:
            if (urlStr) {//创建网页分享内容对象
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"applogo"]];
                [shareObject setWebpageUrl:urlStr];
                messageObject.shareObject = shareObject;
            }
            break;
        case 1:
        {
            //创建图片对象
            UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:@"http://zlqxm.com/img/sinna.png"];
//            [shareObject setShareImage:image];
            [shareObject setShareImage:[UIImage imageNamed:@"applogo"]];
            messageObject.shareObject = shareObject;
            
            //                //@discuss linkedin平台需要传入的图片是url，如果图片不是https的，linkedin的sdk会崩溃，需要在info.plist中加入
            //                    <key>NSAppTransportSecurity</key>
            //                    <dict>
            //                    <key>NSAllowsArbitraryLoads</key>
            //                    <true/>
            //                    </dict>
            
            //                NSString* img_url = @"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            
            //                NSString* img_url = @"http://dev.umeng.com/images/tab2_1.png";//@"http://bbs.umeng.com/data/attachment/forum/201609/14/113141r2jqq0pjlooj0753.jpg";
            //                //NSString* img_url = @"https://content.linkedin.com/content/dam/developer/global/en_US/site/img/ipad_getstarted.png";
            //                UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:img_url];
            //                [shareObject setShareImage:img_url];
            //                messageObject.shareObject = shareObject;
            
        }
            break;
        case 2:
        {
            UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
//            [shareObject setVideoUrl:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        case 3:
        {
            UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:text thumImage:[UIImage imageNamed:@"icon"]];
//            [shareObject setMusicUrl:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3"];
            messageObject.shareObject = shareObject;
        }
            
            break;
        default:
            break;
    }
    return messageObject;
}

+(void)loginToWeiBo:(void(^)(NSString *uid))callBackData {
    [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
    }];
}

+(void)userInfoForWeiBo:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)loginToQQ:(void(^)(NSString *openid))callBackData {
    [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_QQ currentViewController:[UIApplication sharedApplication].keyWindow completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        NSLog(@"%@---%@", authresponse.originalUserProfile, error);
//        NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, authresponse.thirdPlatformUserProfile, authresponse.thirdPlatformResponse, authresponse.message);
        
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
    }];
}

+(void)userInfoForQQ:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:[UIApplication sharedApplication].keyWindow completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)loginToWeiXinFriend:(void(^)(NSString *openid))callBackData {
    [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse = result;
        if (authresponse.uid) {
            if (callBackData) {
                callBackData(authresponse.uid);
            }
        }
        NSLog(@"%@---%@", authresponse, error);
    }];
}

+(void)userInfoForWeiXinFriend:(void(^)(UMSocialUserInfoResponse *userInfo))callBackData {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        if (callBackData) {
            callBackData(userinfo);
        }
    }];
}

+(void)cancelAllPlatform {
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:^(id result, NSError *error) {
        NSLog(@"%@-><-%@", result, error);
    }];
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_Sina completion:^(id result, NSError *error) {
        NSLog(@"%@-><-%@", result, error);
    }];
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
        NSLog(@"%@-><-%@", result, error);
    }];
}

@end
