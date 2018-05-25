//
//  MyButton.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MyStatusFailure,
    MyStatusSuccess,
    MyStatusEnabled,
} MyStatus;

@interface MyButton : UIButton
/**
 * @author LingFeng, 2016-06-21 09:06:46
 *
 * 默认失败 MyStatusFailure
 */
@property (nonatomic) MyStatus status;

/**
 点击事件TouchUpInside 回调
 */
@property (nonatomic, copy) void(^onClickBlock)(MyButton *sender);

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color;

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text;

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

+(instancetype)buttonWithType:(UIButtonType)buttonType fontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text;

+(instancetype)buttonWithType:(UIButtonType)buttonType fontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)setBtnWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color backg:(UIColor *)backg;


//设置上图片 下标题
- (void)setImageTopAndTitleBottom:(NSString *)str;
@end
