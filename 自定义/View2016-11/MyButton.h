//
//  MyButton.h
//  RenCaiKu
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MyStatusFailure,
    MyStatusSuccess,
} MyStatus;

@interface MyButton : UIButton
/**
 * @author LingFeng, 2016-06-21 09:06:46
 *
 * 默认失败 MyStatusFailure
 */
@property (nonatomic) MyStatus myStatus;


@end
