//
//  SLFTransition.m
//  testOC
//
//  Created by 孙凌锋 on 2017/7/10.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "SLFTransition.h"

#define kAnimateTime 0.4

@implementation SLFTransition {
    AnimatedScene _scenceStyle;
}

- (instancetype)initWithStytle:(AnimatedScene)scene {
    if (self = [super init])
    {
        _scenceStyle = scene;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return kAnimateTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    switch (_scenceStyle)
    {
        case AnimatedScenePush:
        {// Push 动画 这里只是举个例子  动画效果可以自己去使用
            // 注意点： 一定要把目的视图（要去的 View） 添加到容器（containerView）上.
            [UIView animateWithDuration:kAnimateTime animations:^{
//                fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//                toView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                fromView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                toView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            } completion:^(BOOL finished) {
                [containerView addSubview:toView];
                // 这个方法大概就是完成过渡动画，更新内部视图，控制器状态的转变！
                [UIView animateWithDuration:kAnimateTime animations:^{
                    toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//                    toView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    // 完成过度动画
                    [transitionContext completeTransition:YES];
                }];
            }];
            
            NSLog(@"Push 动画效果");
        }
            break;
        case AnimatedScenePop:
        {
            // Pop 动画
            [UIView animateWithDuration:kAnimateTime animations:^{
                // 让当前的二级页面  从下方消失
                fromView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//                fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            } completion:^(BOOL finished) {
                
                [containerView addSubview:toView];
                
                [UIView animateWithDuration:kAnimateTime animations:^{
                    // 让首级页面  由小变大
//                    toView.transform = CGAffineTransformMakeScale(1, 1);
                    toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    
                } completion:^(BOOL finished) {
                    
                    // 完成过度动画
                    [transitionContext completeTransition:YES];
                }];
            }];
            NSLog(@"Pop 动画效果");
            
        }
            
            break;
        case AnimatedScenePresent:
        {
            
            toView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 , [UIScreen mainScreen].bounds.size.height / 2.0, 0, 0);
            
            [containerView addSubview:toView];
            
            [UIView animateWithDuration:kAnimateTime animations:^{
                
                toView.frame = CGRectMake(0 , 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:YES];
            }];
            
            NSLog(@"Present 动画效果");
            
            
        }
            break;
        case AnimatedSceneDissmiss:
        {
            
            [UIView animateWithDuration:kAnimateTime animations:^{
                // 让当前的二级页面  从上方消失
                fromView.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                
            } completion:^(BOOL finished) {
                
                [containerView addSubview:toView];
                // 完成过度动画
                [transitionContext completeTransition:YES];
                
            }];
            NSLog(@"Dissmiss 动画效果");
            
        }
            break;
            
        default:
            break;
    }
}

@end
