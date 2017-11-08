//
//  MyMBProgressHUD.h
//  RenCaiKu
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef void (^completionBlock)();

@interface MyMBProgressHUD : NSObject
@property (nonatomic, copy) completionBlock completion;
@property (nonatomic, strong) MBProgressHUD * hud;
/**
 *  @author LingFeng, 2016-06-08 11:06:34
 *
 *  只显示文本
 *
 *  @param text 文字
 *  @param view 显示的窗口
 */
+(void)hudForText:(NSString *)text view:(UIView *)view;
/**
 *  @author LingFeng, 2016-06-08 11:06:17
 *
 *  从上一个hudView更改只显示文本
 *
 *  @param text  文字
 *  @param delay 显示时间
 */
+(void)hudForText:(NSString *)text  delay:(float)delay;
/**
 *  @author LingFeng, 2016-06-08 11:06:17
 *
 *  从上一个hudView更改只显示文本
 *
 *  @param text  文字
 */
+(void)hudForText:(NSString *)text;

+(void)hudLoadToText:(NSString *)text;
+(void)hudAlwaysLoadToText:(NSString *)text;
/**
 *  @author LingFeng, 2016-06-08 11:06:17
 *
 *  从上一个hudView更改只显示文本
 *
 *  @param text  文字
 *  @param back 隐藏后调用
 */
+(void)hudForText:(NSString *)text call:(completionBlock)back;
+(void)hudForText:(NSString *)text delay:(float)delay call:(completionBlock)back;
/**
 圆形进度

 @param progress NSProgress进度对象
 @param text     文字

 @return MBProgressHUD
 */
//+(MBProgressHUD *)hudLoadProgress:(NSProgress *)progress text:(NSString *)text;
+(MBProgressHUD *)hudLoadProgress:(NSProgress *)progress text:(NSString *)text view:(UIView *)view;
/**
 *  @author LingFeng, 2016-06-08 11:06:48
 *
 *  从上一个hudView更改 菊花 持续15s
 *
 *  @param text 文字
 */
+(void)hudShowLoadForText:(NSString *)text;
/**
 *  @author LingFeng, 2016-06-08 11:06:54
 *
 *  移除所有hudView
 */
+(void)hideAllHubForView;
+(void)hideShareHub;

@end
