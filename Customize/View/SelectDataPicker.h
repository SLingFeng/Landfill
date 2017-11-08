//
//  SelectDataPicker.h
//  test
//
//  Created by SADF on 16/11/10.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SeleCtTypeYearMonthDay,
    SeleCtTypeYearMonth,
    SeleCtTypeTime,
    SeleCtTypePercentage,
    SeleCtTypeMoney,
    SeleCtTypeName,//名字
    SeleCtTypeCountDownTimer,//时分
    SeleCtTypeCustomize,//自定义数据单列
} SeleCtType;

typedef void (^selectIndexBlock)(NSString*text, NSInteger index);

@interface SelectDataPicker : UIView
@property (nonatomic, retain) NSMutableArray<NSString *> * NameDataArr;
@property (nonatomic, copy) NSMutableString * timeDate;

@property (nonatomic, copy) void (^backTimeDate)(NSString *text, NSDate *date, NSInteger index);

-(instancetype)initWithType:(SeleCtType)type;

/**
 SeleCtTypeCustomize 回掉
 */
@property (nonatomic, copy) selectIndexBlock selectIndexBlock;

/**
 自定义数据单列

 @param dataArr 数据数组
 @param block 回掉文字，选择第几个
 @return self
 */
+ (instancetype)pickerWithDataArr:(NSArray *)dataArr block:(selectIndexBlock)block;

@end
