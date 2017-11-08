//
//  TimeTableTableViewCell.m
//  XinZiLong
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "TimeTableTableViewCell.h"
#import "QuartzCore/QuartzCore.h"


@interface TimeTableTableViewCell ()
{
        
    NSInteger _labelNum;
}
@end

@implementation TimeTableTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
//    self.date = [[MyLableTinge alloc] initWithFrame:CGRectMake(KHight(10), KHight(20), kScreenW/3, KHight(24))];
//    self.date.font = [UIFont systemFontOfSize:[CommonTools getSize:24]];
//    [self.contentView addSubview:self.date];
    
    self.numberClass = [[MyLabel alloc] initWithFrame:CGRectMake(10, 1, kScreenW/3*2, 36)];
    self.numberClass.font = [UIFont systemFontOfSize:[CommonTools getSize:36]];
    [self.contentView addSubview:self.numberClass];
    
    self.nameClass = [[MyLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.contentView addSubview:_nameClass];
    
    _nameClass.textColor = [CommonTools getColorWithHexString:@"999999"];
    
    self.listView = [[StudentsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-120, 50)];
    [self.contentView addSubview:_listView];
    
    //展开按钮
    UIButton * downBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [downBtn setImage:[UIImage imageNamed:@"箭头-上"] forState:(UIControlStateNormal)];
    [downBtn setImage:[UIImage imageNamed:@"箭头-下"] forState:(UIControlStateSelected)];
    [downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:downBtn];
    _downBtn.contentMode = UIViewContentModeRight;
    self.downBtn = downBtn;
    
    if (!_downBtn.selected) {
        _nameClass.hidden = YES;
        _nameClass.alpha = 0;
        _listView.hidden = YES;
    }
}

-(void)setContentData:(TimeTableDateModel *)contentData {
    if (_contentData != contentData) {
        _contentData = contentData;
        _numberClass.text = contentData.courseName;
        _nameClass.text = contentData.teacher;
        
        _downBtn.frame = CGRectMake(self.contentView.frame.size.width-40, _numberClass.frame.origin.y, 40, 30);
        _nameClass.frame = CGRectMake(10, CGRectGetMaxY(_numberClass.frame)+5, CGRectGetWidth(self.contentView.frame), 30);
        
        
        //    NSArray * date = [model.student componentsSeparatedByString:@";"];
        //    NSLog(@"sub%ld", self.contentView.subviews.count);
        
        CGFloat h = 0;
        
        //    [self.listView removeFromSuperview];
        //    self.listView = nil;
        //    self.listView = [[StudentsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-120, 0)];
        //    [self.contentView addSubview:_listView];
        
        h = [self.listView createList:contentData.student];
//            [self chongZhi:0];
        _listView.frame = CGRectMake(0, CGRectGetMaxY(_nameClass.frame)+5, self.contentView.frame.size.width, _listView.height);
        
        _numberClass.sd_resetNewLayout.topSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).heightIs(20);
        _downBtn.sd_layout.leftSpaceToView(_numberClass, 5).centerYEqualToView(_numberClass).widthIs(60).heightIs(60).rightSpaceToView(self.contentView, 0);
        _nameClass.sd_resetNewLayout.topSpaceToView(_numberClass, 10).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).heightIs(30);
//        _listView.sd_layout.topSpaceToView(_nameClass, 10).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(h);
        
//        [_listView updateLayout];
        self.hightCell = CGRectGetMaxY(_listView.frame);
        NSLog(@"%f<<<<%f", h, CGRectGetMaxY(_listView.frame));
    }
}

-(void)setContent:(TimeTableDateModel *)model {
    
//    _date.text = model.starttime;
    _numberClass.text = model.courseName;
    _nameClass.text = model.teacher;//[NSString stringWithFormat:@"%@教练", model.teacher];

    _downBtn.frame = CGRectMake(self.contentView.frame.size.width-40, _numberClass.frame.origin.y, 40, 30);
    _nameClass.frame = CGRectMake(10, CGRectGetMaxY(_numberClass.frame)+5, CGRectGetWidth(self.contentView.frame), 30);
    

//    NSArray * date = [model.student componentsSeparatedByString:@";"];
//    NSLog(@"sub%ld", self.contentView.subviews.count);
    NSLog(@"%@-----------------", _listView);
    CGFloat h = 0;
//    if (_labelNum != date.count) {
//        for (int i=0; i<date.count; i++) {
//            NSString * str = date[i];
//            float x = JGG_X(0, (kScreenW-120)/3, 1, i, 3);
//            float y = JGG_Y(70, 20, 1, i, 3);
//            MyLabel * label = [[MyLabel alloc] initWithFrame:CGRectMake(x, y, (kScreenW-120)/3, 20)];
//            label.text = str;
//            label.tag = i+50;
//            label.hidden = YES;
//            label.backgroundColor = kColorRandomly;
//            label.textAlignment = NSTextAlignmentCenter;
//            [self.contentView addSubview:label];
//            if (i+1 == date.count) {
//                h = label.frame.origin.y + label.frame.size.height+10;
////                tempLabel = label;
//                _labelNum = date.count;
//            }
//        }
//    }else {
//        _downBtn.selected = NO;
//        [self hiddenLabels:YES];
//    }

//    [self.listView removeFromSuperview];
//    self.listView = nil;
//    self.listView = [[StudentsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-120, 0)];
//    [self.contentView addSubview:_listView];
    
    h = [self.listView createList:model.student];
//    [self chongZhi:0];
    _listView.frame = CGRectMake(0, CGRectGetMaxY(_nameClass.frame)+5, self.contentView.frame.size.width, _listView.height);
    
    _numberClass.sd_resetNewLayout.topSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).heightIs(20);
    _downBtn.sd_layout.leftSpaceToView(_numberClass, 5).centerYEqualToView(_numberClass).widthIs(60).heightIs(60).rightSpaceToView(self.contentView, 0);
    _nameClass.sd_resetNewLayout.topSpaceToView(_numberClass, 10).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).heightIs(30);
    
    self.hightCell = CGRectGetMaxY(_listView.frame);
}

-(void)downBtnClick:(UIButton *)btn {
    
    if ([_delgate respondsToSelector:@selector(infoCell:)]) {
        btn.selected = !btn.selected;
        [self chongZhi:0];
        [_delgate infoCell:self];
    }
    
}

-(void)changeBtn:(BOOL)change {
    _downBtn.selected = change;
    if (self.downBtn.selected) {
        _nameClass.hidden = !self.downBtn.selected;
        _listView.hidden = !self.downBtn.selected;
        [UIView animateWithDuration:0.3 animations:^{
            _nameClass.alpha = 1;
            _listView.alpha = 1;
        }];
    }else {
        _nameClass.alpha = 0;
        _listView.alpha = 0;
        _nameClass.hidden = !self.downBtn.selected;
        _listView.hidden = !self.downBtn.selected;
    }}

-(void)chongZhi:(BOOL)isReLoadData {
    if (isReLoadData) {
        self.downBtn.selected = NO;
        _nameClass.hidden = NO;
        _listView.hidden = NO;
        _nameClass.alpha = 0;
        _listView.alpha = 0;
        return;
    }
    if (self.downBtn.selected) {
        _nameClass.hidden = !self.downBtn.selected;
        _listView.hidden = !self.downBtn.selected;
        [UIView animateWithDuration:0.3 animations:^{
            _nameClass.alpha = 1;
            _listView.alpha = 1;
        }];
    }else {
        _nameClass.alpha = 0;
        _listView.alpha = 0;
        _nameClass.hidden = !self.downBtn.selected;
        _listView.hidden = !self.downBtn.selected;
    }
}

-(void)hiddenLabels:(BOOL)hidden {
    for (int i=0; i<_labelNum; i++) {
        MyLabel * label = [self.contentView viewWithTag:i+50];
        label.hidden = hidden;
    }
}

//- (void)draw{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.contentView.bounds];
//    [shapeLayer setPosition:self.contentView.center];
//    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//    
//    // 设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:[[CommonTools getColorWithHexString:@"CCCCCC"] CGColor]];
//    
//    // 3.0f设置虚线的宽度
//    [shapeLayer setLineWidth:1.0f];
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    
//    // 3=线的宽度 1=每条线的间距
//    [shapeLayer setLineDashPattern:
//     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
//      [NSNumber numberWithInt:3],nil]];
//    
//    // Setup the path
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, KHight(15), _h + _listView.centerY_sd-10);
//    CGPathAddLineToPoint(path, NULL, kScreenW-KHight(120), _h + _listView.centerY_sd-10);
//    
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    
//    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
//    [[self layer] addSublayer:shapeLayer];
//
//}
@end
