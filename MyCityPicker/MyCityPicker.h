//
//  MyCityPicker.h
//  test
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MMPopupView.h>
#import <MMSheetView.h>
#import <MMPopupDefine.h>
#import <MMPopupCategory.h>


typedef enum : NSUInteger {
    PickerTypeCity,///展示城市内容
    PickerTypeSingle,///1个区
    PickerTypeTwoGroups,///2个区
} MyCityPickerType;

@interface MyCityPicker : MMPopupView

@property (assign, nonatomic) MyCityPickerType pickerType;
/**
 * @author LingFeng, 2016-07-19 17:07:20
 *
 * 返回选中的行内容 数组内第1区的内容为[0] 如果是单个区
 */
@property (copy, nonatomic) void(^selectContent)(NSArray<NSString *> * content);

@property (retain, nonatomic) NSArray *componentZero;

@property (retain, nonatomic) NSArray *componentOne;
/**
 * @author LingFeng, 2016-07-19 17:07:39
 *
 * 从下面推出选择器
 * @param componentZero 第0数组
 * @param componentOne 第1数组
 * @param Type 显示的类型
 * @return PickerView
 */
-(instancetype)initWithComponentRowZero:(NSArray<NSString *> *)componentZero ComponentRowOne:(NSArray<NSArray<NSString *>*> *)componentOne Type:(MyCityPickerType)Type;

@end
