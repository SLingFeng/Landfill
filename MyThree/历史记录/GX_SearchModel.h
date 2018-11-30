//
//  GX_SearchModel.h
//  gxw
//
//  Created by 孙凌锋 on 2018/11/30.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "SLFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol GX_SearchInfoModel <NSObject>
@end

@interface GX_SearchInfoModel : SLFBaseModel

@property (nonatomic, copy) NSString *name;

@end

@interface GX_SearchModel : SLFBaseModel

@property (nonatomic, retain) NSMutableArray <GX_SearchInfoModel>*houseList;

@property (nonatomic, retain) NSMutableArray <GX_SearchInfoModel>*carList;

@property (nonatomic, retain) NSMutableArray <GX_SearchInfoModel>*idleList;

-(void)addHouseHistoryData:(GX_SearchInfoModel *)obj;
-(void)addCarHistoryData:(GX_SearchInfoModel *)obj;
-(void)addIdleHistoryData:(GX_SearchInfoModel *)obj;

- (void)removeAll;
@end

NS_ASSUME_NONNULL_END
