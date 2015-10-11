//
//  longdatouzhenview.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "longdatouzhenview.h"
#import "longdatouzhenmodel.h"
@implementation longdatouzhenview

+ annotationWithMapview:(MKMapView *)mapview
{
    static NSString *ID = @"liuxiang";
    longdatouzhenview *view= (longdatouzhenview *)[mapview dequeueReusableAnnotationViewWithIdentifier:ID];
    if (view== nil) {
        view = [[longdatouzhenview alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    
    return view;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    longdatouzhenmodel *longdatou = annotation;
    self.image = [UIImage imageNamed:longdatou.meizimodel.icon];
}

@end
