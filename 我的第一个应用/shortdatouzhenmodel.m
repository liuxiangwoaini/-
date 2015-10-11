//
//  shortdatouzhenmodel.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-5.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "shortdatouzhenmodel.h"

@implementation shortdatouzhenmodel
- (void)setMeizimodel:(meizi *)meizimodel
{
    _meizimodel = meizimodel;
    self.coordinate = meizimodel.coordinate;
}
@end
