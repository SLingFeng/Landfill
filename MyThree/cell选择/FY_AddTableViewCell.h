//
//  FY_HouseEnterTableViewCell.h
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/9.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FY_AddTableViewCell : UITableViewCell

@property (nonatomic, retain) MyLabel *titleLabel;

@property (nonatomic, retain) BaseTextField *tf;

@property (nonatomic, retain) MyLabel *rightLabel;

@property (nonatomic, retain) UIImageView *rightIV;

@property (nonatomic, retain) MyButton *rightBtn;

@property (nonatomic, retain) FY_HouseAddCellModel *model;

@end
