//
//  SLFEditTableViewCell.m
//  lieyi
//
//  Created by SADF on 17/1/6.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "SLFEditTableViewCell.h"

@implementation SLFEditTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        kContentViewAdd(self.title, MyLabel);
        
        kContentViewAdd(self.textFiled, BaseTextField);
        _textFiled.placeholder = @"请填写";
        _textFiled.textAlignment = NSTextAlignmentRight;
        
        kWeakSelf(weakSelf);

        [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-kMainSpace);
//            make.left.equalTo(weakSelf.title.mas_right).offset(10);
            make.centerY.equalTo(weakSelf.contentView);
            make.width.mas_equalTo(kScreenW - 90).priorityLow();
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMainSpace);
//            make.width.mas_equalTo(100);
            make.right.equalTo(weakSelf.textField.mas_left).offset(-10);
            make.centerY.equalTo(weakSelf.contentView);
        }];
        
    }
    return self;
}

@end

@implementation SLFEditMoreTableViewCell
{
    UIImageView *_imageV;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下一步"]];
        [self.contentView addSubview:iv];
        _imageV = iv;
        
        kContentViewAdd(self.titleLabel, MyLabel);
        _titleLabel.font = [SLFCommonTools pxFont:30];
        _titleLabel.textColor = [SLFCommonTools colorHex:@"111111"];
        
        kContentViewAdd(self.textField, BaseTextField);
        _textField.font = [SLFCommonTools pxFont:26];
        _textField.textAlignment = NSTextAlignmentRight;
        
        kContentViewAdd(self.contentLabel, MyLabel);
        _contentLabel.font = [SLFCommonTools pxFont:30];
        _contentLabel.textColor = k666666;
        
        kWeakObj(weakObj, self.contentView);
        
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.size.mas_equalTo(CGSizeMake(8, 15));
            make.centerY.equalTo(weakObj);
        }];
        
        [self setupTitleLayout];
    }
    return self;
}

- (void)setupTitleLayout {
    
    kWeakObj(weakObj, self.contentView);
    _imageV.hidden = 1;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakObj);
        make.left.offset(10);
        make.width.mas_equalTo(100);
    }];
}

- (void)setupTextFieldLayout {
    
    kWeakObj(weakObj, self.contentView);
    
    [self setupTitleLayout];
    _contentLabel.hidden = 1;
    _textField.hidden = 0;
    _textField.tag = 129;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.enterType = BaseTextFieldEnterAll;
    [_textField setTextFieldChange:nil];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakObj);
        make.height.mas_equalTo(40);
        make.right.offset(-10);
        make.left.equalTo(_titleLabel.mas_right).offset(5);
    }];
}

- (void)setupContetnLayout {
    
    kWeakObj(weakObj, self.contentView);
    [self setupTitleLayout];
    _imageV.hidden = 0;
    _textField.hidden = 1;
    _textField.tag = 0;
    _contentLabel.hidden = 0;
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakObj);
        make.right.equalTo(_imageV.mas_left).offset(-10);
    }];
}


@end

