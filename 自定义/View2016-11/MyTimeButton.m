//
//  MyTimeButton.m
//  RenCaiKu
//
//  Created by mac on 16/6/21.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "MyTimeButton.h"

@interface MyTimeButton ()
{
    NSInteger _oldTime;
}
//    上一次的文本
@property (copy, nonatomic) NSString *oldText;

@property (strong, nonatomic) NSTimer * timer;

@property (retain, nonatomic) UIColor * oldColor;

@end

@implementation MyTimeButton

-(instancetype)init {
    if (self == [super init]) {
        [self setupTime];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setupTime];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupTime];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupTime];
}

-(void)setupTime {
    _oldText = @"获取验证码";
    kWEAKSELF(weakSelf);
    self.onClickStartTiming = ^() {
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(timeChange:) userInfo:nil repeats:YES];
        weakSelf.oldColor = weakSelf.backgroundColor;
        weakSelf.oldText = weakSelf.titleLabel.text;
        weakSelf.timer.fireDate = [NSDate distantPast];
        weakSelf.enabled = NO;
    };
    
}

-(void)timeChange:(NSTimer *)sender {
    if (0 >= _timeNum) {
        _timeNum = _oldTime;
        sender.fireDate = [NSDate distantFuture];
        [sender invalidate];
        [self setTitle:_oldText forState:(UIControlStateNormal)];
        [self setBackgroundColor:self.oldColor];
        self.enabled = YES;
        return;
    }
    [self setTitle:[NSString stringWithFormat:@"%ld", _timeNum--] forState:(UIControlStateNormal)];

    
}

-(void)resetTime {
    _timeNum = _oldTime;
    self.timer.fireDate = [NSDate distantFuture];
    [self.timer invalidate];
    [self setTitle:_oldText forState:(UIControlStateNormal)];
    self.enabled = YES;
}

-(void)stopTime {
    self.timer.fireDate = [NSDate distantFuture];
    if (_timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)dealloc {
    self.timer.fireDate = [NSDate distantFuture];
    if (_timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

-(void)setTimeNum:(NSInteger)timeNum {
    if (_timeNum  != timeNum) {
        _timeNum = timeNum;
        _oldTime = timeNum;
    }
}

@end
