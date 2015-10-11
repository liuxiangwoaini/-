//
//  shortdatouzhenmodel.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "meizi.h"
@interface shortdatouzhenmodel : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) meizi *meizimodel;
@end
