//
//  AddressModel.h
//  test
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ProvinceModel <NSObject>
@end

@protocol ProvinceDetailedModel <NSObject>
@end

@protocol CityModel <NSObject>
@end

@protocol ShengModel <NSObject>
@end

@protocol ShiModel <NSObject>
@end

@protocol QuModel <NSObject>
@end

///省份大组
@interface AddressModel : JSONModel
@property (retain, nonatomic) NSArray<ProvinceModel, Optional> * child;


@end
///省份小组
@interface ProvinceModel : JSONModel
@property (copy, nonatomic) NSString<Optional> *areaName;
@property (assign, nonatomic) NSInteger lev;
@property (retain, nonatomic) NSArray<ProvinceDetailedModel> * child;
@end
///区大组
@interface ProvinceDetailedModel : JSONModel
@property (copy, nonatomic) NSString<Optional> *areaName;
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger lev;
@property (retain, nonatomic) NSArray<CityModel> * child;
@end
///市
@interface CityModel : JSONModel
@property (copy, nonatomic) NSString<Optional> *areaName;
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger lev;

@end
#pragma mark - 较全的

@interface ShengModel : JSONModel
@property (retain, nonatomic) NSArray<ShiModel, Optional> * shi;
@end

@interface ShiModel : JSONModel
@property (copy, nonatomic) NSString<Optional> *area;//"010",
@property (retain, nonatomic) NSArray<ShiModel, Optional> *cities;//Array[16],
@property (copy, nonatomic) NSString<Optional> *code;//"110000",
@property (assign, nonatomic) NSInteger level;//1,
@property (copy, nonatomic) NSString<Optional> *name;//"北京市",
@property (copy, nonatomic) NSString<Optional> *prefix;//"市"
@end

@interface QuModel : JSONModel
@property (copy, nonatomic) NSString<Optional> *area;//"010",
@property (retain, nonatomic) NSArray<ShiModel, Optional> *cities;//Array[16],
@property (copy, nonatomic) NSString<Optional> *code;//"110001",
@property (assign, nonatomic) NSInteger level;//2,
@property (copy, nonatomic) NSString<Optional> *name;//"东城区",
@property (copy, nonatomic) NSString<Optional> *prefix;//"区"
@end
