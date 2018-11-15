//
//  FY_HouseAddInfoModel.h
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/8.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "SLFBaseModel.h"
@class BaseTextField;
@class FSTextView;
@class UITableViewCell;
@class FY_AddTableViewCell;
@class MyButton;
#import <UIKit/UIKit.h>

@interface FY_HouseAddCellModel : SLFBaseModel

/**
cell的状态
 0:FY_HouseEnterTableViewCell 选择
 1:FY_HouseEnterTableViewCell 输入
 10: 输入 带箭头
 11: 输入 带文本
 2：FY_HousePhotoAddTableViewCell
 3: FY_HouseEnterTextViewTableViewCell 
 40: FY_MultipleTableViewCell 第一个和其他不能全选
 41: FY_MultipleTableViewCell 多选
 42: FY_MultipleTableViewCell 选3个

 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *btnTitle;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *rightText;

@property (nonatomic, copy) void(^cellDidClick)(FY_AddTableViewCell *cell);

@property (nonatomic, copy) void(^textFieldChange)(BaseTextField *tf);

@property (nonatomic, copy) void(^FSTextViewHandler)(FSTextView *textView);

@property (nonatomic, copy) void(^selectIDBlock)(NSString *ids);

@property (nonatomic, copy) void(^onClickBlock)(MyButton *sender);

@property (nonatomic) UIKeyboardType keyboardType;

@property (nonatomic, retain) NSMutableArray *mulitpleData;
//用户输入文字保存起来
@property (nonatomic, copy) NSString *userEnterText;

@property (assign, nonatomic) NSInteger enterNumber;

@property (nonatomic, assign) BOOL rightIVHidden;

//处理税收
//+ (FY_HouseAddInfoModel *)shuishou:(FY_HouseAddInfoModel *)model ids:(NSString *)ids;
//
//+ (FY_HouseAddInfoModel *)riqi:(FY_HouseAddInfoModel *)model ids:(NSString *)ids;
//
//+ (FY_HouseAddInfoModel *)zhengshu:(FY_HouseAddInfoModel *)model ids:(NSString *)ids;
@end
