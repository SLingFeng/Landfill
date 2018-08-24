//
//  ShadowButton.m
//  tanglianai
//
//  Created by 孙凌锋 on 2018/8/23.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "ShadowButton.h"

@implementation ShadowButton

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0].CGColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(7,7)];
    ((CAShapeLayer *)self.layer).path = maskPath.CGPath;
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
}
//
//作者：萌小菜
//链接：https://www.jianshu.com/p/0754833349a1
//來源：简书
//简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

@end
