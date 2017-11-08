//
//  SLFSystemAuthority.h
//  YGB
//
//  Created by 孙凌锋 on 2017/5/25.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import <Foundation/Foundation.h>

//相册   iOS8以后版本可用PhotoKit
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
//相机和麦克风
#import <AVFoundation/AVFoundation.h>
//定位
#import <CoreLocation/CoreLocation.h>



@interface SLFSystemAuthority : NSObject

/**
 摄像头
 */
+ (void)getCamera;
/**
 相册
 */
+ (void)getPhotoLibrary;
/**
 定位
 */
+ (void)getLocation;
/**
 打开设置
 */
+ (void)openSetting;

@end
