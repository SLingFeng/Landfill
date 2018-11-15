//
//  LF_TableSelectView.m
//  
//
//  Created by 孙凌锋 on 2018/11/13.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "LF_TableSelectView.h"

@interface LF_TableSelectView ()
@property (nonatomic, assign) NSInteger one;
@property (nonatomic, assign) NSInteger two;
@property (nonatomic, assign) NSInteger three;
@end

@implementation LF_TableSelectView
{
    LF_TableSelectype _type;
    
    CGFloat _selectHeight;
    
    LF_TableSelectIndexBlock _block;
    LF_TableSelectNameBlock _nameBlock;
}

+ (instancetype)selectWithDataArr:(NSArray *)dataArr type:(LF_TableSelectype)type block:(LF_TableSelectNameBlock)block {
    return [[LF_TableSelectView alloc] initWithDataArr:dataArr two:nil three:nil type:type nameBlock:block];
}

+ (instancetype)selectWithDataArr:(NSArray *)dataArr block:(LF_TableSelectIndexBlock)block {
    return [[LF_TableSelectView alloc] initWithDataArr:dataArr two:nil three:nil type:LF_TableSelectTypeSingle block:block];
}

+ (instancetype)selectWithDataArr:(NSArray *)dataArr two:(NSArray *)two block:(LF_TableSelectIndexBlock)block {
    return [[LF_TableSelectView alloc] initWithDataArr:dataArr two:two three:nil type:LF_TableSelectTypeDouble block:block];
}

+ (instancetype)selectWithDataArr:(NSArray *)dataArr two:(NSArray *)two three:(NSArray *)three block:(LF_TableSelectIndexBlock)block {
    return [[LF_TableSelectView alloc] initWithDataArr:dataArr two:two three:three type:LF_TableSelectTypeThree block:block];
}

- (instancetype)initWithDataArr:(NSArray *)dataArr two:(NSArray *)two three:(NSArray *)three type:(LF_TableSelectype)type nameBlock:(LF_TableSelectNameBlock)block {
    self = [super init];
    if (self) {
        _nameBlock = block;
        
        if (type == LF_TableSelectTypeError) {
            [self cancelTap];
            [SLFHUD showHint:@"选择数据不完整"];
            [Bugly reportError:[NSError errorWithDomain:@"LF_TableSelectView选择数据不完整" code:100 userInfo:nil]];
            return self;
        }
        
        [self setupView:dataArr two:two three:three type:type];
    }
    return self;
}

- (instancetype)initWithDataArr:(NSArray *)dataArr two:(NSArray *)two three:(NSArray *)three type:(LF_TableSelectype)type block:(LF_TableSelectIndexBlock)block {
    self = [super init];
    if (self) {
        _block = block;
        
//        if (!kArrayIsEmpty(dataArr) && kArrayIsEmpty(two) && kArrayIsEmpty(three)) {
//            _type = LF_TableSelectTypeSingle;
//        }else if (!kArrayIsEmpty(dataArr) && !kArrayIsEmpty(two) && kArrayIsEmpty(three)) {
//            _type = LF_TableSelectTypeDouble;
//        }else if (!kArrayIsEmpty(dataArr) && !kArrayIsEmpty(two) && !kArrayIsEmpty(three)) {
//            _type = LF_TableSelectTypeThree;
//        }else {
            if (type == LF_TableSelectTypeError) {
                [self cancelTap];
                [SLFHUD showHint:@"选择数据不完整"];
                [Bugly reportError:[NSError errorWithDomain:@"LF_TableSelectView选择数据不完整" code:100 userInfo:nil]];
                return self;
            }
//        }

        [self setupView:dataArr two:two three:three type:type];
    }
    return self;
}

- (void)setupView:(NSArray *)dataArr two:(NSArray *)two three:(NSArray *)three type:(LF_TableSelectype)type {
    _type = type;
    
    _selectHeight = 260;
    self.frame = kScreen;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    //        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];
    
    UIView * back = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight)];
    self.backgroundView = back;
    [self addSubview:back];
    self.backgroundView.backgroundColor = kF5F5F5;
    
    UIButton * cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(cancelTap) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelBtn setTitleColor:k232931 forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = [SLFCommonTools pxFont:30];
    [self.backgroundView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView).with.offset(0);
        make.top.equalTo(self.backgroundView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    UIButton * doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [doneBtn setTitleColor:kBED500 forState:(UIControlStateNormal)];
    doneBtn.titleLabel.font = [SLFCommonTools pxFont:30];
    [self.backgroundView addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView).with.offset(0);
        make.top.equalTo(self.backgroundView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    kWeakSelf(weakSelf);
    switch (_type) {
        case LF_TableSelectTypeSingle:
        {
            LF_TableSelectSubView *tss = [[LF_TableSelectSubView alloc] initWithData:dataArr block:^(NSInteger one, NSString *name) {
                weakSelf.one = one;
            }];
            [self.backgroundView addSubview:tss];
            [tss mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.left.right.bottom.offset(0);
            }];
        }
            break;
        case LF_TableSelectTypeDouble:
        {
            
            LF_TableSelectSubView *tss = [[LF_TableSelectSubView alloc] initWithData:dataArr block:^(NSInteger one, NSString *name) {
                weakSelf.one = one;
            }];
            [self.backgroundView addSubview:tss];
            
            
            LF_TableSelectSubView *tss1 = [[LF_TableSelectSubView alloc] initWithData:two block:^(NSInteger one, NSString *name) {
                weakSelf.two = one;
            }];
            [self.backgroundView addSubview:tss1];
            
            [tss mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.left.bottom.offset(0);
                make.right.equalTo(tss1.mas_left).offset(0);
                make.width.mas_equalTo(kScreenW / 2);
            }];
            
            [tss1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.right.bottom.offset(0);
                make.left.equalTo(tss.mas_right).offset(0);
            }];
        }
            break;
        case LF_TableSelectTypeThree:
        {
            
            LF_TableSelectSubView *tss = [[LF_TableSelectSubView alloc] initWithData:dataArr block:^(NSInteger one, NSString *name) {
                weakSelf.one = one;
            }];
            [self.backgroundView addSubview:tss];
            
            LF_TableSelectSubView *tss1 = [[LF_TableSelectSubView alloc] initWithData:two block:^(NSInteger one, NSString *name) {
                weakSelf.two = one;
            }];
            [self.backgroundView addSubview:tss1];
            
            LF_TableSelectSubView *tss2 = [[LF_TableSelectSubView alloc] initWithData:three block:^(NSInteger one, NSString *name) {
                weakSelf.three = one;
            }];
            [self.backgroundView addSubview:tss2];
            
            [tss mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.left.bottom.offset(0);
                make.right.equalTo(tss1.mas_left).offset(0);
                make.width.mas_equalTo(kScreenW / 3);
            }];
            
            [tss1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.bottom.offset(0);
                make.left.equalTo(tss.mas_right).offset(0);
                make.right.equalTo(tss2.mas_left).offset(0);
                make.width.mas_equalTo(kScreenW / 3);
            }];
            
            [tss2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.right.bottom.offset(0);
                make.left.equalTo(tss1.mas_right).offset(0);
                //                    make.width.mas_equalTo(kScreenW / 3);
            }];
        }
            break;
        case LF_TableSelectTypeCustomizeLabel:
        {
            LF_TableSelectSubView *tss = [[LF_TableSelectSubView alloc] initWithData:dataArr block:^(NSInteger one, NSString *name) {
                weakSelf.one = one;
                weakSelf.nameStr = name;
            }];
            tss.type = LF_TableSelectTypeCustomizeLabel;
            [self.backgroundView addSubview:tss];
            [tss mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(40);
                make.left.right.bottom.offset(0);
            }];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
        }
            break;
        default:
            break;
    }
    
    
    [self show];
}

- (void)nextBtnClick:(UIButton *)btn {
    
    switch (_type) {
        case LF_TableSelectTypeSingle:
        {
            if (_block) {
                _block(self.one, self.one, self.one);
            }
        }
            break;
        case LF_TableSelectTypeDouble:
        {
            if (_block) {
                _block(self.one, self.two, 0);
            }
        }
            break;
        case LF_TableSelectTypeThree:
        {
            if (_block) {
                _block(self.one, self.two, self.three);
            }
        }
            break;
        case LF_TableSelectTypeCustomizeLabel:
        {
            if (_nameBlock) {
                _nameBlock(self.one, self.nameStr);
            }
        }
            break;
        default:
            break;
    }
    
    [self cancelTap];
}

-(void)show {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        self.backgroundView.alpha = 1;
        self.backgroundView.frame = CGRectMake(0, kScreenH-_selectHeight, kScreenW, _selectHeight);
    }];
}

-(void)cancelTap {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
        self.backgroundView.alpha = 0;
        self.backgroundView.frame = CGRectMake(0, kScreenH+_selectHeight, kScreenW, _selectHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


// 移除监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 监听键盘的frame即将改变的时候调用
- (void)keyboardWillChange:(NSNotification *)note{
    // 获得键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _backgroundView.frame = CGRectMake(0, frame.origin.y - _selectHeight, kScreenW, _selectHeight);
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        // 如果有需要,重新排版
        [self layoutIfNeeded];
    }];
}


@end

@implementation LF_TableSelectSubView
{
    UITableViewCell *_cell;

}

- (instancetype)initWithData:(NSArray *)data block:(LF_TableSelectNameBlock)block {
    self = [super init];
    if (self) {
        
        self.tableView = [[MyTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.separatorInset = UIEdgeInsetsZero;
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView registerClass:[LF_TableSelectSubCell class] forCellReuseIdentifier:@"LF_TableSelectSubCell"];

        
        self.dataArr = [NSMutableArray arrayWithArray:data];
        _block = block;
    }
    return self;
}

- (void)setType:(LF_TableSelectype)type {
    _type = type;
    [self.tableView reloadData];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    [_dataArr insertObject:@"请选择" atIndex:0];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == LF_TableSelectTypeCustomizeLabel) {
        return self.dataArr.count + 1;
    }
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == LF_TableSelectTypeCustomizeLabel && self.dataArr.count == indexPath.row) {
        LF_TableSelectSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LF_TableSelectSubCell"];
        kWeakSelf(weakSelf);
        cell.tf.textFieldChange = ^(BaseTextField *tf) {
            if (weakSelf.block) {
                weakSelf.block([tf.text integerValue], tf.text);
            }
        };
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [SLFCommonTools pxFont:28];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row == 0) {
        _cell = cell;
    }
    cell.textLabel.textColor = indexPath.row == 0 ? kBED500 : k232931;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    _cell.selected = NO;
    _cell.textLabel.textColor = k232931;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    cell.selected = !cell.selected;
    cell.textLabel.textColor = kBED500;

    if (_block) {
        _block(indexPath.row - 1, nil);
    }
    _cell = cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.textColor = k232931;
}

@end

@implementation LF_TableSelectSubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.tf = [[BaseTextField alloc] init];
        [self.contentView addSubview:self.tf];
        self.tf.keyboardType = UIKeyboardTypeNamePhonePad;
        self.tf.borderStyle = UITextBorderStyleRoundedRect;
        
        MyLabel *left = [[MyLabel alloc] initWithFontSize:28 fontColor:kAAAAAA setText:@"自定义"];
        [self.contentView addSubview:left];
     
        MyLabel *right = [[MyLabel alloc] initWithFontSize:28 fontColor:k232931 setText:@"万"];
        [self.contentView addSubview:right];
        
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kAW(160), kAH(56)));
        }];
        
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.tf.mas_left).offset(-12);
        }];
        
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.tf.mas_right).offset(12);
        }];
    }
    return self;
}

@end
