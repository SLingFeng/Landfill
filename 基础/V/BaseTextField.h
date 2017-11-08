//
//  BaseTextField.h
//  NaHu
//
//  Created by SADF on 16/12/14.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

/**
 输入的字符数量
 */
@property (assign, nonatomic) NSInteger enterNumber;
/**
 输入改变时
 */
@property (copy, nonatomic) void(^textFieldChange)(NSString *);

@property (nonatomic, copy) void(^returnKeyClick)(BaseTextField *tf);
//@property (nonatomic, copy) void(^returnKeyClick)(BaseTextField *tf);
@end
