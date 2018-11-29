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
+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
