//
//  chooseVc.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//
#define apikey @"1457ac3d0f915dfd1d64757c49d811ff"
#import "chooseVc.h"
#define btnnumber 10
#define border1 10
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "MBProgressHUD+MJ.h"

@interface chooseVc()<UISearchBarDelegate, CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UISearchBar *serchBar;
//@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (strong , nonatomic) NSArray *citys;
@property (strong , nonatomic) NSMutableArray *btns;
@property (strong ,nonatomic) NSMutableArray *searchcahes;
@property (strong, nonatomic) CLLocationManager *manage;
@property (strong , nonatomic) UITableView *tableview;
@end

@implementation chooseVc

- (NSArray *)citys
{
    if (_citys == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"56.plist" ofType:nil];
        _citys = [NSArray arrayWithContentsOfFile:path];
        
    }
    return _citys;
}

- (NSMutableArray *)btns
{
    if (_btns == nil) {
       
        _btns = [NSMutableArray array];
        
    }
    return _btns;
}

- (NSMutableArray *)searchcahes
{
    if (_searchcahes == nil) {
        _searchcahes = [NSMutableArray array];
    }
    return _searchcahes;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addbtns];
    self.bottomview.userInteractionEnabled = YES;
    self.serchBar.delegate =self;
    [self setuphotcitys];
    [self getcurrentlocation];
    UITableView *table= [[UITableView alloc] init];
    [self.view addSubview:table];
    self.tableview = table;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)addbtns
{
    for (int i = 0 ; i < btnnumber; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [self.bottomview addSubview:btn];
        [self.btns addObject:btn];
    }
}


- (void)setuphotcitys
{
    CGFloat btnW =  70;
    CGFloat btnH = 30;
    for (int i = 0; i < btnnumber; i++) {
        
        NSDictionary *dict = self.citys[i];
        UIButton *btn = self.btns[i];
        [btn setTitle:[NSString stringWithFormat:@"%@", dict[@"city"]] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", dict[@"city"]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = [dict[@"code"] doubleValue];
        btn.backgroundColor = [UIColor redColor];
        CGFloat btnX = (i % 4) * (btnW + border1);
        CGFloat btnY =  (i / 4) * (btnH + border1);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.titleLabel.frame = CGRectMake(0, 0, 70, 30);
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
}


- (void)btnclick:(UIButton *)btn
{
//    for (NSDictionary *dict in self.citys) {
//        if ([dict[@"code"] isEqualToString:[NSString stringWithFormat:@"%d", btn.tag]]) {
//            NSString *ttyname =dict[@"city"];
//        }
//    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(choosecitywithcode:)]) {
        
        [MBProgressHUD showMessage:@"正在搜索"];
        [self.delegate choosecitywithcode:btn.tag];
        [self performSelector:@selector(dismiss) withObject:self afterDelay:3];
        
        
        
    }

}

- (void)dismiss
{
    [MBProgressHUD hideHUD];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchcahes addObject:searchBar.text];
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullpath = [path stringByAppendingPathComponent:@"caches.plist"];
    [self.searchcahes writeToFile:fullpath atomically:YES];
    
    if ([self.delegate respondsToSelector:@selector(choosecitywithstring:)]) {
        
        [MBProgressHUD showMessage:@"正在搜索"];
       

        [self.delegate choosecitywithstring:searchBar.text];
         [self performSelector:@selector(dismiss) withObject:self afterDelay:3];
            
  
    }

    
    }


/**
 获得用户当前位置，返回位置字符串
 */
- (NSString *)getcurrentlocation
{
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate =self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
    self.manage =manager;
    
    
    
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.manage startUpdatingLocation];
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.manage stopUpdatingLocation];
    [super viewWillDisappear:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    NSLog(@"%@", location);
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"%@--- %d", error.localizedDescription, error.code);
        }
        if (placemarks > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *city = placemark.addressDictionary[@"locality"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"asdad" message:city delegate:nil cancelButtonTitle:city otherButtonTitles:city,nil];
            [alert show];
        }

    }];
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"dasd");
    }];
    
    [geo geocodeAddressString:@"beijing" completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"dasd");
    }];
//    [self addressfromlocation:location];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullpath = [path stringByAppendingPathComponent:@"caches.plist"];
    
    self.searchcahes = [NSMutableArray arrayWithContentsOfFile:fullpath];
//    NSLog(@"%@", self.searchcahes);
    CGFloat tableW = 320;
    CGFloat tableH = 300;
    CGFloat tablex = searchBar.frame.origin.x;
    
    CGFloat tableY = CGRectGetMaxY(searchBar.frame);
    self.tableview.frame = CGRectMake(tablex, tableY, tableW, tableH);

//    [self.tableview reloadData];
}

- (void)addressfromlocation:(CLLocation *)location
{
    
  
    NSString *httpArg =[NSString stringWithFormat:@"lat=%f&lng=%f&cst=1", location.coordinate.latitude, location.coordinate.longitude];
    NSString *httpUrl = @"http://apis.baidu.com/wxlink/here/here";
//    NSString *httpArg = @"lat=39.9928&lng=116.396&cst=1";
    
    

        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        NSURL *url = [NSURL URLWithString: urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: apikey forHTTPHeaderField: @"apikey"];
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: [NSOperationQueue mainQueue]
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       NSLog(@"Httperror: %@%d", error.localizedDescription, error.code);
                                   } else {
                                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                       NSString *result = dict[@"result"];
                                       NSRange ranege =  [result rangeOfString:@"DistrictName"];
                                       NSLog(@"%d", ranege.location);
//                                       NSLog(@"%@", dict1[@"DistrictName"]);
                                   }
                               }];

    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchcahes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hehe";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    cell.textLabel.text = self.searchcahes[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *city =  self.searchcahes[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(choosecitywithstring:)]) {
        [MBProgressHUD showMessage:@"正在搜索"];
        
        dispatch_queue_t queue = dispatch_queue_create("asd", DISPATCH_QUEUE_SERIAL);
#warning 用gcd设置方法执行顺序，
        
        
            [self performSelector:@selector(dismiss) withObject:self afterDelay:3];
        
        
            [self.delegate choosecitywithstring:city];
    

    }


}

@end
