//
//  MyButton.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton {
    UIColor *_diseColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupButton];
}

-(instancetype)init {
    if (self = [super init]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

+(instancetype)buttonWithType:(UIButtonType)buttonType {
    MyButton * btn = [super buttonWithType:buttonType];
    [btn setupButton];
    return btn;
}

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color {
    if (self = [super init]) {
        [self setTitleColor:color forState:(UIControlStateNormal)];
        self.titleLabel.font = [SLFCommonTools pxFont:fontSize];
        
        [self setupButton];
    }
    return self;
}


- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text {
    if (self = [super init]) {
        [self setTitleColor:color forState:(UIControlStateNormal)];
        self.titleLabel.font = [SLFCommonTools pxFont:fontSize];
        [self setTitle:text forState:UIControlStateNormal];
        
        [self setupButton];
    }
    return self;
}

- (instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self = [super init]) {
        [self setTitleColor:color forState:(UIControlStateNormal)];
        self.titleLabel.font = [SLFCommonTools pxFont:fontSize];
        [self setTitle:text forState:UIControlStateNormal];
        
        [self setBackgroundColor:backg];
        self.layer.cornerRadius = radius;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        
        [self setupButton];
    }
    return self;
}

+(instancetype)buttonWithType:(UIButtonType)buttonType fontSize:(NSInteger)fontSize fontColor:(UIColor *)color fontText:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    MyButton * btn = [super buttonWithType:buttonType];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.titleLabel.font = [SLFCommonTools pxFont:fontSize];
    [btn setTitle:text forState:UIControlStateNormal];
    
    [btn setBackgroundColor:backg];
    btn.layer.cornerRadius = radius;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    [btn setupButton];
    return btn;
}

-(void)setupButton {
    
//    [self setTitleColor:RGBCOLOR(51, 51, 51) forState:(UIControlStateNormal)];
//    //    圆角
//    self.layer.cornerRadius = 3;
//    [self setBackgroundColor:[SLFCommonTools getBackgroundColor]];
//    self.status = MyStatusEnabled;
    [self addTarget:self action:@selector(onClic:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)onClic:(MyButton *)sender {
    if (self.onClickBlock) {
        self.onClickBlock(sender);
    }
}

- (void)setStatus:(MyStatus)status {
    _status = status;
    if (status == MyStatusEnabled) {
//        self.enabled = 1;
//        [self setBackgroundColor:kFF7E00];
    }else if (status == MyStatusFailure) {
//        self.enabled = 0;
//        [self setBackgroundColor:k999999];
    }
}

- (void)setBtnWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color backg:(UIColor *)backg {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    self.titleLabel.font = [SLFCommonTools pxFont:fontSize];
    [self setBackgroundColor:backg];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
