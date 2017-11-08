//
//  UIImage+MyImage.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)
- (UIImage*)getSubImage:(CGRect)rect;
- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)viewImageFromColor:(UIColor *)color rect:(CGRect)rect;
@end
