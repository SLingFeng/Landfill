//
//  BaseTextField.m
//  NaHu
//
//  Created by SADF on 16/12/14.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "BaseTextField.h"

@interface BaseTextField ()<UITextFieldDelegate>

@end

@implementation BaseTextField

-(void)awakeFromNib {
    [super awakeFromNib];
    [self set];
}

-(instancetype)init {
    if (self == [super init]) {
        [self set];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self set];
    }
    return self;
}

-(void)set {
    self.delegate = self;
    [self addTarget:self action:@selector(returnKeyClick:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
//    self addTarget:self action:@selector(shouldRrturnKeyClick:) forControlEvents:(UIControlEvent)
}

-(void)returnKeyClick:(BaseTextField *)tf {
    if (self.returnKeyClick) {
        self.returnKeyClick(tf);
    }
}

-(void)setEnterNumber:(NSInteger)enterNumber {
    if (_enterNumber != enterNumber) {
        _enterNumber = enterNumber;
        if (self) {
            [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:(UIControlEventAllEditingEvents)];
        }
    }
}

-(void)TextFieldChange:(UITextField *)textField {
    if (textField == self) {
        NSString *aString = textField.text;
        UITextRange *selectedRange = [textField markedTextRange];
        // 獲取被選取的文字區域（在打注音時，還沒選字以前注音會被選起來）
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 沒有被選取的字才限制文字的輸入字數
        if (!position) {
            if (aString.length > _enterNumber) {
                textField.text = [aString substringToIndex:_enterNumber];
            }
        }
        if (self.textFieldChange) {
            self.textFieldChange(textField.text);
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
