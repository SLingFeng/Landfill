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
- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color setText:(NSString *)title;

@end
