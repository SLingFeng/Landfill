//
//  ShuRuKuangTFView.h
//  NaHu
//
//  Created by SADF on 16/10/31.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <IQKeyboardManager/IQPreviousNextView.h>
@interface ShuRuKuangTFView : UIView
@property (retain, nonatomic) UITextField * TextField;
@property (retain, nonatomic) MyLabel * titleLabel;
@property (assign, nonatomic) BOOL isShangHu;
/**
 被选中的btn的tag
 */
@property (assign, nonatomic) NSInteger isSelectBtn;
/**
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;
/**
 提示空的语句
 */
@property (copy, nonatomic) NSString * hudText;

@property (retain, nonatomic) UITextField * returnNext;

@property (copy, nonatomic) void(^btnClickChange)();
@property (copy, nonatomic) void(^returnKeyClick)();
/**
 输入改变时
 */
@property (copy, nonatomic) void(^textFieldChange)(NSString *);
/**
 取消选中btn的效果
 */
-(void)setDeSelectBtn;
/**
 带图片、文字和输入框view

 @param titleText       label文字
 @param placeholderText 输入框 等待文字
 @param image           label前的图片
 @param custom          自定义view

 @return view
 */
-(instancetype)initWithTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image custom:(UIView *)custom;
-(instancetype)initWithSelect;
-(instancetype)initWithSelect:(NSString *)titleText;
-(instancetype)initWithSelectToPay:(NSString *)titleText;

@end
