//
//  searchVC.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface searchVC : UIViewController<BMKPoiSearchDelegate>
{
    IBOutlet UITextField* _cityText;
    IBOutlet UITextField* _keyText;
    int curPage;
    BMKPoiSearch* _poisearch;
}
-(IBAction)onClickOk;
@end
