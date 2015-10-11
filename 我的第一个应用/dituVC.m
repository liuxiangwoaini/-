//
//  dituVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "dituVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LXannotation.h"
#import "shortdatouzhenmodel.h"
@interface dituVC ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (strong,nonatomic) NSArray *datas;
- (IBAction)zhaoji;

- (IBAction)backtocenter:(id)sender;
@end

@implementation dituVC



- (NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"meizis.plist" ofType:nil];
        
        _datas = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapview.userTrackingMode = MKUserTrackingModeFollow;
    self.mapview.delegate =self;
    
}

- (void)viewtap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:tap.view];
    CLLocationCoordinate2D coordinate = [self.mapview convertPoint:point toCoordinateFromView:self.mapview];
 
    // 3.创建大头针模型，添加大头针到地图上
    LXannotation *annotation = [[LXannotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"asda";
    annotation.subtitle = @"dasdasd";
    [self.mapview addAnnotation:annotation];
    
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [mapView setRegion:region animated:YES];
    
}
//typedef struct {
//    CLLocationDegrees latitude;
//    CLLocationDegrees longitude;
//} CLLocationCoordinate2D;


- (IBAction)zhaoji {
    LXannotation *anno0 = [[LXannotation alloc] init];
    anno0.title = @"xxx大饭店";
    anno0.subtitle = @"全场一律15折，会员20折";
    anno0.coordinate = CLLocationCoordinate2DMake(39, 115);
    anno0.icon = @"category_1";
    [self.mapview addAnnotation:anno0];
    
    // 2.电影
    LXannotation *anno1 = [[LXannotation alloc] init];
    anno1.title = @"xxx影院";
    anno1.subtitle = @"最新大片：美国队长2，即将上映。。。";
    anno1.coordinate = CLLocationCoordinate2DMake(40, 120);
    anno0.icon = @"category_2";
    [self.mapview addAnnotation:anno1];

    
}

- (IBAction)backtocenter:(id)sender {
    [self.mapview setCenterCoordinate:self.mapview.userLocation.location.coordinate animated:YES];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    static NSString *ID = @"hehe";
//    MKAnnotationView *anView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
//    if (anView == nil) {
//        anView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
//        anView.canShowCallout = YES;
//        anView.leftCalloutAccessoryView =[UIButton buttonWithType:UIButtonTypeContactAdd];
//        anView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        anView.calloutOffset = CGPointMake(0, -10);
//    }
//    anView.annotation = annotation;
////    LXannotation *annotaion = annotation;
////    anView.image = [UIImage imageNamed:annotaion.icon];
//    return anView;
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
//    if (![annotation isKindOfClass:[MJTuangouAnnotation class]]) return nil;
    
    static NSString *ID = @"tuangou";
    // 从缓存池中取出可以循环利用的大头针view
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        // 显示子标题和标题
        annoView.canShowCallout = YES;
        // 设置大头针描述的偏移量
        annoView.calloutOffset = CGPointMake(0, -10);
        // 设置大头针描述右边的控件
        annoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        // 设置大头针描述左边的控件
        annoView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    // 传递模型
    annoView.annotation = annotation;
    
    // 设置图片
    LXannotation *tuangouAnno = annotation;
//    annoView.image = [UIImage imageNamed:tuangouAnno.icon];
    
    return annoView;
}


@end
