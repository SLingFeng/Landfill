//
//  UIImageView+CircleImage.m
//  NaHu
//
//  Created by SADF on 16/12/12.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)
//- (UIImage *)drawCircleImage {
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:50] addClip];
//    [self drawInRect:self.bounds];
//    
//    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return output;
//}

//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    UIImage *img = [[UIImage imageNamed:@"image.png"] drawCircleImage];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        imageView.image = img;
//    });
//});

@end
