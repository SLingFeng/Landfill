//
//  SLF_MainTabBarConfig.m
//
//  Created by 孙凌锋 on 2018/5/5.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "SLF_MainTabBarConfig.h"
#import "MyBaseNavigtionViewController.h"


@interface YL_MainTabBarConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) YL_MainTabBarViewController *tabBarController;

@end

@implementation YL_MainTabBarConfig



+ (YL_MainTabBarViewController *)getMainTabBarViewController {
    FY_HomeViewController * home = [[FY_HomeViewController alloc] init];
    MyBaseNavigtionViewController * homeNav = [[MyBaseNavigtionViewController alloc] initWithRootViewController:home];
    
    FY_HousSourceViewController * per = [[FY_HousSourceViewController alloc] init];
    MyBaseNavigtionViewController * perNav = [[MyBaseNavigtionViewController alloc] initWithRootViewController:per];
    
    FY_FollowUpViewController * cel = [[FY_FollowUpViewController alloc] init];
    MyBaseNavigtionViewController * celNav = [[MyBaseNavigtionViewController alloc] initWithRootViewController:cel];
    
    FY_EnterViewController * mine = [[FY_EnterViewController alloc] init];
    MyBaseNavigtionViewController * mineNav = [[MyBaseNavigtionViewController alloc] initWithRootViewController:mine];
    
    
    NSDictionary * homeDic = @{CYLTabBarItemTitle : @"首页",
                               CYLTabBarItemImage : @"home_unclicked_icon",
                               CYLTabBarItemSelectedImage : @"home_icon",
                               };
    
    NSDictionary * pvcDic = @{CYLTabBarItemTitle : @"",
                              CYLTabBarItemImage : @"concern_unclicked_icon",
                              CYLTabBarItemSelectedImage : @"concern_icon",
                              };
    
    NSDictionary * infoDic = @{CYLTabBarItemTitle : @"",
                               CYLTabBarItemImage : @"message_unclicked_icon",
                               CYLTabBarItemSelectedImage : @"message_icon",
                               };
    
    NSDictionary * mineDic = @{CYLTabBarItemTitle : @"",
                               CYLTabBarItemImage : @"center_unclicked_icon",
                               CYLTabBarItemSelectedImage : @"center_icon",
                               };
    
    NSArray * tabbarItems = @[homeDic,
                              pvcDic,
                              infoDic,
                              mineDic];
    NSArray * vcs = @[homeNav,
                      perNav,
                      celNav,
                      mineNav];
    
    //    _tabBarController = [[YL_MainTabBarViewController alloc] initWithViewControllers:vcs tabBarItemsAttributes:tabbarItems];
    YL_MainTabBarViewController* tabBarController = [YL_MainTabBarViewController tabBarControllerWithViewControllers:vcs tabBarItemsAttributes:tabbarItems imageInsets:UIEdgeInsetsZero titlePositionAdjustment:UIOffsetZero context:nil];
    return tabBarController;
}

-(void)dealloc {
    NSLog(@"---------------\n\rdealloc:%@\n-----------------", NSStringFromClass([self class]));
}

@end
