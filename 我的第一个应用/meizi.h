//
//  meizi.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface meizi : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
