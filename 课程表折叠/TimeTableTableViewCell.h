//
//  TimeTableTableViewCell.h
//  XinZiLong
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentsListView.h"

@class TimeTableTableViewCell;
@protocol TimeTableCellDelegate <NSObject>
/**
 * @author LingFeng, 2016-07-04 14:07:21
 *
 * 展开cell
 * @param cell 点击按钮的cell
 */
-(void)infoCell:(TimeTableTableViewCell *)cell;

@end

@interface TimeTableTableViewCell : UITableViewCell
//展开
@property (assign, nonatomic) BOOL select;

//@property (nonatomic, strong) MyLableTinge *date;
@property (nonatomic, strong) MyLabel *numberClass;
@property (nonatomic, strong) MyLabel *nameClass;
@property (nonatomic, strong) UIButton *downBtn;

@property (nonatomic, strong) StudentsListView * listView;
@property (assign, nonatomic) CGFloat hightCell;

@property (nonatomic, retain) TimeTableDateModel * contentData;

@property (assign, nonatomic) id <TimeTableCellDelegate> delgate;

-(void)setContent:(TimeTableDateModel *)model;
-(void)changeBtn:(BOOL)change;
-(void)chongZhi:(BOOL)isReLoadData;
@end
