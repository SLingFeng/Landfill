//
//  SLFTransition.h
//  testOC
//
//  Created by 孙凌锋 on 2017/7/10.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, AnimatedScene) {
    AnimatedScenePush = 0,         // 值为 0
    AnimatedScenePop = 1 << 0,     // 值为 2 的 0次
    AnimatedScenePresent = 1 << 1, // 值为 2 的 1次
    AnimatedSceneDissmiss = 1 << 2 // 值为 2 的 2次
};
@interface SLFTransition : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithStytle:(AnimatedScene)scene;
@end
