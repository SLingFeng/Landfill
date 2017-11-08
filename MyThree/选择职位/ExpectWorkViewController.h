//
//  ExpectWorkViewController.h
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/10/24.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "MyBaseTableViewController.h"

@interface ExpectWorkViewController : MyBaseTableViewController
//0单选 \ 1多选3个
@property (nonatomic, assign) BOOL selectType;

@property (nonatomic, copy) void(^workList)(NSMutableArray *list);

@end
