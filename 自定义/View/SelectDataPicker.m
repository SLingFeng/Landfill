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


@interface SelectDataPicker ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIDatePicker * _datePicker;
    SelectStatus _ss;
    UILabel * _label;
    UIView * _tempView;
    UIView * _backgroundView;
    ShuRuKuangTFView * _money;
    
    NSMutableArray * _numArr;
    SeleCtType _type;
    NSString * _selectPercentage;
    CGFloat _selectHeight;
}
@end

@implementation SelectDataPicker

-(instancetype)initWithType:(SeleCtType)type {
    if (self == [super init]) {
        _type = type;
        if (_type == SeleCtTypeMoney) {
            _selectHeight = 40;
            // 监听键盘改变
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        }else {
            _selectHeight = 230;
        }
        [self setPicker];
    }
    return self;
}



// 移除监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 监听键盘的frame即将改变的时候调用
- (void)keyboardWillChange:(NSNotification *)note{
    // 获得键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 修改底部约束
//    [_backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.frame.size.height - frame.origin.y);
//    }];
    _backgroundView.frame = CGRectMake(0, frame.origin.y - _selectHeight, kScreenW, _selectHeight);
//    _backgroundView.sd_resetNewLayout.heightIs(_selectHeight).bottomSpaceToView(self, self.frame.size.height - frame.origin.y).leftSpaceToView(self, 0).rightSpaceToView(self, 0);
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];
}

//-(instancetype)initWithFrame:(CGRect)frame {
//    if (self == [super initWithFrame:frame]) {
//        [self setPicker];
//    }
//    return self;
//}

-(void)setPicker {
    self.frame = kScreen;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = kCOLOR_WITH_RGBA(0, 0, 0, 0.5);
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];

    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    _backgroundView.alpha = 1;
//    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(_selectHeight);
//        make.bottom.equalTo(self).with.offset(0);
//        make.left.and.right.equalTo(self).with.offset(0);
//    }];
//    _backgroundView.sd_layout.heightIs(_selectHeight).bottomSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0);
//    [_backgroundView updateLayout];
    
    [self setSelectPicker:_type];
    
    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [rightBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_backgroundView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backgroundView).with.offset(0);
        make.top.equalTo(_backgroundView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    if (_type != SeleCtTypeMoney) {
        UILabel * label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        if (_type == SeleCtTypeTime) {
            label.text = @"选择充电时间";
        }else {
            label.text = @"选择充电百分比";
        }
        
        [_backgroundView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backgroundView);
            make.top.equalTo(_backgroundView).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        _label = label;
    }else {
        [rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_backgroundView);
        }];
    }
    
    
    [self show];
}

-(void)setSelectPicker:(SeleCtType)type {
    switch (type) {
        case SeleCtTypeTime:
        {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
            datePicker.minuteInterval = 5;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
            _tempView = datePicker;
        }
            break;
        case SeleCtTypePercentage:
        {
            UIPickerView * pv = [[UIPickerView alloc] init];
            [_backgroundView addSubview:pv];
            pv.delegate = self;
            pv.dataSource = self;
            _tempView = pv;
            _selectPercentage = @"1%";
            [pv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _numArr = [NSMutableArray arrayWithCapacity:100];
            for (int i=1; i<100; i++) {
                [_numArr addObject:[NSString stringWithFormat:@"%d%%", i]];
            }
        }
            break;
        case SeleCtTypeMoney:
        {
            
            ShuRuKuangTFView * money = [[ShuRuKuangTFView alloc] initWithTitle:@"充值金额" placeholder:@"请输入充值的金额" image:nil custom:nil];
            [_backgroundView addSubview:money];
            money.TextField.keyboardType = UIKeyboardTypeNumberPad;
            [money.TextField becomeFirstResponder];
            money.enterNumber = 4;
            _money = money;
            [money mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_backgroundView);
                make.centerY.equalTo(_backgroundView);
                make.left.equalTo(_backgroundView).offset(0);
                make.right.offset(70);
                make.height.mas_equalTo(30);
            }];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)show {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-_selectHeight, kScreenW, _selectHeight);
    }];
}

-(void)cancelTap {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)nextBtnClick:(UIButton *)btn {
    
//    if (_ss == SelectStatusOne) {
//        _ss = SelectStatusTwo;
//        _label.text = @"结束时间";
//        NSLog(@"%@", [dateFormatter stringFromDate:_datePicker.date]);
////        [_timeDate appendString:[dateFormatter stringFromDate:_datePicker.date]];
//        _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
//        [btn setTitle:@"完成" forState:(UIControlStateNormal)];
//        [_datePicker setDate:[NSDate date] animated:1];
//    }else {
//        [_timeDate appendString:[NSString stringWithFormat:@"-%@", [dateFormatter stringFromDate:_datePicker.date]]];
//        if (self.backTimeDate) {
//            self.backTimeDate(_timeDate);
//            [self cancelTap];
//        }
//    }
    if (_type == SeleCtTypeTime) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH时mm分"];
        _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
        if ([_timeDate isEqualToString:@"00时00分"]) {
            _timeDate = [[NSMutableString alloc] initWithString:@"00时05分"];
        }
        if (self.backTimeDate) {
            self.backTimeDate(_timeDate);
            [self cancelTap];
        }
    }else if (_type == SeleCtTypePercentage) {
        if (self.backTimeDate) {
            self.backTimeDate(_selectPercentage);
            [self cancelTap];
        }
    }else {
        if (self.backTimeDate) {
            self.backTimeDate(_money.TextField.text);
            [self cancelTap];
        }
    }
    
}

-(void)dateChange:(UIDatePicker *)dp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSLog(@"%@<>%@", dp.date, [dateFormatter stringFromDate:dp.date]);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 99;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _numArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectPercentage = _numArr[row];
    
}

@end
