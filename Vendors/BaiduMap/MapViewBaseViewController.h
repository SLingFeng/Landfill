//
//  MapViewBaseDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#define startUserLocation @"startUserLocation"
#define stopUserLocation @"stopUserLocation"

@interface MapViewBaseViewController :  BaseViewController <BMKMapViewDelegate, BMKLocationServiceDelegate>
{
//    IBOutlet BMKMapView* _mapView;
    
}
@property (nonatomic, retain) BMKMapView * mapView;
@property (nonatomic, retain) BMKLocationService * locService;
@property (nonatomic, retain) BMKUserLocation * nowUserLocation;
@property (nonatomic) CLLocationCoordinate2D nowCenterCoordinate;
@property (nonatomic, copy) void(^userLoactionChange)();
//跟随态
-(void)startFollowing;
@end
