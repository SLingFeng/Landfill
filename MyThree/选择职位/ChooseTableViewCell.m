//
//  ChooseTableViewCell
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/29.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "ChooseTableViewCell.h"

@implementation ChooseTableViewCell {
    NSDictionary *_dic;
    BOOL _isMultiple;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLab = [[MyLabel alloc]initWithFontSize:30 fontColor:k333333 setText:@""];
        [self.contentView addSubview:_titleLab];
    
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
        }];
        
        self.btnArr = [NSMutableArray arrayWithCapacity:10];
        
    }
    return self;
}
- (void)showButton:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@","];
    UIView *lastView;
    for (int i = 0; i < arr.count; i++) {
        MyButton *btn = [[MyButton alloc] initWithFontSize:28 fontColor:[SLFCommonTools colorHex:@"4aabf3"] fontText:@""];;
        [self.contentView addSubview:btn];
        NSString *title = arr[i];
        [btn setTitle:title forState:(UIControlStateNormal)];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundColor:[UIColor clearColor]];
        kViewBorderRadius(btn, 5, 1, [SLFCommonTools colorHex:@"4aabf3"]);
      
        CGFloat btnW = [SLFCommonTools textSize:title font:[SLFCommonTools pxFont:26]].width + 30;
        
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self.contentView, kMainSpace).topSpaceToView(self.titleLab, 10).heightIs(35).widthIs(btnW);
            [btn updateLayout];
        }else {
            
            if (kScreenW - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                btn.sd_layout.leftSpaceToView(self.contentView, kMainSpace).topSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }
        }
        lastView = btn;
    }
    [self setupAutoHeightWithBottomView:lastView bottomMargin:kMainSpace];
}

- (void)creatButton:(NSString *)str multiple:(BOOL)multiple {
    kWeakSelf(weakSelf);
    _isMultiple = multiple;
    if ([str isEqualToString:@"kGVUser.projectData"]) {
        _dic = kGVUser.projectData;
    }else {
        _dic = kGVUser.mapData[str];
    }
    NSInteger needNum = _dic.allKeys.count > self.btnArr.count ? _dic.allKeys.count - self.btnArr.count : 0;
    
    for (int x=0; x<needNum; x++) {
        MyButton *btn = [[MyButton alloc] initWithFontSize:28 fontColor:k999999 fontText:@""];
        [self.contentView addSubview:btn];
        btn.hidden = 1;
        [btn setBackgroundColor:RGBCOLOR(245, 245, 245)];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        [btn setTitleColor:[SLFCommonTools colorHex:@"4aabf3"] forState:UIControlStateSelected];
        [btn setTitleColor:k999999 forState:UIControlStateNormal];
        
        [self.btnArr addObject:btn];
    }
    
    UIView *lastView;
    for (int i = 0; i < _dic.allValues.count; i++) {
        MyButton *btn = self.btnArr[i];
        NSString *title = _dic.allValues[i];
        [btn setTitle:title forState:(UIControlStateNormal)];
        btn.tag = i + 10;
        btn.hidden = 0;
        btn.value = title;
        btn.key = _dic.allKeys[i];
        btn.onClickBlock = ^(MyButton *sender) {
            if (multiple) {
                
                
            }else {
                for (MyButton *bb in weakSelf.btnArr) {
                    bb.selected = NO;
                    [bb setBackgroundColor:RGBCOLOR(245, 245, 245)];
                    kViewBorderRadius(bb, 5, 0, [UIColor clearColor]);
                }
            }
            sender.selected = !sender.selected;
            
            [sender setBackgroundColor:sender.selected?[UIColor clearColor]:RGBCOLOR(245, 245, 245)];
            
            kViewBorderRadius(sender, 5, sender.selected?1:0, [SLFCommonTools colorHex:@"4aabf3"]);
            
            if (weakSelf.selectIDBlock) {
                weakSelf.selectIDBlock([weakSelf getSelectID]);
            }
        };
        CGFloat btnW = [SLFCommonTools textSize:title font:[SLFCommonTools pxFont:26]].width + 30;
        
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self.contentView, kMainSpace).topSpaceToView(self.titleLab, 10).heightIs(35).widthIs(btnW);
            [btn updateLayout];
        }else {
        
            if (kScreenW - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                btn.sd_layout.leftSpaceToView(self.contentView, kMainSpace).topSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }
        }
        lastView = btn;
    }
     [self setupAutoHeightWithBottomView:lastView bottomMargin:kMainSpace];
}

//设置选中状态
- (void)setupSelectStatus:(NSString *)ids {
    
    NSArray *arr = [ids componentsSeparatedByString:@","];
    for (MyButton *btn in self.btnArr) {
        btn.selected = 0;
        [btn setBackgroundColor:RGBCOLOR(245, 245, 245)];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        for (NSString *str in arr) {
            if ([str isEqualToString:btn.key]) {
                btn.selected = 1;
                kViewBorderRadius(btn, 5, 1, [SLFCommonTools colorHex:@"4aabf3"]);
                [btn setBackgroundColor:[UIColor clearColor]];
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
