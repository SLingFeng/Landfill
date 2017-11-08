//
//  BaseImageView.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView{
    CALayer  *_Layer;
}
@synthesize image = _image;

- (instancetype)init {
    if (self = [super init]) {
        [self ovImage];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self ovImage];
    }
    return self;
}

- (void)ovImage {
    self.backgroundColor = kColorRandomly;
    _duration = 0.3f;
    _Layer = self.layer;
}

- (UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"contents"];
        ani.fromValue = (__bridge id)(_image.CGImage);
        ani.toValue   =  (__bridge id)(image.CGImage);
        ani.duration  = _duration;
        _Layer.contents = (__bridge id)(image.CGImage);
        [_Layer addAnimation:ani forKey:nil];
        
        _image = image;
        [self performSelector:@selector(cr) withObject:nil afterDelay:0.01];
    }
}

- (void)setRadius:(CGFloat)radius {
//    if (_radius != radius) {
        _radius = radius;
        if (_radius) {
            [self cr];
        }
//    }
}

- (void)cr {
    if (self.image) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bounds.size.width, self.bounds.size.height), NO, 0);
        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.radius] addClip];
        [self.image drawInRect:self.bounds];
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

@end
