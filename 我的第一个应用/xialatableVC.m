//
//  xialatableVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//
#define apikey @"1457ac3d0f915dfd1d64757c49d811ff"
#import "xialatableVC.h"
#import "xialaCell.h"
#import "MJRefresh.h"
@interface xialatableVC ()
@property (nonatomic, strong) NSDictionary *weatherdict;
@end

@implementation xialatableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closebtnclick) name:@"btnclick" object:nil];
//    [self getweatherWithcity:self.cityname];
    self.tableView.rowHeight =300;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self getweatherWithcity:self.cityname];
            [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"放开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:20];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:20];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.header = header;
//    [header beginRefreshing];
//    self.view.backgroundColor = [UIColor greenColor];
    
}

- (void)shuaxin
{

    [self.tableView.header endRefreshing];
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
//            NSArray *array= dict[@"HeWeather data service 3.0"];
            
//            NSString *city = array[0][@"basic"][@"city"];
            
            
            
            if (dict == nil) {
                return ;
            }
            self.weatherdict = dict;
            //            NSLog(@"%@", dict[@"HeWeather data service 3.0"]);
           
            
            
            
        }
    }];
    
}


- (void)closebtnclick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    xialaCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"xiala"];
    if (Cell == nil) {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"xialaCell" owner:nil options:nil] lastObject];
    }
    NSArray *array= self.weatherdict[@"HeWeather data service 3.0"];
    Cell.array = array;

    
    return Cell;
}


@end
