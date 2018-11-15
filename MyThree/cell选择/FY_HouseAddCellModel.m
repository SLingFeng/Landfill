//
//  FY_HouseAddInfoModel.m
//  房源管理
//
//  Created by 孙凌锋 on 2018/6/8.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "FY_HouseAddCellModel.h"


@implementation FY_HouseAddCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

//+ (FY_HouseAddInfoModel *)shuishou:(FY_HouseAddInfoModel *)model ids:(NSString *)ids {
//
//    model.no_tax = ([ids rangeOfString:@"0"].length > 0) ? @"1" : @"0";
//    model.self_tax = ([ids rangeOfString:@"1"].length > 0) ? @"1" : @"0";
//    model.add_tax = ([ids rangeOfString:@"2"].length > 0) ? @"1" : @"0";
//
//    return model;
//}
//
//+ (FY_HouseAddInfoModel *)riqi:(FY_HouseAddInfoModel *)model ids:(NSString *)ids {
//    //0满5 / 1满2 / 2唯一 /3是否急售
//    model.man5 = ([ids rangeOfString:@"0"].length > 0) ? @"1" : @"0";
//    model.man2 = ([ids rangeOfString:@"1"].length > 0) ? @"1" : @"0";
//    model.only = ([ids rangeOfString:@"2"].length > 0) ? @"1" : @"0";
//    model.urgent = ([ids rangeOfString:@"3"].length > 0) ? @"1" : @"0";
//
//    return model;
//}
//
//+ (FY_HouseAddInfoModel *)zhengshu:(FY_HouseAddInfoModel *)model ids:(NSString *)ids {
//    //0是否新证 / 1是否贷款
//    model.is_new_car = ([ids rangeOfString:@"0"].length > 0) ? @"1" : @"0";
//    model.is_loan = ([ids rangeOfString:@"1"].length > 0) ? @"1" : @"0";
//
//    return model;
//}


@end
