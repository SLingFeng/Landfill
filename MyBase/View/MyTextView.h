//
//  MyTextView.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView
@property(nonatomic, retain) UILabel *placeHolderLabel;

@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, retain) UIColor *placeholderColor;

@property (nonatomic, assign) NSInteger textLocation;//这里声明一个全局属性，用来记录输入位置
/**
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;
/**
 输入改变时
 */
@property (copy, nonatomic) void(^textViewChange)(NSString *);
@property (copy, nonatomic) void(^textBeginEditing)();

@end
