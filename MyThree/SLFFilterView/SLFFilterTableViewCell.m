//
//  SLFFilterTableViewCell.m
//  YGB
//
//  Created by 孙凌锋 on 2017/3/23.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import "SLFFilterTableViewCell.h"

#define kFilterW 300

@implementation SLFFilterTableViewCell {
    NSMutableArray *_btnArr;
    NSMutableArray *_dataArr;
    
    ThemeButton *_oldBtn;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _btnArr = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)setupBtn:(NSArray *)strArr toSelectIndex:(int)sIndex {
    
    if (strArr.count == 0) {
        return;
    }
    
    NSInteger needBtns = strArr.count > _btnArr.count ? (strArr.count - _btnArr.count) : 0;
    //创建缺少的btn
    for (int i=0; i<needBtns; i++) {
        ThemeButton * btn = [[ThemeButton alloc] initWithFontSize:26/2 fontColor:@"111111" fontText:@""];
        [btn setupCornerRadius:kMainCornerRadius borderWidth:0 border:nil];
        [btn setTitleColor:k111111 forState:(UIControlStateNormal)];
        [btn setTitleColor:kFFFFFF forState:(UIControlStateSelected)];
        [btn setBackgroundColor:kF2F2F2];
        [btn addTarget:self action:@selector(selectorBtnOnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i + 110;
        btn.hidden = 1;
        [self.contentView addSubview:btn];
        [_btnArr addObject:btn];
    }
    
    if (_btnArr.count != 0) {
        [_btnArr enumerateObjectsUsingBlock:^(ThemeButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = 1;
            obj.frame = CGRectZero;
        }];
    }
    
    ThemeButton *lastBtn;
    for (int i = 0; i<strArr.count; i++) {
        ThemeButton * btn = _btnArr[i];
        btn.hidden = 0;
        [btn setTitle:strArr[i] forState:(UIControlStateNormal)];
        
        if (sIndex != -1) {
            if (sIndex == i) {
                _oldBtn = btn;
                [btn setBackgroundColor:kFF0000];
                btn.selected = 1;
            }
        }else {
            [btn setBackgroundColor:kF2F2F2];
            btn.selected = NO;
        }

        CGFloat w = (kFilterW - 40)/3;
        CGFloat x = JGG_X(10, w, 10, i, 3);
        CGFloat y = JGG_Y(10, 30, 10, i, 3);
        btn.frame = CGRectMake(x, y, w, 30);
        lastBtn = btn;
    }
    
    
    
    [self setupAutoHeightWithBottomView:lastBtn bottomMargin:10];
    
}

- (void)selectorBtnOnClick:(ThemeButton *)btn {
    _oldBtn.selected = NO;
    [_oldBtn setBackgroundColor:kF2F2F2];
    [btn setBackgroundColor:kFF0000];
    btn.selected = YES;
    
    if (self.selectorForIndexBlock) {
        self.selectorForIndexBlock(btn.tag - 110);
    }
    
    _oldBtn = btn;
}

@end
