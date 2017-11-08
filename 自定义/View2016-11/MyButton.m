//
//  MyButton.m
//  RenCaiKu
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

-(instancetype)init {
    if (self == [super init]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setupButton];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

-(void)setupButton {
    
    [self setTitleColor:kCOLOR_WITH(51, 51, 51) forState:(UIControlStateNormal)];
    //    圆角
    self.layer.cornerRadius = 3;
    [self setBackgroundColor:[CommonTools getBackgroundColor]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
