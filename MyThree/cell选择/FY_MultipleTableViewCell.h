//
//  FY_MultipleTableViewCell.h
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/12.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceView.h"

@interface FY_MultipleTableViewCell : UITableViewCell
@property (nonatomic, retain) MyLabel *titleLabel;
//多选和单选
@property (nonatomic, retain) ChoiceView *mcView;

@property (nonatomic, retain) FY_HouseAddCellModel *model;
@end
