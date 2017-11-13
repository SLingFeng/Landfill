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
//    DVYearMonthDatePicker * _dvDatePicker;
    SelectStatus _ss;
    UILabel * _label;
    UIPickerView * _pickerView;
    UIView * _backgroundView;
    ShuRuKuangTFView * _money;
    
    NSMutableArray * _numArr;
    SeleCtType _type;
    NSString * _selectPercentage;
    CGFloat _selectHeight;
    //选择
    NSInteger _index;
    
    NSMutableArray *_customizeArr;
}
@end

@implementation SelectDataPicker

-(instancetype)initWithType:(SeleCtType)type {
    if (self = [super init]) {
        _type = type;
        if (_type == SeleCtTypeMoney) {
            _selectHeight = 40;
            // 监听键盘改变
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        }else {
            _selectHeight = 260;
        }
        _index = 0;
        [self setPicker];
    }
    return self;
}

+ (instancetype)pickerWithDataArr:(NSArray *)dataArr block:(selectIndexBlock)block {
    return [[SelectDataPicker alloc] initWithDataArr:dataArr block:block];
}
- (instancetype)initWithDataArr:(NSArray *)dataArr block:(selectIndexBlock)block {
    if (self = [super init]) {
        _type = SeleCtTypeCustomize;
        
        _customizeArr = [NSMutableArray arrayWithArray:dataArr];
        [self setPicker];
        self.selectIndexBlock = block;
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
    _backgroundView.frame = CGRectMake(0, frame.origin.y - _selectHeight, kScreenW, _selectHeight);
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];
}

-(void)setPicker {
    self.frame = kScreen;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];

    UIView * back = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight)];
    _backgroundView = back;
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.layer.cornerRadius = 5.f;
    _backgroundView.layer.masksToBounds = YES;
    [self addSubview:_backgroundView];
    _backgroundView.alpha = 0;
    
    [self setSelectPicker:_type];
//    [_backgroundView addSubview:[CommonTools lineViewToY:50 leftSpace:10 rightSpace:(kScreenW-24)-20 color:kLineColor lineW:0.5]];

    UIButton * cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(cancelTap) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelBtn setTitleColor:[SLFCommonTools getNavBarColor] forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = [SLFCommonTools pxFont:28];
    [_backgroundView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).with.offset(0);
        make.top.equalTo(_backgroundView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    
    UIButton * doneBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [doneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [doneBtn setTitleColor:[SLFCommonTools getNavBarColor] forState:(UIControlStateNormal)];
    doneBtn.titleLabel.font = [SLFCommonTools pxFont:28];
    [_backgroundView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backgroundView).with.offset(0);
        make.top.equalTo(_backgroundView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    
    if (_type != SeleCtTypeMoney) {
    }else {
        [doneBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_backgroundView);
        }];
    }
    
    
    [self show];
}

-(void)setSelectPicker:(SeleCtType)type {
    switch (type) {
        case SeleCtTypeYearMonthDay:
        {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
        }
            break;
        case SeleCtTypeYearMonth:
        {
//            DVYearMonthDatePicker *datePicker = [[DVYearMonthDatePicker alloc] init];
//            datePicker.dvDelegate = self;
//            [datePicker selectToday];
//            [_backgroundView addSubview:datePicker];
//            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(_backgroundView).with.offset(0);
//                //                make.left.and.right.equalTo(_backgroundView).with.offset(0);
//                make.left.offset(20);
//                make.right.offset(-20);
//            }];
//            _dvDatePicker = datePicker;
        }
            break;
        case SeleCtTypePercentage:
        {
            [self dp];
            _selectPercentage = @"1%";
            
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
        case SeleCtTypeName: {
            [self dp];
//            _numArr = [NSMutableArray arrayWithCapacity:100];
//            for (int i=1; i<100; i++) {
//                [_numArr addObject:[NSString stringWithFormat:@"%d%%", i]];
//            }
        }
            break;
        case SeleCtTypeTime: {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
            
        }
            break;
        case SeleCtTypeCountDownTimer: {
            UIDatePicker * datePicker = [[UIDatePicker alloc] init];
            [_backgroundView addSubview:datePicker];
            datePicker.datePickerMode = UIDatePickerModeTime;
            [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_backgroundView).with.offset(0);
                make.left.and.right.equalTo(_backgroundView).with.offset(0);
            }];
            _datePicker = datePicker;
            
        }
            break;
        case SeleCtTypeCustomize: {
            [self dp];
        }
            break;
            
        default:
            break;
    }
    
}
-(UIPickerView *)dp {
    UIPickerView * pv = [[UIPickerView alloc] init];
    [_backgroundView addSubview:pv];
    pv.delegate = self;
    pv.dataSource = self;
//    for (UIView *separatorLine in pv.subviews) {
//        if (separatorLine.frame.size.height < 1) {
//            separatorLine.backgroundColor = [CommonTools colorHex:kLineColor];
//        }
//    }
    _pickerView = pv;
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backgroundView).with.offset(0);
        make.left.offset(20);
        make.right.offset(-20);
    }];
    return pv;
}

-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-_selectHeight, kScreenW, _selectHeight);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _backgroundView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)nextBtnClick:(UIButton *)btn {
    switch (_type) {
        case SeleCtTypeYearMonthDay:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
            if (self.backTimeDate) {
                self.backTimeDate(_timeDate, _datePicker.date, _index);
                [self cancelTap];
            }
            
        }
            break;
        case SeleCtTypeYearMonth:{
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"YYYY-MM"];
//            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_dvDatePicker.date]];
//            if (self.backTimeDate) {
//                self.backTimeDate(_timeDate, _dvDatePicker.date, _index);
//                [self cancelTap];
//            }
        }
            break;
        case SeleCtTypePercentage:{
            if (self.backTimeDate) {
                self.backTimeDate(_selectPercentage, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeMoney:{
            if (self.backTimeDate) {
                self.backTimeDate(_money.TextField.text, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeName:{
            if (self.backTimeDate) {
                if (_NameDataArr.count != 0) {
                    self.backTimeDate(_selectPercentage== nil?_NameDataArr[0]:_selectPercentage, nil, _index);
                }
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeTime: {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
            if (self.backTimeDate) {
                self.backTimeDate(_timeDate, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeCountDownTimer: {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:ss"];
            _timeDate = [[NSMutableString alloc] initWithString:[dateFormatter stringFromDate:_datePicker.date]];
            if (self.backTimeDate) {
                self.backTimeDate(_timeDate, _datePicker.date, _index);
                [self cancelTap];
            }
        }
            break;
        case SeleCtTypeCustomize: {
            if (self.selectIndexBlock) {
                self.selectIndexBlock(_selectPercentage, _index);
                [self cancelTap];
            }
        }
            
        default:
            break;
    }
}

-(void)dateChange:(UIDatePicker *)dp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSLog(@"%@<>%@", dp.date, [dateFormatter stringFromDate:dp.date]);
}

-(void)setNameDataArr:(NSMutableArray *)NameDataArr {
    if (_NameDataArr != NameDataArr) {
        _NameDataArr = NameDataArr;
        if (NameDataArr.count != 0 || NameDataArr != nil) {
            _selectPercentage = _NameDataArr[0];
            [_pickerView reloadAllComponents];
        }
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_type == SeleCtTypeName) {

        return _NameDataArr.count;
    }
    if (_type == SeleCtTypeCustomize) {
        return _NameDataArr.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (_type == SeleCtTypeCustomize) {
        return _NameDataArr[row];
    }
    
    if (_type == SeleCtTypeName) {
        return _NameDataArr[row];
    }
    return _numArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _index = row;
    
    if (_type == SeleCtTypeName || _type == SeleCtTypeCustomize) {
        if (kArrayIsEmpty(_NameDataArr)) {
            return;
        }
        _selectPercentage = _NameDataArr[row];
    }else {
        _selectPercentage = _numArr[row];
    }
}

//dv
//- (void)yearMonthDatePicker:(DVYearMonthDatePicker *)yearMonthDatePicker didSelectedDate:(NSDate *)date {
//    NSLog(@"%@", date);
//}

@end
