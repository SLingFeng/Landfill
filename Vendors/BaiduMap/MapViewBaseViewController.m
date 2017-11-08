//
//  MapViewBaseDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "MapViewBaseViewController.h"

@interface MapViewBaseViewController()<UIGestureRecognizerDelegate>
{
//    BOOL enableCustomMap;
    BOOL _isNotFirstInit;
    BMKPoiSearch *_searcher;
}
@end

@implementation MapViewBaseViewController

//+ (void)initialize {
    //设置自定义地图样式，会影响所有地图实例
    //注：必须在BMKMapView对象初始化之前调用
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config_清新蓝" ofType:@""];
//    [BMKMapView customMapStyle:path];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49)];
    [self.view addSubview:_mapView];
    self.mapView.showMapScaleBar = 1;
//    [self addCustomGestures];//添加自定义的手势
    
    self.locService = [[BMKLocationService alloc] init];
    _locService.desiredAccuracy = 70;
    _locService.delegate = self;
    [self startLocation];
    
    //搜索功能只需要将调用jiansuo方法更换为对应button即可
    self.mapView.zoomLevel = 14;
    self.nowUserLocation = [[BMKUserLocation alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startUserLocating) name:startUserLocation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopUserLocating) name:stopUserLocation object:nil];
}

-(void)startUserLocating {
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

-(void)stopUserLocating {
    _mapView.showsUserLocation = NO;
    _locService.delegate = nil;
    [_locService stopUserLocationService];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
//    [self startFollowing];
    
}
//进入普通定位态
-(void)startLocation {
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

-(void)viewWillDisappear:(BOOL)animated {
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil

}
//停止定位
-(void)stopLocation {
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _locService.delegate = nil;
        [self stopLocation];
        _mapView = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}
- (void)jiansuo
{
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
    option.pageIndex = 0;
    option.pageCapacity = 10;
    CLLocationCoordinate2D location  =CLLocationCoordinate2DMake(39.915, 116.404);
    option.location = location;
    option.keyword = @"小吃";
    option.radius = 80000;
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}


#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//    [alert show];
//    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    //        if (self.nowUserLocation.location.coordinate.latitude == mapView.centerCoordinate.latitude && self.nowUserLocation.location.coordinate.longitude == mapView.centerCoordinate.longitude) {
    //            _isNotFirstInit = 1;
    //        }else {
    //        }
    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.nowCenterCoordinate = mapView.centerCoordinate;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    self.nowUserLocation = userLocation;
    [CommonTools shareTools].userLocation = userLocation;
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if (_isNotFirstInit == NO) {
        _isNotFirstInit = 1;
        [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:1];
    }
    
    if (self.userLoactionChange) {
        self.userLoactionChange();
    }
    self.nowUserLocation = userLocation;
    [CommonTools shareTools].userLocation = userLocation;
    [_mapView updateLocationData:userLocation];
    
}

-(void)setLocation {

}

#pragma mark - 状态切换
//跟随态
-(void)startFollowing {
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}

#pragma mark - 添加自定义的手势（若不自定义手势，不需要下面的代码）

- (void)addCustomGestures {
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    NSLog(@"my handleSingleTap");
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    NSLog(@"my handleDoubleTap");
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
