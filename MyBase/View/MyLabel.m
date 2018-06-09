//
//  MyLabel.m
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyLabel.h"
#import <CoreText/CoreText.h>



@implementation MyLabel

-(instancetype)init {
    if (self = [super init]) {
        [self setMyLabel];
    }
    return self;
}
-(instancetype)initWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color setText:(NSString*)title{
    if (self = [super init]) {
        self.textColor = color;
        self.numberOfLines = 0;
//        self.userInteractionEnabled = YES;
        self.font = [SLFCommonTools pxFont:fontSize];//[UIFont systemFontOfSize:kAH(fontSize)];
        [self setText:title];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setMyLabel];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setMyLabel];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setMyLabel];
}

-(void)setMyLabel {
//    self.textColor = k111111;
    self.numberOfLines = 0;
//    self.userInteractionEnabled = YES;
    self.font = [SLFCommonTools pxFont:28];
    
    
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelClick)]];
//    self.backgroundColor = kColorRandomly;
//    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//    tap.minimumPressDuration = 1.0;
//    [self addGestureRecognizer:tap];
}

//- (void)tapLabelClick {
//    if (self.onClick) {
//        self.onClick();
//    }
//}

- (void)setPxFontSize:(CGFloat)pxFontSize {
    _pxFontSize = pxFontSize;
    self.font = [SLFCommonTools pxFont:_pxFontSize];
}

- (void)setPxFontColor:(NSString *)pxFontColor {
    _pxFontColor = pxFontColor;
    self.textColor = [SLFCommonTools colorHex:_pxFontColor];
}

- (void)setPxBackColor:(NSString *)pxBackColor {
    _pxBackColor = pxBackColor;
    self.backgroundColor = [SLFCommonTools colorHex:_pxBackColor];
}

- (void)setFont:(UIFont *)font {
    if (_pxFontSize <= 0) {
        [super setFont:font];
    }else {
        [super setFont:[SLFCommonTools pxFont:_pxFontSize]];
    }
    
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    
    [self becomeFirstResponder];
    
    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"复制文字" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[menuItem]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}

-(void)copyText:(nullable id)sender {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (UIView *)view {
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _view;
}

- (void)LabelAlightLeftAndRightWithWidth:(CGFloat)labelWidth {
    CGSize testSize = [self.text boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :self.font} context:nil].size;
    
    CGFloat margin = (labelWidth - testSize.width)/(self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attribute addAttribute: NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1 )];
    self.attributedText = attribute;
}

/** 该方法如果返回为YES，那么menu会出现UIResponderStandardEditActions里所有的字段，如cut，copy，paste，select，selectAll等等。
 当然，也可以不写这2句，
 UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
 [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:menuItem, nil]];
 它默认会出现copy这一项，需要实现copy:这个方法。注意：由于plist里面，Localization native development region字段是“en”，没有本地化，所以menu项显示的是“copy”，如果把该字段改成“China”，那么menu项会显示为“拷贝”，其他的menu项也会一律变为中文。
 如果自定义其他menu项，就用上面的2句。
 **/
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copyText:)) {
        return YES;
    }
    
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
