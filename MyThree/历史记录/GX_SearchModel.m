//
//  GX_SearchModel.m
//  gxw
//
//  Created by 孙凌锋 on 2018/11/30.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "GX_SearchModel.h"


@implementation GX_SearchInfoModel

@end

@implementation GX_SearchModel


- (NSMutableArray<GX_SearchInfoModel> *)houseList {
    if (!_houseList) {
        _houseList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
    }
    return _houseList;
}

- (NSMutableArray<GX_SearchInfoModel> *)carList {
    if (!_carList) {
        _carList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
    }
    return _carList;
}

- (NSMutableArray<GX_SearchInfoModel> *)idleList {
    if (!_idleList) {
        _idleList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
    }
    return _idleList;
}

-(void)addHouseHistoryData:(GX_SearchInfoModel *)obj {
    for (int i=0; i<self.houseList.count; i++) {
        GX_SearchInfoModel * str = self.houseList[i];
        if ([obj.name isEqualToString:str.name]) {
            //  相同搜索条件
            return;
        }
    }

    [self.houseList insertObject:obj atIndex:0];
    if (self.houseList.count >= 6) {
        [self.houseList removeObjectAtIndex:0];
    }
    [self saveAppConfig:@"history"];
}

-(void)addCarHistoryData:(GX_SearchInfoModel *)obj {
    for (int i=0; i<self.carList.count; i++) {
        GX_SearchInfoModel * str = self.carList[i];
        if ([obj.name isEqualToString:str.name]) {
            //  相同搜索条件
            return;
        }
    }
    
    [self.carList insertObject:obj atIndex:0];
    if (self.carList.count >= 6) {
        [self.carList removeObjectAtIndex:0];
    }
    [self saveAppConfig:@"history"];
}

-(void)addIdleHistoryData:(GX_SearchInfoModel *)obj {
    for (int i=0; i<self.idleList.count; i++) {
        GX_SearchInfoModel * str = self.idleList[i];
        if ([obj.name isEqualToString:str.name]) {
            //  相同搜索条件
            return;
        }
    }
    
    [self.idleList insertObject:obj atIndex:0];
    if (self.idleList.count >= 6) {
        [self.idleList removeObjectAtIndex:0];
    }
    [self saveAppConfig:@"history"];
}

- (void)removeAll {
    [[NSFileManager defaultManager] removeItemAtPath:[SLFBaseModel getPaht:@"history"] error:nil];
    self.houseList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
    self.carList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
    self.idleList = (NSMutableArray<GX_SearchInfoModel> *)[NSMutableArray arrayWithCapacity:3];
}

@end
