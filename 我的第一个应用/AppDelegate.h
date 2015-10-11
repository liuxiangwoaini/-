//
//  AppDelegate.h
//  我的第一个应用
//
//  Created by liuxiang on 15-9-27.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

  




@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager * _mapManager;
}

@property (strong, nonatomic) UIWindow *window;
@end

