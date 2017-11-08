//
//  SLFFilterView.m
//
//  Created by 孙凌锋 on 2017/3/23.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import "SLFFilterView.h"
#import "SLFFilterTableViewCell.h"

@interface SLFFilterView () <UITableViewDelegate, UITableViewDataSource> {
    CGFloat _selectW;
    YGBFiterDemandModel *_filter;
}
@property (nonatomic, retain) MyTableView *tableView;
@property (nonatomic, retain) NSMutableArray *isOpenArr;
@property (nonatomic, retain) NSMutableArray *sectionSelectArr;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) NSMutableArray *upDataArr;
@property (nonatomic, assign) BOOL isWho;
@property (nonatomic, retain) YGBFiterDemandModel *filter;
@property (nonatomic, copy) NSString *monent;
@end

@implementation SLFFilterView

singleton_implemetntion(FilterView)

- (instancetype)init {
    if (self = [super init]) {
        
        UIView * bView = [[UIView alloc] init];
        [self addSubview:bView];
        bView.backgroundColor = [SLFCommonTools colorHex:@"000000" alpha:0.6];
        [bView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)]];
        [bView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

        self.filter = [[YGBFiterDemandModel alloc] init];
        
        self.tableView = [[MyTableView alloc] initWithFrame:CGRectMake(kScreenW-300, 64, 300, kScreenH-64-44) style:(UITableViewStylePlain)];
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[SLFFilterTableViewCell class] forCellReuseIdentifier:@"FilterTableViewCell"];
        [SLFCommonTools tableCellSeparator:self.tableView left:0 right:0];
        
        self.upDataArr = [NSMutableArray arrayWithCapacity:4];
        self.isOpenArr = [NSMutableArray arrayWithArray:@[@NO, @NO, @NO, @NO]];
        self.sectionSelectArr = [NSMutableArray arrayWithArray:@[@-1, @-1, @-1, @-1]];
        _selectW = 300;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        kWeakSelf(weakSelf);
        
        ThemeButton * resetBtn = [[ThemeButton alloc] initWithFontSize:32/2 fontColor:@"ffffff" fontText:@"重置"];
        [resetBtn setBackgroundColor:[SLFCommonTools colorHex:@"ffa5a5"]];
        [self addSubview:resetBtn];
        [resetBtn setOnClickBlock:^(ThemeButton *seder) {
            [weakSelf reset];
            [weakSelf cancelTap];
            if (weakSelf.toFilter) {
                weakSelf.toFilter(nil);
            }
        }];
        
        ThemeButton * confimBtn = [[ThemeButton alloc] initWithFontSize:32/2 fontColor:@"ffffff" fontText:@"确认"];
        [confimBtn setBackgroundColor:kFF0000];
        [self addSubview:confimBtn];
        [confimBtn setOnClickBlock:^(ThemeButton *sender) {
            [weakSelf cancelTap];
            if (weakSelf.toFilter) {
                weakSelf.toFilter(weakSelf.filter);
            }
        }];
        
        kWeakObj(weakTable, _tableView);
        
        [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakTable.mas_bottom).offset(44);
            make.left.equalTo(weakTable.mas_left).offset(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(44);
        }];
        
        [confimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakTable.mas_bottom).offset(44);
            make.right.equalTo(weakTable.mas_right).offset(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(44);
        }];
        self.hidden = 1;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame = kScreen;
    [super setFrame:frame];
}

- (void)reset {
    _monent = nil;
    self.filter = nil;
    self.filter = [[YGBFiterDemandModel alloc] init];
    
    self.isOpenArr = nil;
    self.isOpenArr = [NSMutableArray arrayWithArray:@[@NO, @NO, @NO, @NO]];
    
    self.sectionSelectArr = nil;
    self.sectionSelectArr = [NSMutableArray arrayWithArray:@[@-1, @-1, @-1, @-1]];
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:4];
        NSMutableArray * arr;
        NSMutableArray * arr1;
        
        if (_isWho) {//用工
            for (int i=0; i<4; i++) {
                if (i == 0) {
                    arr = [NSMutableArray arrayWithCapacity:3];
                    arr1 = [NSMutableArray arrayWithCapacity:3];
                    for (YGBGzdjlistModel *temp in [YGBAppConfigModel shareclass].gzdjlist) {
                        [arr addObject:temp.ygblcname];
                        [arr1 addObject:temp.ygblcid];
                    }
                    [_dataArr addObject:arr];
                    [_upDataArr addObject:arr1];
                }else if (i == 1) {
                    [_dataArr addObject:@[@"全部", @"1人", @"2人", @"3人", @"4人", @"5人及以上"]];
                    [_upDataArr addObject:@[@"0", @"1", @"2", @"3", @"4", @"5"]];
                }else if (i == 2) {
                    arr = [NSMutableArray arrayWithCapacity:3];
                    arr1 = [NSMutableArray arrayWithCapacity:3];
                    
                    for (YGBDatadictionaryModel *dc in [YGBAppConfigModel shareclass].datadictionary) {
                        if ([dc.zlmc isEqualToString:@"公里数"]) {
                            for (int i=0; i<dc.dmlist.count; i++) {
                                YGBDatadictionaryModel * dcm = dc.dmlist[i];
                                [arr addObject:dcm.dmmc];
                                [arr1 addObject:dcm.dm];
                            }
                        }
                    }
                    [_dataArr addObject:arr];
                    [_upDataArr addObject:arr1];
                }else {
                    [_dataArr addObject:@[@"全部",@"1天", @"2天", @"3天", @"4天", @"5天及以上"]];
                    [_upDataArr addObject:@[@"0", @"1", @"2", @"3", @"4", @"5"]];
                }
            }
        }else {//家教
            for (int i=0; i<4; i++) {
                if (i == 0) {
                    
                    arr = [NSMutableArray arrayWithCapacity:3];
                    arr1 = [NSMutableArray arrayWithCapacity:3];
                    
                    for (YGBKmlistModel *temp in [YGBAppConfigModel shareclass].kmlist) {
                        [arr addObject:temp.classname];
                        [arr1 addObject:temp.classcd];
                    }
                    [_dataArr addObject:arr];
                    [_upDataArr addObject:arr1];
                }else if (i == 1) {
                    
                    arr = [NSMutableArray arrayWithCapacity:3];
                    arr1 = [NSMutableArray arrayWithCapacity:3];
                    
                    for (YGBKmlistModel *temp in [YGBAppConfigModel shareclass].kmlist) {
                        for (YGBKmlistSubjectModel *sub in temp.subject) {
                            [arr addObject:sub.subjectname];
                            [arr1 addObject:sub.subjectcd];
                        }
                    }
                    [_dataArr addObject:arr];
                    [_upDataArr addObject:arr1];
                }else if (i == 2) {
                    arr = [NSMutableArray arrayWithCapacity:3];
                    arr1 = [NSMutableArray arrayWithCapacity:3];
                    
                    for (YGBDatadictionaryModel *dc in [YGBAppConfigModel shareclass].datadictionary) {
                        if ([dc.zlmc isEqualToString:@"公里数"]) {
                            for (int i=0; i<dc.dmlist.count; i++) {
                                YGBDatadictionaryModel * dcm = dc.dmlist[i];
                                [arr addObject:dcm.dmmc];
                                [arr1 addObject:dcm.dm];
                            }
                        }
                    }
                    [_dataArr addObject:arr];
                    [_upDataArr addObject:arr1];
                }else {
                    [_dataArr addObject:@[@"全部",@"1天", @"2天", @"3天", @"4天", @"5天及以上"]];
                    [_upDataArr addObject:@[@"0", @"1", @"2", @"3", @"4", @"5"]];
                }
            }
        }
        
        
        
    }
    return _dataArr;
}

-(void)setMonent:(NSString *)monent {
    if (_monent != monent) {
        _monent = monent;
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:3];
        NSMutableArray * arr1 = [NSMutableArray arrayWithCapacity:3];
        
        for (YGBKmlistModel *temp in [YGBAppConfigModel shareclass].kmlist) {
            if ([_monent isEqualToString:temp.classname]) {
                for (YGBKmlistSubjectModel *sub in temp.subject) {
                    [arr addObject:sub.subjectname];
                    [arr1 addObject:sub.subjectcd];
                }
            }
            [_dataArr replaceObjectAtIndex:1 withObject:arr];
            [_upDataArr replaceObjectAtIndex:1 withObject:arr1];
        }
        [self.tableView reloadData];
    }
}

#pragma mrak -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_isOpenArr[section] boolValue]) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLFFilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTableViewCell"];
    
    [cell setupBtn:self.dataArr[indexPath.section] toSelectIndex:[_sectionSelectArr[indexPath.section] intValue]];
    if ([_isOpenArr[indexPath.section] boolValue]) {
        cell.contentView.hidden = 0;
    }else {
        cell.contentView.hidden = 1;
    }
    
    kWeakSelf(weakSelf);
    kWeakObj(weakObj, _sectionSelectArr);
    NSInteger section = indexPath.section;
    [cell setSelectorForIndexBlock:^(NSInteger index) {
        [weakObj replaceObjectAtIndex:indexPath.section withObject:@(index)];
        [weakSelf filterT:[NSIndexPath indexPathForRow:index inSection:section]];
        [tableView reloadData];
     }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([_isOpenArr[indexPath.section] boolValue]) {
        return [self.tableView cellHeightForIndexPath:indexPath cellContentViewWidth:kScreenW-300 tableView:tableView];
//    }
//    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSArray *titlesArr = _isWho?@[@"工种", @"出工人数", @"附近", @"用工天数"]:@[@"年级", @"科目", @"附近", @"上课天数"];
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = kFFFFFF;
    view.tag = section + 123;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldOnClick:)]];
    MyLabel *label = [[MyLabel alloc] initWithFontSize:30/2 fontColor:@"666666" setText:titlesArr[section]];
    [view addSubview:label];
    
    MyLabel *rightlabel = [[MyLabel alloc] initWithFontSize:26/2 fontColor:@"ff0000" setText:@""];
    rightlabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:rightlabel];
    
    ThemeButton * jtBtn = [[ThemeButton alloc] init];
    [jtBtn setImage:[UIImage imageNamed:@"list_icon_down"] forState:(UIControlStateNormal)];
    [jtBtn setImage:[UIImage imageNamed:@"list_icon_up"] forState:(UIControlStateSelected)];
    jtBtn.tag = section + 10;
    jtBtn.selected = [_isOpenArr[section] boolValue];
    [view addSubview:jtBtn];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.offset(10);
    }];
    
    [jtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.offset(-10);
        make.size.mas_equalTo(CGSizeMake(15, 7.5));
    }];
    
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(jtBtn.mas_left).offset(-10);
    }];
    
    NSInteger index = [_sectionSelectArr[section] integerValue];
    if (index != -1) {
        rightlabel.text = _dataArr[section][index];
        if (_isWho == NO) {
            if (section == 0) {
                self.monent = _dataArr[section][index];
            }
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 37;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (void)foldOnClick:(UITapGestureRecognizer *)sender {
    if (_isWho == NO) {
        if (sender.view.tag - 123 == 1) {
            if (kStringIsEmpty(_monent)) {
                [SLFHUD showHint:@"请选择年级"];
                return;
            }
        }
    }
    
    ThemeButton * btn = [sender.view viewWithTag:sender.view.tag - 123 + 10];
    btn.selected = !btn.selected;
    [_isOpenArr replaceObjectAtIndex:btn.tag-10 withObject:@(btn.selected)];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sender.view.tag - 123]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.view.tag - 123] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [self.tableView reloadData];
}

- (void)filterT:(NSIndexPath *)indexPath {
    NSString * str = _upDataArr[indexPath.section][indexPath.row];
    if (!_isWho) {
        switch (indexPath.section) {
            case 0:{
                _filter.moment = str;
            }
                break;
            case 1:{
                _filter.subject = str;
            }
                break;
            case 2:{
                _filter.distance = str;
            }
                break;
            case 3:{
                _filter.days = str;
            }
                break;
            default:
                break;
        }
    }else {
        switch (indexPath.section) {
            case 0:{
                _filter.kind = str;
            }
                break;
            case 1:{
                _filter.workers = str;
            }
                break;
            case 2:{
                _filter.distance = str;
            }
                break;
            case 3:{
                _filter.days = str;
            }
                break;
            default:
                break;
        }
    }
    
}

- (void)setIsWho:(BOOL)isWho {
    if (_isWho != isWho) {
        _isWho = isWho;
        [self reset];
        self.dataArr = nil;
        [self.tableView reloadData];
    }
}

- (void)hiddenView {
    [self cancelTap];
}

-(void)show {
    if ([[GVUserDefaults standardUserDefaults] isUserType] == 2 || [[GVUserDefaults standardUserDefaults] isUserType] == 1) {//用工
        self.isWho = 1;
    }else if ([[GVUserDefaults standardUserDefaults] isUserType] == 4 || [[GVUserDefaults standardUserDefaults] isUserType] == 3) {//家教
        self.isWho = 0;
    }
    
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, self.tableView);
    weakSelf.hidden = 0;
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.alpha = 1;
        weakOBJ.frame = CGRectMake(kScreenW-_selectW, 64, _selectW, kScreenH-64-44);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, self.tableView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.alpha = 0;
        weakOBJ.frame = CGRectMake(kScreenW, 64, _selectW, kScreenH-64-44);
    } completion:^(BOOL finished) {
        weakSelf.hidden = 1;
//        [weakSelf removeFromSuperview];
    }];
}

@end
