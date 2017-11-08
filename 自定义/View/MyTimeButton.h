//
//  MyTimeButton.h
//  RenCaiKu
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTimeButton : UIButton
//    禁用时间
@property (assign, nonatomic) NSInteger timeNum;
/**
 * @author LingFeng, 2016-08-11 09:08:40
 *
 * 开始倒计时方法
 */
@property (copy, nonatomic) void(^onClickStartTiming)();
/**
 * @author LingFeng, 2016-09-07 11:09:38
 *
 * 重置时间
 */
-(void)resetTime;
/**
 * @author LingFeng, 2016-08-11 09:08:46
 *
 * 停止时间（放在视图控制器中viewDidDisappear中\如果不是控制器放在dealloc中）
 */
-(void)stopTime;
@end
