//
//  searchVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "searchVC.h"

@interface searchVC ()

@end

@implementation searchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _poisearch = [[BMKPoiSearch alloc]init];
    
    _cityText.text = @"北京";
    _keyText.text  = @"餐厅";
}



-(IBAction)onClickOk
{
     curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
    
}


//-(IBAction)onClickNextPage
//{
//    curPage++;
//    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
//    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
//    citySearchOption.pageIndex = curPage;
//    citySearchOption.pageCapacity = 10;
//    citySearchOption.city= _cityText.text;
//    citySearchOption.keyword = _keyText.text;
//    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
//    if(flag)
//    {
//        _nextPageButton.enabled = true;
//        NSLog(@"城市内检索发送成功");
//    }
//    else
//    {
//        _nextPageButton.enabled = false;
//        NSLog(@"城市内检索发送失败");
//    }
//    
//}


- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            NSLog(@"%@--%@", poi.pt, poi.name);
//            [annotations addObject:item];
        }
//        [_mapView addAnnotations:annotations];
//        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

@end
