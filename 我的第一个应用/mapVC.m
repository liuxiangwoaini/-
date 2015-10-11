//
//  mapVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "mapVC.h"
#import <BaiduMapAPI/BMapKit.h>
#import "BMannotation.h"
#import "zhouweimeizi.h"
#import "MBProgressHUD+MJ.h"
@interface mapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate, BMKRadarManagerDelegate,BMKPoiSearchDelegate>
@property (nonatomic ,strong) BMKPoiSearch *search1;
@property (nonatomic ,strong) BMKPoiSearch *search2;
@property (nonatomic ,strong) BMKMapView *mapview;
@end

@implementation mapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(45.7085,126.6258);
    mapView.showMapScaleBar = YES;
    mapView.zoomLevel = 17;
    mapView.showsUserLocation = YES;
    [mapView setCenterCoordinate:coordinate animated:YES];
    mapView.userTrackingMode = BMKUserTrackingModeFollow;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [mapView addGestureRecognizer:tap];
    self.mapview = mapView;
    [self.view addSubview:mapView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 50, 50);
//    [btn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateHighlighted];
    [btn setTitle:@"周边雷达" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self setdingwei];
    [self setleida];
    self.search1 = [[BMKPoiSearch alloc]init];
    self.search2 = [[BMKPoiSearch alloc]init];
    self.search1.delegate = self;
    self.search2.delegate =self;
}


- (void)sousuo
{

}
- (void)setleida
{
    BMKRadarManager *radar = [BMKRadarManager getRadarManagerInstance];
    radar.userId = @"liuxiang";
    [radar addRadarManagerDelegate:self];
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    NSString *zhu = @"car";
    NSString *zhu1 = [zhu stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    myinfo.extInfo = zhu1;//扩展信息
    myinfo.pt = CLLocationCoordinate2DMake(45,126);//我的地理坐标
    //上传我的位置信息
    BOOL res = [radar uploadInfoRequest:myinfo];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 80000;//检索半径
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;//排序方式
    option.centerPt = CLLocationCoordinate2DMake(39.916, 116.404);//检索中心点
    BOOL res1 = [radar getRadarNearbySearchRequest:option];
    if (res1) {
        NSLog(@"get 成功");
    } else {
        NSLog(@"get 失败");
    }
//    BMKNearbySearchOption *op = [[BMKNearbySearchOption alloc] init];
//    op.location =CLLocationCoordinate2DMake(39.916, 116.404);
//    op.radius = 10000;
//    [self.search1 poiSearchNearBy:op];
    
}

- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error
{
    if (error == BMK_RADAR_NO_ERROR) {
       NSLog(@"%@", result.infoList[0]);
    }else
    {
        NSLog(@"get 失败");
    }
    
}

//- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
//{
//    if (errorCode == BMK_SEARCH_NO_ERROR) {
//        NSLog(@"get 成功");
//        NSLog(@"%@", poiResult.poiInfoList);
//    }
//    else
//    {
//        NSLog(@"get 失败");
//    }
//}



- (void)setdingwei
{
    
     BMKLocationService *locService = [[BMKLocationService alloc]init];
    locService.delegate = self;
    //启动LocationService
    [locService startUserLocationService];

    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    [BMKLocationService setLocationDistanceFilter:100.f];
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
}

- (void)tap:(UITapGestureRecognizer *)ges
{
    BMannotation *anno0 = [[BMannotation alloc] init];
    anno0.title = @"三哥ji店";
    anno0.subtitle = @"全场一律15折，会员20折";
    anno0.icon = @"category_1";
    CGPoint point = [ges locationInView:ges.view];
    CLLocationCoordinate2D coor = [self.mapview convertPoint:point toCoordinateFromView:self.mapview];
    anno0.coordinate = coor;
    [self.mapview addAnnotation:anno0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapview viewWillAppear];
    self.mapview.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.mapview viewWillDisappear];
    self.mapview.delegate = nil; // 不用时，置nil
}




- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    static NSString *ID = @"tuangou";
    // 从缓存池中取出可以循环利用的大头针view
    BMKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        // 显示子标题和标题
        annoView.canShowCallout = YES;
        // 设置大头针描述的偏移量
        annoView.calloutOffset = CGPointMake(0, -10);
        // 设置大头针描述右边的控件
//        annoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        // 设置大头针描述左边的控件
//        annoView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    // 传递模型
    annoView.annotation = annotation;
    
    // 设置图片
    BMannotation *tuangouAnno = annotation;
        annoView.image = [UIImage imageNamed:tuangouAnno.icon];
    
    return annoView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    [MBProgressHUD showMessage:@"开始搜索周围妹子。。。"];
    
    [self performSelector:@selector(tiaozhuan) withObject:self afterDelay:3];
    
}

- (void)tiaozhuan
{
    [MBProgressHUD hideHUD];
    NSInteger num = arc4random_uniform(20);
    NSString *str = [NSString stringWithFormat:@"共找到%d只ji", num];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"搜索完成" message:str delegate:nil cancelButtonTitle:@"呵呵" otherButtonTitles:nil, nil];
    [alert show];
    
    zhouweimeizi *meizi = [[zhouweimeizi alloc] init];
    meizi.num = num;
    [self.navigationController pushViewController:meizi animated:YES];
}
@end
