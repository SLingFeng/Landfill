//
//  ChoiceView.m
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/30.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "ChoiceView.h"

@implementation ChoiceView {
    NSMutableArray *_dataArr;
    //0单选 1多选第一个和其他不能全选  2多选
    NSInteger _isMultiple;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.btnArr = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}


- (void)setupSubView:(NSMutableArray *)arr multiple:(NSInteger)multiple {
//    for (UIView * view in self.subviews) {
//        [view removeFromSuperview];
//    }
    _isMultiple = multiple;
    kWeakSelf(weakSelf);
    _dataArr = arr;
//    if ([str isEqualToString:@"kGVUser.projectData"]) {
//        _dic = kGVUser.projectData;
//    }else {
//        _dic = kGVUser.mapData[str];
//    }
    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:9];
//    for (FY_ConfigAddHouseInfoModel *obj in arr) {
//        [idArr addObject:obj.type_id];
//        [value addObject:obj.type_value];
//    }
    
    NSInteger needNum = _dataArr.count > self.btnArr.count ? _dataArr.count - self.btnArr.count : 0;
    
    for (int x=0; x<needNum; x++) {
        
        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k333333 fontText:@""];
        btn.titleLabel.numberOfLines = 0;
        [self addSubview:btn];
        btn.hidden = 1;
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
//        if (multiple) {
            [btn setImage:[UIImage imageNamed:@"choice_unclicked_icon"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"choice_clicked_icon"] forState:(UIControlStateSelected)];
//        }else {
//            [btn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:(UIControlStateNormal)];
//            [btn setImage:[UIImage imageNamed:@"radio_selected"] forState:(UIControlStateSelected)];
//        }
        [self.btnArr addObject:btn];
    }
    
    for (MyButton *btn in self.btnArr) {
        btn.hidden = YES;
    }
    
    UIView *lastView;

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
        FY_ConfigAddHouseInfoModel *obj = arr[i];
        NSString *title = obj.type_value;

        MyButton *btn = self.btnArr[i];
        [btn setTitle:title forState:(UIControlStateNormal)];

        btn.hidden = 0;
        btn.value = title;
        btn.key = obj.type_id;
        btn.tag = i + 10;
        //        obj.tag = i + (1000 * self.row);
        //        [btn setBackgroundColor:RGBCOLOR(245, 245, 245)];
        //        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        //        [btn setTitleColor:kBtnBC forState:(UIControlStateSelected)];
        
        btn.onClickBlock = ^(MyButton *sender) {
            if (multiple == 1) {
                if (sender.tag == 10) {
                    for (MyButton * btn in weakSelf.btnArr) {
                        btn.selected = 0;
                    }
                    sender.selected = YES;
                }else {
                    MyButton *temp = weakSelf.btnArr.firstObject;
                    temp.selected = NO;
                    sender.selected = !sender.selected;
                }
            }else if (multiple == 2) {
                sender.selected = !sender.selected;
            }else {
                for (MyButton * btn in weakSelf.btnArr) {
                    if (btn == sender) {
                        btn.selected = !btn.selected;
                    } else{
                        btn.selected = 0;
                    }
                }
            }
           
            if (weakSelf.selectIDBlock) {
                weakSelf.selectIDBlock([weakSelf getSelectID]);
            }
            //            [weakSelf btnClick:sender];
        };
        
        CGFloat btnW = [SLFCommonTools textSize:title font:[SLFCommonTools pxFont:26]].width + 30;
        CGFloat btnH = [SLFCommonTools textHight:title font:[SLFCommonTools pxFont:26].pointSize width:btnW];
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self, kMainSpace).topSpaceToView(self, 8).heightIs(btnH).widthIs(btnW);
        }else {
            
            if (kScreenW - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(btnH).widthIs(btnW);
            }else {
                btn.sd_layout.leftSpaceToView(self, kMainSpace).topSpaceToView(lastView, 5).heightIs(btnH).widthIs(btnW);
               
            }
        }
         [btn updateLayout];
        lastView = btn;
        
    }
    [self setupAutoHeightWithBottomView:lastView bottomMargin:0];
}
//单选
- (void)setupRadioSubView:(NSMutableArray *)str {
    [self setupSubView:str multiple:0];
}
//多选
- (void)setupMultipleSubView:(NSMutableArray *)str {
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
            FY_ConfigAddHouseInfoModel *model = _dataArr[btn.tag - 10];
            [ids appendString:[NSString stringWithFormat:@"%@%@", [ids hasSuffix:@","]?@"":ids.length==0?@"":@",", model.type_id]];
        }
    }

    return ids;
}

@end
