//
//  TimeTablesViewController.m
//  XinZiLong
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "TimeTablesViewController.h"
#import "TimeTableTableViewCell.h"
#import "TimeDateTableViewCell.h"
#import "MyAlertView.h"
#import "FakeSearchView.h"
#import "SearchForACourseViewController.h"

@interface TimeTablesViewController ()<UITableViewDelegate,UITableViewDataSource, TimeTableCellDelegate>
{
    BOOL _changeTable;
}
//右边的选项tableView
@property (nonatomic, strong) UITableView *rightTable;
//左边的选项tableView
@property (nonatomic, strong) UITableView *dateTableV;
@property (nonatomic, strong) TimeTableModel *timeTableModel;
@property (nonatomic, retain) NSArray *dateArr;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSArray *zhouArray;

@property (nonatomic, strong) DOPDropDownMenu *menu;
@property (nonatomic, retain) MyAlertView *alertView;

@property (nonatomic, retain) NSMutableDictionary * listHight;
@property (nonatomic, retain) NSMutableArray * tempHight;
@property (nonatomic, retain) NSMutableArray * expanded;
@property (nonatomic, assign) NSInteger index;

@end

@implementation TimeTablesViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CommonTools hideTabBar:self];
    [MobClick beginLogPageView:@"PageOne"];//("PageOne"为页面名称，可自定义)

    self.navigationItem.titleView = _tabBarbutton;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}

//- (NSArray *)array{
//    if (_array == nil) {
//        _array = [[NSMutableArray alloc] init];
//    }
//    return _array;
//}
//- (NSMutableArray *)dateArr{
//    if (_dateArr == nil) {
//        _dateArr = [[NSMutableArray alloc] init];
//    }
//    return _dateArr;
//}
//- (NSArray *)array1
//{
//    if (_array1 == nil) {
//        _array1 = [[NSArray alloc] init];
//    }
//    return _array1;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CommonTools getBackgroundColor:self];
    //初始化表单
    [self setUp];
    //初始化请求数据
    [self uPData];
}
- (void)uPData{
    kWEAKSELF(weakSelf);
    weakSelf.alertView = [[MyAlertView alloc] initWithFrame:weakSelf.view.bounds];
    [RequestPost requestForGetGFOrBJBlock:^(ChargeAndClassesModel *charge) {
        if (charge != nil) {
            
            //获取数据源的数组
            weakSelf.alertView.dataArray = charge.fg;
            weakSelf.titleArray = charge.fg;
            weakSelf.alertView.tempsvc2 = weakSelf;
            [weakSelf.alertView.title setText:@"选择分馆"];
            [weakSelf setBackString:nil];
        }
    }];
}
-(void)buttonClick{
    [self.view endEditing:YES];
    [self.alertView pop];
}


- (void)setUp{
    self.tempHight = [[NSMutableArray alloc] init];
    self.expanded = [[NSMutableArray alloc] initWithCapacity:0];
    self.listHight = [[NSMutableDictionary alloc] initWithCapacity:0];
    //设置一个中间的button
    self.tabBarbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.tabBarbutton setFrame:CGRectMake(0,0, kScreenW/1.5, KHight(40))];
    [self.tabBarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tabBarbutton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:self.tabBarbutton];
    
    
    
    self.zhouArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    self.dateTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KWidth(120), kMianNavH-KHight(10))];
    [self.dateTableV setBackgroundColor:[UIColor redColor]];
    self.dateTableV.delegate = self;
    self.dateTableV.dataSource = self;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dateTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dateTableV.showsVerticalScrollIndicator = NO;
    self.dateTableV.tag = 100;
    self.dateTableV.scrollEnabled = NO;
    self.dateTableV.backgroundColor = [CommonTools getColorWithHexString:@"F4F4F4"];
    [self.view addSubview:self.dateTableV];
    [self.dateTableV registerClass:[TimeDateTableViewCell class] forCellReuseIdentifier:KTimeDateTableCell];
    
    FakeSearchView * fake = [[FakeSearchView alloc] initIsBack:NO];
    [self.view addSubview:fake];
    kWEAKSELF(weakSelf);
    fake.goToSearch = ^(BOOL is, NSString * text) {
        if ([text isEqualToString:@""]) {
            [MyMBProgressHUD hudForText:@"姓名不能为空" view:self.view];
        }else if (!is) {
            SearchForACourseViewController *svc = [[SearchForACourseViewController alloc] init];
            svc.searchForClass = weakSelf.tabBarbutton.titleLabel.text;
            svc.searchForName = text;
            [weakSelf.navigationController pushViewController:svc animated:YES];
        }
    };
    
    fake.sd_layout.topSpaceToView(self.view, 70).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(30);
       
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(120, 40+64, kScreenW-120, kScreenH-120)];
    self.rightTable.delegate = self;
    self.rightTable.dataSource = self;
    self.rightTable.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.rightTable.showsVerticalScrollIndicator = NO;
    self.rightTable.tag = 101;
    [self.view addSubview:self.rightTable];
    [self.rightTable registerClass:[TimeTableTableViewCell class] forCellReuseIdentifier:KTimeTableCell];
    _rightTable.backgroundColor = kCOLOR_WITH(234, 234, 234);
    [self.dateTableV selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行（默认有蓝色背景）
//    [self performSelector:@selector(tableView: didSelectRowAtIndexPath:) withObject:self.dateTableV withObject:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    _rightTable.sd_layout.topSpaceToView(self.view, 104).leftSpaceToView(_dateTableV, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _rightTable) {
        return self.dateArr.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _rightTable) {
        TimeContentModel * tcm = self.dateArr[section];
        return tcm.content.count;
    }else {
        return self.zhouArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _rightTable) {
        TimeTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTimeTableCell];
        TimeContentModel * tcm = self.dateArr[indexPath.section];
        cell.delgate = self;
        cell.contentData = tcm.content[indexPath.row];
//        [cell setContent:tcm.content[indexPath.row]];
        NSLog(@"%d", _changeTable);
        if (_expanded.count != 0) {
            [cell changeBtn:[_expanded[indexPath.section][indexPath.row] boolValue]];
        }
        if (_changeTable) {
//            cell.select = NO;
//            cell.downBtn.selected = NO;
            [cell chongZhi:1];
        }
        [_listHight setObject:@(cell.hightCell) forKey:[NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        TimeDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTimeDateTableCell];
        cell.contentView.layer.borderWidth = 0.5;
        cell.contentView.layer.borderColor = [CommonTools getColorWithHexString:@"E6E6E6"].CGColor;
        cell.date.text = self.zhouArray[indexPath.row];
        cell.contentView.backgroundColor = [CommonTools getColorWithHexString:@"F4F4F4"];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}

-(void)infoCell:(TimeTableTableViewCell *)cell {
    NSIndexPath * indexPath = [_rightTable indexPathForCell:cell];
    if (cell.downBtn.selected) {
        [(NSMutableArray *)self.expanded[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(YES)];
        cell.select = YES;
    }else {
        [(NSMutableArray *)self.expanded[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(NO)];
        cell.select = NO;
    }
    [_rightTable beginUpdates];
    [_rightTable endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _rightTable) {
        if (_expanded.count != 0) {
            if ([_expanded[indexPath.section][indexPath.row] boolValue]) {
                if (_listHight.count != 0) {
                    return [_listHight[[NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row]] floatValue];
                }
            }else {
                return 50;
            }
        }
        return 0;//[_rightTable cellHeightForIndexPath:indexPath cellContentViewWidth:kScreenW-120 tableView:tableView];//KHight(300);
    }else {
        return KHight(61);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (tableView == _dateTableV) {
        switch (indexPath.row) {
            case 0:
                self.dateArr = self.timeTableModel.monday;
                break;
            case 1:
                self.dateArr = self.timeTableModel.tuesday;
                break;
            case 2:
                self.dateArr = self.timeTableModel.wednesday;
                break;
            case 3:
                self.dateArr = self.timeTableModel.thursday;
                break;
            case 4:
                self.dateArr = self.timeTableModel.friday;
                break;
            case 5:
                self.dateArr = self.timeTableModel.saturday;
                break;
            case 6:
                self.dateArr = self.timeTableModel.sunday;
                break;
            default:
                break;
        }
        
    }else {
//        TimeTableTableViewCell * cell = [_rightTable cellForRowAtIndexPath:indexPath];
//        cell.downBtn.selected = !cell.downBtn.selected;
//        [cell chongZhi:0];
//        if (cell.downBtn.selected) {
//            [(NSMutableArray *)self.expanded[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(YES)];
//        }else {
//            [(NSMutableArray *)self.expanded[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@(NO)];
//        }
//        [_rightTable beginUpdates];
//        [_rightTable endUpdates];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTable) {
        TimeContentModel * tcm = self.dateArr[section];
        if (tcm.content.count == 0) {
            return nil;
        }
        UIView * view = [[UIView alloc] init];
        if (section != 0 && tcm.content.count != 0) {
            [self line:view];
        }
        view.backgroundColor = [UIColor whiteColor];
        MyLabel * label = [[MyLabel alloc] initWithFrame:CGRectMake(10, 10, kScreenW, 20)];
        TimeTableDateModel * ttdm = tcm.content[0];
        label.text = ttdm.starttime;
        label.font = [CommonTools getFontSize:24];
        label.textColor = [CommonTools getColorWithHexString:@"999999"];
        [view addSubview:label];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTable) {
        TimeContentModel * tcm = self.dateArr[section];
        if (tcm.content.count == 0) {
            return 0.1;
        }
        return 30;
    }
    return 0.1;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (tableView == _rightTable) {
//        UIView * view = [[UIView alloc] init];
//        [self line:view];
//        return view;
//    }
//    return nil;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (tableView ==_rightTable) {
//        return 2;
//    }
//    return 0.1;
//}

#pragma mark - 设置数组
-(void)setDateArr:(NSMutableArray *)dateArr {
    if (_dateArr != dateArr) {
        _dateArr = dateArr;
        [self.expanded removeAllObjects];
        [self.listHight removeAllObjects];
        for (int i=0; i<dateArr.count; i++) {
            TimeContentModel * tcm = dateArr[i];
            NSMutableArray * temp = [NSMutableArray arrayWithCapacity:0];
            for (int x=0; x<tcm.content.count; x++) {
                [temp addObject:@(NO)];
            }
            [_expanded addObject:temp];
        }
        _changeTable = YES;
        [self.rightTable reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新完成
            _changeTable = NO;
        });
        
    }
}
//高度

#pragma mark 设置set方法接受从数据采集器收集到值
-(void)setBackString:(NSString *)backString{
    kWEAKSELF(weakSelf);//@"海沧天虹旗舰馆"
    NSString *string = nil;
    if (backString == nil) {
        ChargeAndClassesFGAndBJModel *model = _titleArray[0];
        [self.tabBarbutton setTitle:model.dmmc forState:UIControlStateNormal];
        string = [model.dmmc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else {
        [self.tabBarbutton setTitle:backString forState:UIControlStateNormal];
        string = [backString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    [RequestPost requestForTimeTableDcareaname:string block:^(TimeTableModel *timeTable) {
        if (timeTable != nil) {
            weakSelf.timeTableModel = timeTable;
            [_dateTableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];//设置选中第一行（默认有蓝色背景）
//            [weakSelf.rightTable reloadData];
            [weakSelf performSelector:@selector(tableView:didSelectRowAtIndexPath:) withObject:weakSelf.dateTableV withObject:[NSIndexPath indexPathForRow:0 inSection:0]];
        }else {
            [MyMBProgressHUD hudForText:@"查询无结果" delay:2 view:weakSelf.view];
        }
    }];

}

- (void)line:(UIView *)view {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[CommonTools getColorWithHexString:@"CCCCCC"] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 1);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(_rightTable.frame)-12, 1);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[view layer] addSublayer:shapeLayer];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
