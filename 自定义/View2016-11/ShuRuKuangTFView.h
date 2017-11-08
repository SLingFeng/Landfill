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
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;
/**
 提示空的语句
 */
@property (copy, nonatomic) NSString * hudText;

/**
 带图片、文字和输入框view

 @param titleText       label文字
 @param placeholderText 输入框 等待文字
 @param image           label前的图片

 @return view
 */
-(instancetype)initWithTitle:(NSString *)titleText placeholder:(NSString *)placeholderText image:(NSString *)image;
-(instancetype)initWithSelect;
-(instancetype)initWithSelect:(NSString *)titleText;

@end
