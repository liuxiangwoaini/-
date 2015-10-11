//
//  scrollVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//  用来测试下拉刷新
#define apikey @"1457ac3d0f915dfd1d64757c49d811ff"
#import "scrollVC.h"
#import "MJRefresh.h"
#import "lifetableVC.h"

@interface scrollVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *returncity;
@property (weak, nonatomic) IBOutlet UILabel *water;
@property (weak, nonatomic) IBOutlet UILabel *pm;
- (IBAction)closeVC;

@property (nonatomic, strong) NSDictionary *weatherdict;
@property (weak, nonatomic) IBOutlet UILabel *wendu;
@property (weak, nonatomic) IBOutlet UILabel *tianqi;
@property (nonatomic, strong) NSArray *citys;
@end

@implementation scrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getweatherWithcity:self.cityname];
    
    
}




- (void)getweatherWithcity:(NSString *)city
{
    //    self.weatherdict = nil;
    self.cityname =city;
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
    NSString *httpurl = @"http://apis.baidu.com/heweather/weather/free";
    NSString *fullhttpurl = [NSString stringWithFormat:@"%@?%@", httpurl, city];
    //    NSLog(@"%@",fullhttpurl);
    NSURL *url = [NSURL URLWithString:fullhttpurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0];
    request.HTTPMethod  =@"GET";
    [request addValue:apikey forHTTPHeaderField:@"apikey"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"%@------%d", connectionError.description, connectionError.code);
        }else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSArray *array= dict[@"HeWeather data service 3.0"];
            
            NSString *city = array[0][@"basic"][@"city"];
           
            
            
            if (dict == nil) {
                return ;
            }
            self.weatherdict = dict;
            //            NSLog(@"%@", dict[@"HeWeather data service 3.0"]);
            [self setweather];

            
            
        }
    }];
    
}

- (void)setweather;
{
    
    
    NSArray *array= self.weatherdict[@"HeWeather data service 3.0"];
    
    self.returncity.text = array[0][@"basic"][@"city"];
    
    
    self.wendu.text = array[0][@"now"][@"tmp"];
    
    self.tianqi.text =array[0][@"now"][@"cond"][@"txt"];
    self.pm.text =array[0][@"aqi"][@"city"][@"pm25"];
    
    self.water.text =array[0][@"now"][@"pcpn"];
    [self.view endEditing:YES];
    
}



- (IBAction)closeVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"shuaxin"]) {
        scrollVC *vc = segue.destinationViewController;
        vc.cityname =self.cityname;
    }
    else if ([segue.identifier isEqualToString:@"life"])
    {
        lifetableVC *life = segue.destinationViewController;
        life.dict =self.weatherdict[@"HeWeather data service 3.0"][0][@"suggestion"];
    }


    [super prepareForSegue:segue sender:sender];
}




@end
