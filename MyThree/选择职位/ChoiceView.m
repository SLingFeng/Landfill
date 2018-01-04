//
//  ChoiceView.m
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/30.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "ChoiceView.h"

@implementation ChoiceView {
    NSDictionary *_dic;
    BOOL _isMultiple;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.btnArr = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}


- (void)setupSubView:(NSString *)str multiple:(BOOL)multiple {
//    for (UIView * view in self.subviews) {
//        [view removeFromSuperview];
//    }
    _isMultiple = multiple;
    kWeakSelf(weakSelf);
    
    if ([str isEqualToString:@"kGVUser.projectData"]) {
        _dic = kGVUser.projectData;
    }else {
        _dic = kGVUser.mapData[str];
    }
    
    NSInteger needNum = _dic.allKeys.count > self.btnArr.count ? _dic.allKeys.count - self.btnArr.count : 0;
    
    for (int x=0; x<needNum; x++) {
        
        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k333333 fontText:@""];
        [self addSubview:btn];
        btn.hidden = 1;
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        if (multiple) {
            [btn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"checkbox_selected"] forState:(UIControlStateSelected)];
        }else {
            [btn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"radio_selected"] forState:(UIControlStateSelected)];
        }
        [self.btnArr addObject:btn];
    }
    
    UIView *lastView;
    NSArray *arr = _dic.allValues;
    for (int i=0; i<arr.count; i++) {
        
        //        JMFlowTreeDataUserListModel * obj = model.userList[i];
//        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k333333 fontText:title];
//        [self addSubview:btn];
//
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
//        if (multiple) {
//            [btn setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:(UIControlStateNormal)];
//            [btn setImage:[UIImage imageNamed:@"checkbox_selected"] forState:(UIControlStateSelected)];
//        }else {
//            [btn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:(UIControlStateNormal)];
//            [btn setImage:[UIImage imageNamed:@"radio_selected"] forState:(UIControlStateSelected)];
//        }
        NSString *title = arr[i];

        MyButton *btn = self.btnArr[i];
        [btn setTitle:title forState:(UIControlStateNormal)];

        btn.hidden = 0;
        btn.value = title;
        btn.key = _dic.allKeys[i];
        btn.tag = i + 10;
        //        obj.tag = i + (1000 * self.row);
        //        [btn setBackgroundColor:RGBCOLOR(245, 245, 245)];
        //        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        //        [btn setTitleColor:kBtnBC forState:(UIControlStateSelected)];
        
        btn.onClickBlock = ^(MyButton *sender) {
            if (multiple) {
                
                
            }else {
                
                for (MyButton * btn in weakSelf.btnArr) {
                    btn.selected = 0;
                }
            }
            sender.selected = !sender.selected;
            
            if (weakSelf.selectIDBlock) {
                weakSelf.selectIDBlock([weakSelf getSelectID]);
            }
            //            [weakSelf btnClick:sender];
        };
        
        CGFloat btnW = [SLFCommonTools textSize:title font:[SLFCommonTools pxFont:26]].width + 26;
        
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self, kMainSpace).topSpaceToView(self, 8).heightIs(35).widthIs(btnW);
            [btn updateLayout];
        }else {
            
            if (kScreenW - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                btn.sd_layout.leftSpaceToView(self, kMainSpace).topSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }
        }
        
        lastView = btn;
        
    }
    [self setupAutoHeightWithBottomView:lastView bottomMargin:0];
}
//单选
- (void)setupRadioSubView:(NSString *)str {
    [self setupSubView:str multiple:0];
}
//多选
- (void)setupMultipleSubView:(NSString *)str {
    [self setupSubView:str multiple:1];
}
//设置选中状态
- (void)setupSelectStatus:(NSString *)ids {
    
    NSArray *arr = [ids componentsSeparatedByString:@","];
    for (MyButton *btn in self.btnArr) {
        btn.selected = 0;
        for (NSString *str in arr) {
            if ([str isEqualToString:btn.key]) {
                btn.selected = 1;
            }
        }
        
    }
}

- (NSString *)getSelectID {
    NSMutableString *ids = [NSMutableString string];
    for (MyButton * btn in self.btnArr) {
        if (btn.isSelected) {
            [ids appendString:[NSString stringWithFormat:@"%@%@", [ids hasSuffix:@","]?@"":ids.length==0?@"":@",", _dic.allKeys[btn.tag - 10]]];
        }
    }
    
    return ids;
}

@end
