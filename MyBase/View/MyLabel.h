//
//  MyLabel.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Font)
- (void)changeFont:(UIFont *)font;
@end



@interface MyLabel : UILabel

@property (nonatomic, copy) void(^onClick)(void);


@property (nonatomic, retain) UIView *view;
//@property (nonatomic, retain) UIColor *viewBackgroundColor;

@property (nonatomic, copy) IBInspectable NSString *pxFontColor;
@property (nonatomic, assign) IBInspectable CGFloat pxFontSize;
@property (nonatomic, copy) IBInspectable NSString *pxBackColor;

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color setText:(NSString *)title;

@end

@interface MyYYLabel : YYLabel
- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color setText:(NSString *)title;

@end
