//
//  SelectDataPicker.m
//  test
//
//  Created by SADF on 16/11/10.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "SelectDataPicker.h"

typedef enum : NSUInteger {
    SelectStatusOne,
    SelectStatusTwo,
} SelectStatus;
@interface SelectDataPicker ()
{
    UIDatePicker * _datePicker;
    SelectStatus _ss;
    UILabel * _label;
    
    UIView * _backgroundView;
}
@end

@implementation SelectDataPicker

-(instancetype)init {
    if (self == [super init]) {
        [self setPicker];
    }
    return self;
}

-(void)setPicker {
    self.backgroundColor = [CommonTools getColorWithHexString:@"dedede" alpha:0.3];
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH+219, kScreenW, 219)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
    [self addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(219);
        make.bottom.equalTo(self).with.offset(0);
        make.left.and.right.equalTo(self).with.offset(0);
    }];
    
    UIDatePicker * datePicker = [[UIDatePicker alloc] init];
    [_backgroundView addSubview:datePicker];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minuteInterval = 5;
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backgroundView).with.offset(0);
        make.left.and.right.equalTo(_backgroundView).with.offset(0);
    }];
//    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    _datePicker = datePicker;
    
    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [rightBtn setTitle:@"下一项" forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_backgroundView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backgroundView).with.offset(0);
        make.top.equalTo(datePicker.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel * label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"开始时间";
    [_backgroundView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundView);
        make.top.equalTo(datePicker).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    _label = label;
    
    [self show];
}

-(void)show {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        _backgroundView.frame = CGRectMake(0, kScreenH-219, kScreenW, 219);
    }];
}

-(void)cancelTap {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        _backgroundView.frame = CGRectMake(0, kScreenH+219, kScreenW, 219);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)nextBtnClick:(UIButton *)btn {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    if (_ss == SelectStatusOne) {
        _ss = SelectStatusTwo;
        _label.text = @"结束时间";
        NSLog(@"%@", [dateFormatter stringFromDate:_datePicker.date]);
//        [_timeDate appendString:[dateFormatter stringFromDate:_datePicker.date]];
        _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
        [btn setTitle:@"完成" forState:(UIControlStateNormal)];
        [_datePicker setDate:[NSDate date] animated:1];
    }else {
        [_timeDate appendString:[NSString stringWithFormat:@"-%@", [dateFormatter stringFromDate:_datePicker.date]]];
        if (self.backTimeDate) {
            self.backTimeDate(_timeDate);
            [self cancelTap];
        }
    }
}

-(void)dateChange:(UIDatePicker *)dp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSLog(@"%@<>%@", dp.date, [dateFormatter stringFromDate:dp.date]);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
