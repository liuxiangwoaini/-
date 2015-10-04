
//  ViewController.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-27.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#define apikey @"1457ac3d0f915dfd1d64757c49d811ff"
#import "MBProgressHUD+MJ.h"

#import "pageVC.h"
#import "chooseVc.h"


#import "ViewController.h"
#import "TableViewController.h"
#import "chooseVc.h"

@interface ViewController ()<chooseVcdelegate>
- (IBAction)btnclick:(id)sender;
- (IBAction)pushtopageVC;
@property (weak, nonatomic) IBOutlet UITextField *serchcity;
@property (weak, nonatomic) IBOutlet UILabel *returncity;
@property (weak, nonatomic) IBOutlet UILabel *water;
@property (weak, nonatomic) IBOutlet UILabel *pm;
@property (weak, nonatomic) IBOutlet UILabel *wendu;
@property (nonatomic, strong) NSDictionary *weatherdict;
@property (weak, nonatomic) IBOutlet UILabel *tianqi;


@property (strong, nonatomic) NSArray *plistarray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.serchcity.text = @"beijing";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"country-field"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"country-field"] forState:UIControlStateHighlighted];
    btn.frame = (CGRect){0,0,btn.currentBackgroundImage.size};
//    [btn addTarget:self action:@selector(chooseVC) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
        [self getweatherWithcity:city];
    };
    
    
//    self.leftbaritem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"10-rain-storm"]];
//    [self getweatherWithcity:@"city=beijing"];
//    NSLog(@"%@",self.weatherdict);
//    NSString *httpUrl = @"http://apis.baidu.com/heweather/weather/free";
//    NSString *httpArg = @"city=beijing";
//    [self request: httpUrl withHttpArg: httpArg];
}


//"basic": {  //基本信息
//    "city": "北京",  //城市名称
//    "cnty": "中国",  //国家
//    "id": "CN101010100",  //城市ID，参见http://www.heweather.com/documents/cn-city-list
//    "lat": "39.904000",  //城市维度
//    "lon": "116.391000",  //城市经度
//    "update": {  //更新时间
//        "loc": "2015-07-02 14:44", //当地时间
//        "utc": "2015-07-02 06:46"  //UTC时间
//    }
//},
//
//"now": { //实况天气
//    "cond": { //天气状况
//        "code": "100", //天气状况代码
//        "txt": "晴" //天气状况描述
//    },
//    "fl": "30", //体感温度
//    "hum": "20%", //相对湿度（%）
//    "pcpn": "0.0", //降水量（mm）
//    "pres": "1001", //气压
//    "tmp": "32", //温度
//    "vis": "10", //能见度（km）
//    "wind": { //风力风向
//        "deg": "10", //风向（360度）
//        "dir": "北风", //风向
//        "sc": "3级", //风力
//        "spd": "15" //风速（kmph）
//    }
//},




- (NSArray *)plistarray
{
    if (_plistarray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tianqiqingkuang.plist" ofType:nil];
        
        _plistarray = [NSArray arrayWithContentsOfFile:path];
    }
    return _plistarray;
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





- (void)getweatherWithcity:(NSString *)city
{
//    self.weatherdict = nil;
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
            self.weatherdict = dict;
//            NSLog(@"%@", dict[@"HeWeather data service 3.0"]);
            [self setweather];
            [self setbackgroud];
            [self setuplocalnotification];
           
        }
    }];
    
}

- (void)setuplocalnotification
{
    NSArray *array= self.weatherdict[@"HeWeather data service 3.0"];
    NSString *wendu = array[0][@"now"][@"tmp"];
    NSString *tianqi = array[0][@"now"][@"cond"][@"txt"];
    NSString *kongqi = array[0][@"aqi"][@"city"][@"qlty"];
    NSString *jianyi = array[0][@"suggestion"][@"comf"][@"txt"];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.alertAction = @"您好，今天的天气情况是";
    NSString *full = [NSString stringWithFormat:@"温度是%@度，天气情况是%@, 空气状况%@, 建议您%@", wendu, tianqi, kongqi, jianyi];
    noti.alertBody = full;
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
//    noti.repeatInterval = 
    noti.applicationIconBadgeNumber = 5;
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

- (void)setbackgroud
{
    NSArray *array= self.weatherdict[@"HeWeather data service 3.0"];
    
    NSString *code = array[0][@"now"][@"cond"][@"code"];
    if (!code) {
        [MBProgressHUD showError:@"没有找到这个城市"];
#warning gcd的本质问题,什么时候执行哪个，搞不懂啊,
        [self performSelector:@selector(dismiss) withObject:self afterDelay:3];
    }
    for (NSDictionary *dict in self.plistarray) {
        if ([dict[@"code"] isEqualToString:code]) {;
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:dict[@"imagename"]]];
        }
    }
    
    
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: apikey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else {
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   NSLog(@"%@",dict);

                               }
                           }];
}

- (IBAction)btnclick:(id)sender {
    
    NSString *temp = [NSString stringWithFormat:@"city=%@", self.serchcity.text];
 
    
    [self getweatherWithcity:temp];
    
//    [NSThread sleepForTimeInterval:4.0];
//    [self setweather];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"table"]) {
        TableViewController *tableVC = segue.destinationViewController;
        tableVC.array = self.weatherdict[@"HeWeather data service 3.0"];
    }
    else if([segue.identifier isEqualToString:@"choose"])
    {
        chooseVc *choose = segue.destinationViewController;
        choose.delegate =self;
    }


    [super prepareForSegue:segue sender:sender];
}



- (void)choosecitywithcode:(NSInteger)code
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"56.plist" ofType:nil];
    NSArray *citys = [NSArray arrayWithContentsOfFile:path];
    NSInteger a = code - 2;
    NSDictionary *dict = citys[a];
//    NSLog(@"%@",dict[@"pinyin"]);
    NSString *temp = [NSString stringWithFormat:@"city=%@", dict[@"pinyin"]];
    [self getweatherWithcity:temp];
}

- (void)choosecitywithstring:(NSString *)string
{
    NSString *temp = [NSString stringWithFormat:@"city=%@", string];
    [self getweatherWithcity:temp];
}


@end
