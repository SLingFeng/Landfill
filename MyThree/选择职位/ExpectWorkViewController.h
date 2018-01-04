//
//  ExpectWorkViewController.h
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/10/24.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "MyBaseTableViewController.h"

typedef enum : NSUInteger {
    ExpectNormal,
    ExpectAnnouncement,//公告
    ExpectServiceList,//服务单
    ExpectTypeAttendance,//考勤组
} ExpectType;

@interface ExpectWorkViewController : MyBaseTableViewController

- (instancetype)initWithtitle:(NSString *)title;

//0单选 \ 1多选
@property (nonatomic, assign) BOOL selectType;

//选中数据
@property (nonatomic, retain) NSMutableArray *selectDataArr;

@property (nonatomic, copy) void(^workList)(NSMutableArray *list);

@property (nonatomic, copy) void(^typeList)(NSString *strName, NSString *strID, NSMutableArray *list);

@property (nonatomic, copy) NSString * itemInfoId;
//no3级选择 yes2级选择
@property (nonatomic, assign) BOOL isClass;

@property (nonatomic, assign) ExpectType expectType;

@end
