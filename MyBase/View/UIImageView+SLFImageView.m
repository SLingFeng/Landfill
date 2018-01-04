//
//  UIImageView+SLFImageView.m
//  lieyi
//
//  Created by 孙凌锋 on 2018/1/4.
//  Copyright © 2018年 LingFeng. All rights reserved.
//

#import "UIImageView+SLFImageView.h"

@implementation UIImageView (SLFImageView)

- (void)setColor:(UIColor *)color {
    self.image = [self.image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    [self setTintColor:k666666];
}

@end
