//
//  BaseViewController.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginCompleteBlock)(void);

@interface MyBaseViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) id obj;
/**
 页数
 */
@property (nonatomic, assign) NSInteger pageIndex;
/**
 设置导航条标题

 @param title text
 */
-(void)setNavigationTitle:(NSString *)title;

- (void)hiddeNaviBar:(BOOL)isHidde;
/**
 push到下一页面，隐藏Tabbar

 @param vc 需要的vc
 */
-(void)pushViewController:(UIViewController *)vc;
/**
 pop 回已存在的vc

 @param vcClass vc class
 */
- (void)popToViewController:(Class)vcClass;
- (void)popToViewController:(Class)vcClass obj:(id)obj;
@property (nonatomic, copy) void(^BackBlock)(id back);
@end

@interface UIViewController (MyBase)

-(void)pushViewController:(UIViewController *)vc;

@end
