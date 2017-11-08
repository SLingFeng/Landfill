//
//  SLFCalendar.h
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/11/8.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFCalendar : NSObject

+ (NSString *)jia:(NSDate *)tDate day:(NSInteger)day;

//判断年月相同
+ (BOOL)yearMonthEquls:(NSString *)str;

// date对象转换成字符串
+ (NSString * )theTargetDateConversionStr:(NSDate * )date;

// NSString对象转date
+ (NSDate* )theTargetStringConversionDate:(NSString *)str;



@end
