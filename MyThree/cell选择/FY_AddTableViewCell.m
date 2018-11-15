//
//  FY_HouseEnterTableViewCell.m
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/9.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "FY_AddTableViewCell.h"

@implementation FY_AddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        kViewAddView(self.rightIV, UIImageView, self.contentView);
        self.rightIV.image = [UIImage imageNamed:@"next_icon"];
        
        self.titleLabel = [[MyLabel alloc] initWithFontSize:30 fontColor:k232931 setText:@"标题"];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentJustified;
//        [self.titleLabel LabelAlightLeftAndRightWithWidth:kAW(150)];
        self.titleLabel.font = [SLFCommonTools pxBoldFont:30];

        
        self.tf = [[BaseTextField alloc] init];
        [self.contentView addSubview:self.tf];
        self.tf.textAlignment = NSTextAlignmentRight;
        self.tf.font = [SLFCommonTools pxFont:30];
        
        self.rightLabel = [[MyLabel alloc] initWithFontSize:30 fontColor:k232931 setText:@"1"];
        [self.contentView addSubview:self.rightLabel];
        self.rightLabel.hidden = 1;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(15);
            make.size.mas_equalTo(CGSizeMake(kAW(150), 20));
        }];
        
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(30);
            make.centerY.equalTo(self.contentView);
//            make.right.equalTo(self.rightIV.mas_left).offset(-5);
            make.top.bottom.offset(0);
        }];
        
        [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(9, 15));
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kAW(30));
            make.right.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];

        [self setupAutoHeightWithBottomView:self.titleLabel bottomMargin:20];
    }
    return self;
}

- (void)setModel:(FY_HouseAddCellModel *)model {
    _model = model;
    
    NSDictionary * style = @{@"font" : [SLFCommonTools pxFont:30],
                             @"font2" : [SLFCommonTools pxFont:30],
                             @"color" : [UIColor grayColor],
                             @"color2" : k232931,
                             @"color3" : HEXCOLOR(0xFF0000)};
    self.tf.attributedPlaceholder = [model.placeholder attributedStringWithStyleBook:style];

    self.titleLabel.attributedText = [model.title attributedStringWithStyleBook:style];

//    self.titleLabel.text = model.title;
    self.tf.textFieldChange = model.textFieldChange;
    self.tf.keyboardType = model.keyboardType;
    
    if (model.type == 10 || model.type == 0) {
        self.rightIV.hidden = NO;
    }else {
        self.rightIV.hidden = YES;
    }
    
    self.rightLabel.hidden = model.type == 11 ? NO : YES;
    self.rightLabel.text = model.rightText;
    
    
    [self.tf mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel.mas_right).offset(30);
//        make.centerY.equalTo(self.contentView);
//        make.top.bottom.offset(0);

        if (model.type == 1) {
            make.right.equalTo(self.contentView).offset(-15);

        }else {
            make.right.equalTo(self.contentView).offset(-36);
        }
    }];
    
//    [self.titleLabel LabelAlightLeftAndRightWithWidth:kAW(150)];
//    self.tf.placeholder = model.placeholder;
    self.tf.enterNumber = model.enterNumber;
//    self.rightIV.hidden = model.rightIVHidden;
    
//    if (model.onClickBlock) {
//        [self rightBtnLayout:NO];
//        [self.rightBtn setTitle:model.btnTitle forState:(UIControlStateNormal)];
//        self.rightBtn.onClickBlock = ^(MyButton *sender) {
//            sender.selected = !sender.selected;
//            model.onClickBlock(sender);
//        };
//    }else {
//        [self rightBtnLayout:YES];
//    }

    if (model.type == 0) {
        self.tf.userInteractionEnabled = NO;
    }else if (model.type == 1) {
        self.tf.userInteractionEnabled = YES;
    }
    
    if (!kStringIsEmpty(model.userEnterText)) {
        self.tf.text = model.userEnterText;
    }else {
        self.tf.text = nil;
    }
}

- (MyButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[MyButton alloc] initWithFontSize:32 fontColor:HEXCOLOR(0xaaaaaa) fontText:@""];
        [_rightBtn setImage:[UIImage imageNamed:@"choice_unclicked_icon"] forState:(UIControlStateNormal)];
        [_rightBtn setImage:[UIImage imageNamed:@"choice_clicked_icon"] forState:(UIControlStateSelected)];
        _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self.contentView addSubview:self.rightBtn];
    }
    return _rightBtn;
}

- (void)rightBtnLayout:(BOOL)hidden {
    self.rightBtn.hidden = hidden;
    if (hidden) {
        [self.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(30);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.rightIV.mas_left).offset(-10);
            make.top.bottom.offset(0);
        }];
//        [self.tf mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.rightBtn.mas_left).offset(-10);
//        }];
    }else {
        [self.tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(30);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.rightIV.mas_left).offset(-10);
            make.top.bottom.offset(0);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(120, 30));
            make.right.equalTo(self.rightIV.mas_left).offset(-10);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
