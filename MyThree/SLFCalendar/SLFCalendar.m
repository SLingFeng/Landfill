//
//  SLFCalendar.m
//  RenCaiKu
//
//  Created by 孙凌锋 on 2017/11/8.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "SLFCalendar.h"

@implementation SLFCalendar

+ (NSString *)jia:(NSDate *)tDate day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:tDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:day];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:tDate options:0];
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    
    return [NSString stringWithFormat:@"%ld", (long)[comps day]];
}
//判断年月相同
+ (BOOL)yearMonthEquls:(NSString *)str {
    NSDate * old = [SLFCalendar theTargetStringConversionDate:str];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];

    NSDateComponents *oldComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:old];
    
    return [comps year] == [oldComps year] && [comps month] == [oldComps month];
}

// date对象转换成字符串
+ (NSString * )theTargetDateConversionStr:(NSDate * )date {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *currentDateStr = [dateFormat stringFromDate:date];
    // 根据自己需求处理字符串
    return currentDateStr;
}
// NSString对象转date
+ (NSDate* )theTargetStringConversionDate:(NSString *)str {
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:str];
    return date;
}

//+ (int)getYear{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.year;
//
//}
//+ (int)getMonth{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.month;
//}
//+ (int)getDay{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.day;
//}
//+ (int)getHour{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.hour;
//}
//+ (int)getMinute{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.minute;
//}
//+ (int)getSecond{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
//    return (int)dateComponent.second;
//}


@end
