//
//  NHPointAnnotation.h
//  NaHu
//
//  Created by SADF on 16/11/16.
//  Copyright © 2016年 SADF. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
@class ChargePileInfoModel;

@interface NHPointAnnotation : BMKPointAnnotation
@property (nonatomic, retain) ChargePileInfoModel * pileInfo;
@end
