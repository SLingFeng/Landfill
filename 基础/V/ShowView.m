//
//  ShowView.m
//  NaHu
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView
-(instancetype)init {
    if (self == [super init]) {
        [self setView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setView {
    self.backgroundColor = kCOLOR_WITH_RGBA(0, 0, 0, 0.5);
    self.alpha = 0;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
}


-(void)show {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _bottomView);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-_bottomHeight, kScreenW, _bottomHeight);
    }];
}

-(void)cancelTap {
    kWEAKSELF(weakSelf);
    kWEAKOBJ(weakOBJ, _bottomView);
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+_bottomHeight, kScreenW, _bottomHeight);
    } completion:^(BOOL finished) {
        [weakOBJ removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}
@end
