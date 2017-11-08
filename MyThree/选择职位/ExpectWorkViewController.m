//
//  ExpectWorkViewController.m
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/10/24.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "ExpectWorkViewController.h"
#import "ExpectWorkView.h"

@interface ExpectWorkViewController ()

@property (nonatomic, retain) UIScrollView *subScrollView;
//当前现实btn
@property (nonatomic, retain) NSMutableArray *btnArr;

@property (nonatomic, retain) RCGetChildPositionModel *levelOneData;

@property (nonatomic, retain) RCGetChildPositionModel *levelTwoData;

@property (nonatomic, retain) NSMutableArray *selectBtnArr;
//选中数据
@property (nonatomic, retain) NSMutableArray *selectDataArr;
//选择
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, retain) UIView *selectView;

@end

@implementation ExpectWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"期望工作"];
    
    self.view.backgroundColor = [CommonTools colorHex:@"f7f7fa"];
    
    [self neededTableViewStyle:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [CommonTools colorHex:@"f7f7fa"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.btnArr = [NSMutableArray arrayWithCapacity:10];
    
    self.selectBtnArr = [NSMutableArray arrayWithCapacity:3];
    
    self.selectDataArr = [NSMutableArray arrayWithCapacity:3];
    
    self.subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(90, 100, kScreenW-90, kScreenH)];
    [self.view addSubview:self.subScrollView];
    self.subScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(0);
        make.width.mas_equalTo(90);
        make.bottom.offset(0);
    }];
    
    [self getData:@"1" parentId:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBlock)];
    
    [self cearteHeadView];
}

- (void)clickBlock {
    [self.navigationController popViewControllerAnimated:1];
    if (self.workList) {
        self.workList(self.selectDataArr);
    }
}

- (void)getData:(NSString *)level parentId:(NSString *)parentId {
    if (kStringIsEmpty(parentId)) {
        parentId = @"0";
    }
    kWEAKSELF(weakSelf);
    [RequestPost apiForPositionGetChildPositionLevel:level parentId:parentId block:^(BOOL done, NSString *text, id obj) {
        if ([level isEqualToString:@"1"]) {
            weakSelf.levelOneData = obj;
            [weakSelf.tableView reloadData];
        }else {
            weakSelf.levelTwoData = obj;
            [weakSelf setupSubView];
        }
        
    }];
}

//2级选择
- (void)setupSubView {
    
    for (UIView * view in self.subScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    if (kArrayIsEmpty(self.levelTwoData.data)) return;
    
    CGFloat w = kScreenW - 90;
    kWEAKSELF(weakSelf);
    UIView *lastView;
    for (int i=0; i<self.levelTwoData.data.count; i++) {
        RCGetChildPositionDataModel *obj = self.levelTwoData.data[i];
        
        MyButton *btn = [[MyButton alloc] initWithFontSize:26 fontColor:k666666 fontText:obj.name];
        [self.subScrollView addSubview:btn];
        btn.tag = i + (1000 * self.row);
        obj.tag = i + (1000 * self.row);
        [btn setBackgroundColor:[CommonTools colorHex:@"f5f5f5"]];
        kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
        [btn setTitleColor:[CommonTools getNavBarColor] forState:(UIControlStateSelected)];
        
        btn.onClickBlock = ^(MyButton *sender) {
            [weakSelf btnClick:sender];
        };
        
        if (self.selectType) {
            for (RCGetChildPositionDataModel *temp in self.selectDataArr) {
                if ([obj.name isEqualToString:temp.name] && [obj.id isEqualToString:temp.id]) {
                    btn.selected = 1;
                    kViewBorderRadius(btn, 5, 1, [CommonTools getNavBarColor]);
                    [btn setBackgroundColor:[UIColor whiteColor]];
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
    if (!kArrayIsEmpty(self.levelOneData.data)) {
        return self.levelOneData.data.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [CommonTools colorHex:@"f7f7fa"];
    [cell.textLabel setHighlightedTextColor:[CommonTools colorHex:@"ea633c"]];
    
    RCGetChildPositionDataModel *data = self.levelOneData.data[indexPath.row];
    cell.textLabel.text = data.name;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [CommonTools pxFont:26];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:1];
    RCGetChildPositionDataModel *data = self.levelOneData.data[indexPath.row];
    self.row = indexPath.row;
    [self getData:@"2" parentId:data.id];
}

- (void)btnClick:(MyButton *)btn {
    RCGetChildPositionDataModel *obj = self.levelTwoData.data[btn.tag - (1000 * self.row)];
    
    if (self.selectType) {
        
        for (RCGetChildPositionDataModel *temp in self.selectDataArr) {
            if (obj.tag - (1000 * self.row) == temp.tag - (1000 * self.row)) {
                [self.selectDataArr removeObject:temp];
                break;
            }
        }
        
        for (MyButton *temp in self.selectBtnArr) {
            if (temp.tag == btn.tag) {
                btn.selected = 0;
                [btn setBackgroundColor:[CommonTools colorHex:@"f5f5f5"]];
                kViewBorderRadius(btn, 5, 0, [UIColor clearColor]);
                [self.selectBtnArr removeObject:temp];
                return;
            }
        }
        
        if (self.selectBtnArr.count >= 3) {
            return;
        }
        btn.selected = 1;
        kViewBorderRadius(btn, 5, 1, [CommonTools getNavBarColor]);
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        [self.selectBtnArr addObject:btn];
        [self.selectDataArr addObject:obj];
    }else {
        
        [self.btnArr enumerateObjectsUsingBlock:^(MyButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = 0;
            [obj setBackgroundColor:[CommonTools colorHex:@"f5f5f5"]];
            kViewBorderRadius(obj, 5, 0, [UIColor clearColor]);
            [self.selectDataArr removeAllObjects];
        }];
        btn.selected = 1;
        kViewBorderRadius(btn, 5, 1, [CommonTools getNavBarColor]);
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        [self.selectDataArr addObject:obj];
    }
    [self reloadHeadView];
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

- (void)createSelectView {
    
    UIView *temp;
    UIView *temp1;
    UIView *temp2;
    
    for (int i=0; i<3; i++) {
        
        ExpectWorkView *view = [[ExpectWorkView alloc] init];
        [self.selectView addSubview:view];
        view.hidden = 1;
        
        view.btn.tag = i + 10;
        
        if (i == 0) temp = view;
        if (i == 1) temp1 = view;
        if (i == 2) temp2 = view;
        
        view.btn.onClickBlock = ^(MyButton *sender) {
            [self.selectDataArr removeObjectAtIndex:sender.tag - 10];
        };
    }
    
    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(temp1.mas_left).offset(-kMainSpace);
        make.width.equalTo(temp1);
    }];
    
    [temp1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(temp.mas_right).offset(kMainSpace);
        make.right.equalTo(temp2.mas_left).offset(-kMainSpace);
        make.width.equalTo(temp);
    }];
    
    [temp2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(temp1.mas_right).offset(kMainSpace);
        make.right.offset(0);
        make.width.equalTo(temp1);
    }];
}

- (void)reloadHeadView {
    
    for (ExpectWorkView *view in self.selectView.subviews) {
        view.hidden = 1;
    }
    
    for (int i=0; i<self.selectDataArr.count; i++) {
        RCGetChildPositionDataModel *obj = self.selectDataArr[i];
        ExpectWorkView *view = self.selectView.subviews[i];
        view.title.text = obj.name;
        view.hidden = 0;
    }
    
}

@end
