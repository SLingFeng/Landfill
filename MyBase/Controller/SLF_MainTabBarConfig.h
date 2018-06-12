//
//  SLF_MainTabBarConfig.h
//
//  Created by 孙凌锋 on 2018/5/5.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YL_MainTabBarViewController.h"

@interface SLF_MainTabBarConfig : NSObject

@property (nonatomic, readonly, strong) YL_MainTabBarViewController *tabBarController;

+ (YL_MainTabBarViewController *)getMainTabBarViewController;

@end
