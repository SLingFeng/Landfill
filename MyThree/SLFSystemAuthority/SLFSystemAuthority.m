//
//  SLFSystemAuthority.m
//  YGB
//
//  Created by 孙凌锋 on 2017/5/25.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import "SLFSystemAuthority.h"

@implementation SLFSystemAuthority


+ (void)getPush {
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

+ (void)chekckPush {
    UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    switch (notificationSettings.types) {
        case UIUserNotificationTypeNone:
            NSLog(@"没有推送权限");
            break;
        case UIUserNotificationTypeBadge:
            NSLog(@"带角标的推送");
            break;
        case UIUserNotificationTypeSound:
            NSLog(@"带声音的推送");
            break;
        case UIUserNotificationTypeAlert:
            NSLog(@"带通知的推送");
            break;
        default:
            break;
    }
}

+ (void)getCamera {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted){
            NSLog(@"用户同意授权相机");
        }else {
            NSLog(@"用户拒绝授权相机");
        }
    }];
}

+ (void)getPhotoLibrary {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"用户同意授权相册");
        }else {
            NSLog(@"用户拒绝授权相册");
        }
    }];
}

+ (void)getLocation {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
//    [manager requestAlwaysAuthorization];//一直获取定位信息
    [manager requestWhenInUseAuthorization];//使用时获取定位信息
}

+ (void)openSetting {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
