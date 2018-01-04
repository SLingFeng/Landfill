//
//  ExpectWorkViewController.m
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/10/24.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "ExpectWorkViewController.h"


@interface ExpectWorkViewController ()


@property (nonatomic, retain) UIScrollView *subScrollView;
//当前现实btn
@property (nonatomic, retain) NSMutableArray *btnArr;

@property (nonatomic, retain) LYCommonOfficeModel *data;

@property (nonatomic, retain) NSMutableArray *selectBtnArr;

//选择
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, retain) UIView *selectView;

@end

@implementation ExpectWorkViewController
- (instancetype)initWithtitle:(NSString *)title{
    if (self = [super init]) {
     [self setNavigationTitle:title];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [CommonTools colorHex:@"f7f7fa"];
    
    
    
    self.btnArr = [NSMutableArray arrayWithCapacity:10];
    
    self.selectBtnArr = [NSMutableArray arrayWithCapacity:3];
    if (self.selectDataArr == nil) {
        self.selectDataArr = [NSMutableArray arrayWithCapacity:3];
    }
    
    self.subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(120, 0, kScreenW-120, kScreenH)];
    [self.view addSubview:self.subScrollView];
    self.subScrollView.backgroundColor = [UIColor whiteColor];
    
    if (self.isClass) {
        self.subScrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    }else {
        
        [self neededTableViewStyle:(UITableViewStylePlain)];
        self.tableView.backgroundColor = [CommonTools colorHex:@"f7f7fa"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.width.mas_equalTo(120);
            make.bottom.offset(0);
        }];
    }
    
    
    
//    [self.subScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(64);
//    }];
    
    
    [self getData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBlock)];
    
//    [self cearteHeadView];
}

- (void)clickBlock {
    if (self.workList) {
        self.workList(self.selectDataArr);
    }
    
    NSMutableString *names = [NSMutableString string];
    NSMutableString *ids = [NSMutableString string];
    if (self.isClass) {
        for (LYCommonOfficeOfficeListModel *obj in self.selectDataArr) {
            [names appendString:[NSString stringWithFormat:@"%@%@", [names hasSuffix:@","]?@"":names.length==0?@"":@",", obj.name]];
            
            [ids appendString:[NSString stringWithFormat:@"%@%@", [ids hasSuffix:@","]?@"":ids.length==0?@"":@",", obj.id]];
        }
    }else {
        for (LYCommonOfficeUserListModel *obj in self.selectDataArr) {
            [names appendString:[NSString stringWithFormat:@"%@%@", [names hasSuffix:@","]?@"":names.length==0?@"":@",", obj.name]];
            
            [ids appendString:[NSString stringWithFormat:@"%@%@", [ids hasSuffix:@","]?@"":ids.length==0?@"":@",", obj.employeeId]];
        }
    }
    if (self.typeList) {
        self.typeList(names, ids, self.selectDataArr);
    }
    [self.navigationController popViewControllerAnimated:1];
}

- (void)getData {
//    if (kStringIsEmpty(self.itemInfoId)) {
//        self.itemInfoId = @"0";
//    }
    kWEAKSELF(weakSelf);

    if (self.expectType == ExpectNormal) {
//        [RequestPost apiForCommon_findLyOfficeByAttendance:^(BOOL done, NSString *text, id obj) {
//            if (done) {
                weakSelf.data = [LYCommonOfficeModel shareclass];
                if (weakSelf.isClass) {
                    [weakSelf setupZRCSubView];
                }else {
                    [weakSelf.tableView reloadData];
                    weakSelf.row = 0;
                    [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:1 scrollPosition:(UITableViewScrollPositionNone)];
                    [weakSelf setupSubView];
                }
//            }
//        }];
    }else if (self.expectType == ExpectTypeAttendance) {
        [RequestPost apiForCommon_findLyOfficeByAttendance:^(BOOL done, NSString *text, id obj) {
            if (done) {
                weakSelf.data = obj;
                if (weakSelf.isClass) {
                    [weakSelf setupZRCSubView];
                }else {
                    [weakSelf.tableView reloadData];
                    weakSelf.row = 0;
                    [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:1 scrollPosition:(UITableViewScrollPositionNone)];
                    [weakSelf setupSubView];
                }
            }
        }];
    }else if (self.expectType == ExpectAnnouncement) {
        [RequestPost apiForCommon_officeAll:^(BOOL done, NSString *text, NSDictionary * obj) {
            if (done) {
                LYCommonOfficeModel *model = [[LYCommonOfficeModel alloc] initWithDictionary:obj error:nil];
                weakSelf.data = model;
                [weakSelf setupZRCSubView];
            }
        }];
    }else if (self.expectType == ExpectServiceList) {
        [RequestPost apiForCommon_office:@"9" block:^(BOOL done, NSString *text, id obj) {
            if (done) {
                weakSelf.data = obj;
                if (weakSelf.isClass) {
                    [weakSelf setupZRCSubView];
                }else {
                    [weakSelf.tableView reloadData];
                    weakSelf.row = 0;
                    [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:1 scrollPosition:(UITableViewScrollPositionNone)];
                    [weakSelf setupSubView];
                }
            }
        }];
    }
    
}

//2级选择
- (void)setupSubView {
    
    for (UIView * view in self.subScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (kArrayIsEmpty(self.data.officeList)) {
        return;
    }
    LYCommonOfficeOfficeListModel * model = self.data.officeList[self.row];
    
    if (kArrayIsEmpty(model.userList)) return;
    
    CGFloat w = kScreenW - 120;
    kWEAKSELF(weakSelf);
    UIView *lastView;
    for (int i=0; i<model.userList.count; i++) {
        LYCommonOfficeUserListModel * obj = model.userList[i];
        
        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k999999 fontText:obj.name];
        [self.subScrollView addSubview:btn];
        btn.tag = i + (1000 * self.row);
        obj.tag = i + (1000 * self.row);
        [btn setBackgroundColor:RGB(245, 245, 245)];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        [btn setTitleColor:kBtnBC forState:(UIControlStateSelected)];
        
        btn.onClickBlock = ^(MyButton *sender) {
            [weakSelf btnClick:sender];
        };
        
        if (self.selectType) {
            for (LYCommonOfficeUserListModel *temp in self.selectDataArr) {
                if ([obj.employeeId isEqualToString:temp.employeeId]) {
                    [self btnSet:btn sel:1];
                    temp.tag = btn.tag;
                }
            }
        }
        
        CGFloat btnW = [CommonTools textSize:obj.name font:[CommonTools pxFont:26]].width + 16;
        
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self.subScrollView, kMainSpace).topSpaceToView(self.subScrollView, 8).heightIs(35).widthIs(btnW);
            [btn updateLayout];
        }else {
            
            if (w - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                btn.sd_layout.leftSpaceToView(self.subScrollView, kMainSpace).topSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }
        }
        
        //        [btn setupAutoSizeWithHorizontalPadding:6 buttonHeight:6];
        lastView = btn;
        
        [self.btnArr addObject:btn];
    }
    
    self.subScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lastView.frame));
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!kArrayIsEmpty(self.data.officeList)) {
        return self.data.officeList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = RGB(247, 247, 250);
    [cell.textLabel setTextColor:k999999];
    [cell.textLabel setHighlightedTextColor:kBtnBC];
    
    LYCommonOfficeOfficeListModel *data = self.data.officeList[indexPath.row];
    cell.textLabel.text = data.name;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [CommonTools pxFont:26];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:1];
//    RCGetChildPositionDataModel *data = self.levelOneData.data[indexPath.row];
    self.row = indexPath.row;
    [self.btnArr enumerateObjectsUsingBlock:^(MyButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = 0;
    }];
    [self setupSubView];
//    [self getData:@"2" parentId:data.id];
}

- (void)btnClick:(MyButton *)btn {
    LYCommonOfficeOfficeListModel *list = self.data.officeList[self.row];
    LYCommonOfficeUserListModel *obj = list.userList[btn.tag - (1000 * self.row)];
    
    if (self.selectType) {
        
        for (LYCommonOfficeUserListModel *temp in self.selectDataArr) {
            if (obj.tag - (1000 * self.row) == temp.tag - (1000 * self.row)) {
                [self btnSet:btn sel:0];
                [self.selectDataArr removeObject:temp];
                //删除已选中
                return;
            }
        }
        
        for (MyButton *temp in self.selectBtnArr) {
            if (temp.tag == btn.tag) {
                [self btnSet:btn sel:0];
                [self.selectBtnArr removeObject:temp];
                return;
            }
        }
        
//        if (self.selectBtnArr.count >= 3) {
//            return;
//        }
        [self btnSet:btn sel:1];
        
        [self.selectBtnArr addObject:btn];
        [self.selectDataArr addObject:obj];
    }else {
        
        [self.btnArr enumerateObjectsUsingBlock:^(MyButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self btnSet:btn sel:0];
            [self.selectDataArr removeAllObjects];
        }];
        [self btnSet:btn sel:1];
        
        [self.selectDataArr addObject:obj];
    }
//    [self reloadHeadView];
}

#pragma mark - 责任处 选择
- (void)setupZRCSubView {
    
    for (UIView * view in self.subScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (kArrayIsEmpty(self.data.officeList)) return;
    
    CGFloat w = kScreenW;
    kWEAKSELF(weakSelf);
    UIView *lastView;
    for (int i=0; i<self.data.officeList.count; i++) {
        LYCommonOfficeOfficeListModel * obj = self.data.officeList[i];
        
        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k999999 fontText:obj.name];
        [self.subScrollView addSubview:btn];
        btn.tag = i + (1000 * self.row);
        obj.tag = i + (1000 * self.row);
        [btn setBackgroundColor:RGB(245, 245, 245)];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        [btn setTitleColor:kBtnBC forState:(UIControlStateSelected)];
        
        btn.onClickBlock = ^(MyButton *sender) {
            [weakSelf zrcBtnClick:sender];
        };
        
        if (self.selectType) {
            for (LYCommonOfficeOfficeListModel *temp in self.selectDataArr) {
                if ([obj.name isEqualToString:temp.name] && [obj.id isEqualToString:temp.id]) {
                    [self btnSet:btn sel:1];
                    temp.tag = btn.tag;
                }
            }
        }
        
        CGFloat btnW = [CommonTools textSize:obj.name font:[CommonTools pxFont:26]].width + 16;
        
        if (lastView == nil) {
            btn.sd_layout.leftSpaceToView(self.subScrollView, kMainSpace).topSpaceToView(self.subScrollView, 8).heightIs(35).widthIs(btnW);
            [btn updateLayout];
        }else {
            
            if (w - CGRectGetMaxX(lastView.frame) > btnW) {
                btn.sd_layout.centerYEqualToView(lastView).leftSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }else {
                btn.sd_layout.leftSpaceToView(self.subScrollView, kMainSpace).topSpaceToView(lastView, 5).heightIs(35).widthIs(btnW);
                [btn updateLayout];
            }
        }
        lastView = btn;
        
        [self.btnArr addObject:btn];
    }
    
    self.subScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lastView.frame));
}

- (void)zrcBtnClick:(MyButton *)btn {
    LYCommonOfficeOfficeListModel *obj = self.data.officeList[btn.tag - (1000 * self.row)];
    
    if (self.selectType) {
        //是否在选中数据数组里面
        for (LYCommonOfficeOfficeListModel *temp in self.selectDataArr) {
            if (obj.tag - (1000 * self.row) == temp.tag - (1000 * self.row)) {
                [self btnSet:btn sel:0];
                [self.selectDataArr removeObjectAtIndex:obj.tag];
                return;
            }
        }
        
        for (MyButton *temp in self.selectBtnArr) {
            if (temp.tag == btn.tag) {
                [self btnSet:btn sel:0];
                [self.selectBtnArr removeObject:temp];
                return;
            }
        }
        
        [self btnSet:btn sel:1];
        
        
        [self.selectBtnArr addObject:btn];
        [self.selectDataArr addObject:obj];
    }
}

- (void)cearteHeadView {
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    self.selectView = view;
    
    [self createSelectView];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        make.height.offset(35);
    }];
    
//    BaseTextField *tf = [[BaseTextField alloc] init];
//    tf.placeholder = @"搜索";
//    tf.layer.masksToBounds = YES;
//    tf.layer.cornerRadius = 35/2;
//    tf.backgroundColor = [CommonTools colorHex:@"f5f5f5"];
//    tf.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:tf];
//    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.offset(15);
//        make.right.offset(-15);
//        make.height.offset(kAH(35));
//    }];
    
    MyLabel *lab = [[MyLabel alloc] initWithFontSize:38 fontColor:k999999 setText:@"请选择行业"];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(view.mas_bottom).offset(kAH(10));
    }];
}

- (void)btnSet:(MyButton *)btn sel:(BOOL)sel {
    btn.selected = sel;
    if (sel) {
        kViewBorderRadius(btn, 5, 1, kBtnBC);
        [btn setBackgroundColor:[UIColor whiteColor]];
    }else {
        [btn setBackgroundColor:RGB(245, 245, 245)];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
    }

}

- (void)createSelectView {
    
//    UIView *temp;
//    UIView *temp1;
//    UIView *temp2;
//
//    for (int i=0; i<3; i++) {
//
//        ExpectWorkView *view = [[ExpectWorkView alloc] init];
//        [self.selectView addSubview:view];
//        view.hidden = 1;
//
//        view.btn.tag = i + 10;
//
//        if (i == 0) temp = view;
//        if (i == 1) temp1 = view;
//        if (i == 2) temp2 = view;
//
//        view.btn.onClickBlock = ^(MyButton *sender) {
//            [self.selectDataArr removeObjectAtIndex:sender.tag - 10];
//        };
//    }
//
//    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.offset(0);
//        make.right.equalTo(temp1.mas_left).offset(-kMainSpace);
//        make.width.equalTo(temp1);
//    }];
//
//    [temp1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.offset(0);
//        make.left.equalTo(temp.mas_right).offset(kMainSpace);
//        make.right.equalTo(temp2.mas_left).offset(-kMainSpace);
//        make.width.equalTo(temp);
//    }];
//
//    [temp2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.offset(0);
//        make.left.equalTo(temp1.mas_right).offset(kMainSpace);
//        make.right.offset(0);
//        make.width.equalTo(temp1);
//    }];
}

- (void)reloadHeadView {
    
//    for (ExpectWorkView *view in self.selectView.subviews) {
//        view.hidden = 1;
//    }
//
//    for (int i=0; i<self.selectDataArr.count; i++) {
//        RCGetChildPositionDataModel *obj = self.selectDataArr[i];
//        ExpectWorkView *view = self.selectView.subviews[i];
//        view.title.text = obj.name;
//        view.hidden = 0;
//    }
    
}

@end
