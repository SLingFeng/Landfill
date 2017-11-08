//
//  PaymentMethodTableViewCell.m
//
//  Created by Hale on 17/3/21.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import "PaymentMethodTableViewCell.h"

@implementation PaymentMethodTableViewCell {
    MyLabel *_titleLabel;
    NSArray *_imageArr;
    NSArray *_titleArr;
    MyLabel *_balanceLabel;
    ThemeButton * _balanceBtn;
    UIView *_balanceView;
    NSMutableArray *_btnArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        kWeakSelf(weakSelf);
        kContentViewAdd(_titleLabel, MyLabel);
        _titleLabel.font = [SLFCommonTools pxFont:30];
        _titleLabel.textColor = k111111;
        _titleLabel.text = @"付款方式";
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.offset(10);
            make.right.offset(0);
        }];
        
        _btnArr = [NSMutableArray arrayWithCapacity:3];
        _imageArr = @[@"list_icon_zhifubao", @"list_icon_wechat", @"list_icon_yue"];
        _titleArr = @[@"支付宝支付", @"微信支付", @"余额支付"];
        
        UIView * lastView;
        for (int i=0; i<3; i++) {
            UIView *view = [[UIView alloc] init];
            view.tag = i + 40;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBtnOnClick:)];
            [view addGestureRecognizer:tap];
            [self.contentView addSubview:view];
            
            UIImageView * logoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArr[i]]];
            [view addSubview:logoIV];
            
            MyLabel *title = [[MyLabel alloc] initWithFontSize:15 fontColor:@"111111" setText:_titleArr[i]];
            [view addSubview:title];
            
            ThemeButton * goBtn = [[ThemeButton alloc] initWithFontSize:15 fontColor:@"111111" fontText:nil];
            [view addSubview:goBtn];
            [_btnArr addObject:goBtn];
            goBtn.tag = 30+i;
            [goBtn setImage:[UIImage imageNamed:@"liast_btn_check_nor"] forState:(UIControlStateNormal)];
            [goBtn setImage:[UIImage imageNamed:@"list_btn_check_sel"] forState:(UIControlStateSelected)];
            [goBtn setOnClickBlock:^(ThemeButton *sender) {
                [weakSelf performSelector:@selector(goBtnOnClick:) withObject:tap];
            }];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.top.equalTo(_titleLabel.mas_bottom).offset(10);
                    make.centerX.equalTo(weakSelf.contentView);
                    make.left.and.right.offset(0);
                    make.height.mas_equalTo(60);
                }else {
                    make.top.equalTo(lastView.mas_bottom).offset(0);
                    make.centerX.equalTo(weakSelf.contentView);
                    make.left.and.right.and.height.equalTo(lastView);
                }
            }];
            
            [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15);
                make.size.mas_equalTo(CGSizeMake(33, 33));
                make.centerY.equalTo(view);
            }];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(logoIV.mas_right).offset(15);
                make.centerY.equalTo(view);
                make.width.mas_equalTo(150);
            }];
            
            [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-10);
                make.size.mas_equalTo(CGSizeMake(25, 25));
                make.centerY.equalTo(view);
            }];
            
            if (i == 0) {
                goBtn.selected = YES;
            }
            if (i != 2) {
                [SLFCommonTools line:view y:59 leftSpace:0 rightSpace:kScreenW color:@"bfbfbf" lineW:0.5];
            }else {
                _balanceLabel = title;
                _balanceBtn = goBtn;
                _balanceView = view;
                [self setupAutoHeightWithBottomView:view bottomMargin:0];
            }
            lastView = view;
        }
    }
    return self;
}

- (void)goBtnOnClick:(UITapGestureRecognizer *)sender {
    for (ThemeButton * temp in _btnArr) {
        temp.selected = NO;
    }
    ThemeButton * btn = [sender.view viewWithTag:(sender.view.tag - 40) + 30];
    btn.selected = YES;
    if (self.selectPaymentMethod) {
        self.selectPaymentMethod(sender.view.tag - 40);
    }
}

- (void)setupInsufficientBalance {
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:30],
                             @"font2" : [SLFCommonTools pxFont:30],
                             @"color" : k111111,
                             @"color2" : kFF0000};
    _balanceView.userInteractionEnabled = NO;
    _balanceBtn.hidden = 1;
    _balanceLabel.attributedText = [[NSString stringWithFormat:@"<color><font>%@</font></color><color2><font2>(%@)</font2></color2>", _titleArr[2], @"余额不足"] attributedStringWithStyleBook:style];
    
}

- (void)setupGoBalance {
    
}

@end
