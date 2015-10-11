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
#import <AddressBookUI/AddressBookUI.h>
#import "citychoose.h"
#import <CoreText/CoreText.h>
@interface chooseVc()<UISearchBarDelegate, CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate,citychooseVcdelegate, UITextFieldDelegate>
- (IBAction)pickViewOut;
@property (weak, nonatomic) IBOutlet UITextField *citychoose3;

@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UISearchBar *serchBar;
//@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UILabel *weizhi;
- (IBAction)dingwei;
@property (strong , nonatomic) NSArray *citys;
@property (strong , nonatomic) NSMutableArray *btns;
@property (nonatomic, assign) NSInteger ro1;
@property (nonatomic, assign) NSInteger ro2;
@property (nonatomic, assign) NSInteger ro3;
@property (nonatomic, assign) NSInteger componen;
@property (strong ,nonatomic) NSMutableArray *searchcahes;
@property (strong, nonatomic) CLLocationManager *manage;
@property (strong , nonatomic) UITableView *tableview;
@property (strong, nonatomic) UILabel *lable;
@property (strong, nonatomic) NSArray *areas;
@property (weak, nonatomic) UIPickerView *pickview;
@property (strong , nonatomic) NSMutableArray *dizhi;
@property (strong , nonatomic) UIView *contentview;

@end

@implementation chooseVc

- (UIView *)contentview
{
    if (_contentview == nil) {
        _contentview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 266, 320, 266)];
        _contentview.backgroundColor = [UIColor blueColor];
        _contentview.userInteractionEnabled = YES;
    }
    return _contentview;
}
- (NSMutableArray *)dizhi
{
    if (_dizhi == nil) {
        _dizhi = [NSMutableArray array];
        _dizhi[0]= @"北京市";
        _dizhi[1]= @"北京市";
        _dizhi[2]= @"东城区";
    }
    
    return _dizhi;
}
- (UILabel *)lable
{
    if (_lable == nil) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _lable.font = [UIFont systemFontOfSize:13];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.backgroundColor = [UIColor greenColor];
        
    }
    return _lable;
}
- (IBAction)dingwei {
        [self getcurrentlocation];
}

- (NSArray *)areas
{
    if (_areas == nil) {
  
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        _areas = [NSArray arrayWithContentsOfFile:path];
//        NSLog(@"%@",_areas);
    }
    
    return _areas;
}

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
    self.view.userInteractionEnabled =YES;
    [self addbtns];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(wanchengbtnclick) forControlEvents:UIControlEventTouchUpInside];
    btn.userInteractionEnabled = YES;
    self.contentview.userInteractionEnabled = YES;
    
    [self.contentview addSubview:btn];
    self.bottomview.userInteractionEnabled = YES;
    self.serchBar.delegate =self;
    [self setuphotcitys];
    self.citychoose3.delegate =self;
    UITableView *table= [[UITableView alloc] init];
    [self.view addSubview:table];
    self.tableview = table;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    NSString *weizhi = [[NSUserDefaults standardUserDefaults] objectForKey:@"weizhi"];
    self.weizhi.text = weizhi;
    UIPickerView *pick = [[UIPickerView alloc] init];
    pick.frame = CGRectMake(0, 50, 320, 216);
//    pick.backgroundColor = [UIColor blueColor];
    pick.dataSource =self;
    pick.delegate =self;
//    pick.frame = 
    pick.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
//    pick.frame = CGRectMake(0, 0, 200, 100);
    pick.showsSelectionIndicator = YES;
#warning pickview的frame问题， 显示选中哪一行问题
    
    self.pickview = pick;
    
    [self.contentview addSubview:pick];
    
    
}
/**
 
 这里可以拿到选择了哪个城市，进行页面跳转
 
 */
- (void)wanchengbtnclick
{
    NSString *dizhi = [NSString stringWithFormat:@"%@%@%@", self.dizhi[0],self.dizhi[1],self.dizhi[2]];
    
    NSLog(@"%@", dizhi);
    [self.contentview removeFromSuperview];
}
#warning 弹出的pickview怎么做
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    lable.font = [UIFont systemFontOfSize:13];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor greenColor];
    
    switch (component) {
        case 0:
          
            
            lable.text = self.areas[row][0];
            
            return lable;
            break;
            
        case 1:
        {
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            NSString *num1 = [NSString stringWithFormat:@"%d", row];
            NSDictionary *dict1 = dict[num1];
            __block NSString *city;
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                city = key;
            }];
            lable.text = city;
            return lable;
            break;
        }
        default:
        {
            
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            NSString *num1 = [NSString stringWithFormat:@"%d", self.ro2];
            NSDictionary *dict1 = dict[num1];
            __block NSString *city;
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                city = key;
            }];
            NSArray *array1 = dict1[city];
            lable.text =array1[row];
            return lable;
            break;
            
            
        }
            
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.areas.count;
            break;
            
        case 1:
        {
            
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            return dict.count;
            break;
        }
        default:
        {
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            NSString *num1 = [NSString stringWithFormat:@"%d", self.ro2];
            NSDictionary *dict1 = dict[num1];
            __block int b ;
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSArray *a = dict1[key];
                b = a.count;
            }];
            return b;
//            NSString *num = [NSString stringWithFormat:@"%d", self.ro1];
//            NSString *num1 = [NSString stringWithFormat:@"%d", self.ro2];
//            NSArray *array =  self.areas[num];
//            NSDictionary *dict = array[1];
//            NSDictionary *dict1 = dict[num1];
//            NSString *key =  [[dict1 keyEnumerator] nextObject];
//            NSArray *array1 =  dict1[key];
//            
//            return array1.count;
            
            break;
            
        }
    }
}


//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//
//    
//    
//    switch (component) {
//        case 0:
//            
//            return self.areas[row][0];
//            
//            break;
//            
//        case 1:
//        {
//            NSArray *array =  self.areas[self.ro1];
//            NSDictionary *dict = array[1];
//            NSString *num1 = [NSString stringWithFormat:@"%d", row];
//            NSDictionary *dict1 = dict[num1];
//            __block NSString *city;
//            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                
//                city = key;
//            }];
//            
//            return city;
//            break;
//        }
//        default:
//        {
//           
//            NSArray *array =  self.areas[self.ro1];
//            NSDictionary *dict = array[1];
//            NSString *num1 = [NSString stringWithFormat:@"%d", self.ro2];
//            NSDictionary *dict1 = dict[num1];
//            __block NSString *city;
//            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                
//                city = key;
//            }];
//            NSArray *array1 = dict1[city];
//            
//            return array1[row];
//            break;
//    
//        
//        }
//        
//        }
//
//    
//    
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addSubview:self.contentview];
    [self.view endEditing:YES];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            NSString *shengfen =  self.areas[row][0];
            NSDictionary *shengfendict =  self.areas[row][1][@"0"];
            __block NSString *city1;
            [shengfendict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                city1 = key;
            }];
            
            NSArray *array1 = shengfendict[city1];
            
            NSLog(@"sheng== %@", shengfen);
            self.dizhi[0] = shengfen;
            self.dizhi[1] = city1;
            self.dizhi[2] = array1[0];
            
            self.ro1 = row;
            [pickerView reloadAllComponents];
            break;
        }
        case 1:
            
        {
            
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            NSString *num1 = [NSString stringWithFormat:@"%d", row];
            NSDictionary *dict1 = dict[num1];
            __block NSString *city;
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                city = key;
            }];
            NSArray *array1 = dict1[city];
            NSLog(@"shi== %@", city);
            self.dizhi[1] = city;
            self.dizhi[2] = array1[0];
            self.ro2 = row;
            [pickerView reloadComponent:2];
            [pickerView reloadComponent:1];
            break;
        }
        default:
        {
            NSArray *array =  self.areas[self.ro1];
            NSDictionary *dict = array[1];
            NSString *num1 = [NSString stringWithFormat:@"%d", self.ro2];
            NSDictionary *dict1 = dict[num1];
            __block NSString *city;
            [dict1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                
                city = key;
            }];
            NSArray *array1 = dict1[city];
            
            NSString *qu = array1[row];
            self.dizhi[2] = city;
            NSLog(@"qu== %@", qu);
            self.ro3 = row;
            [pickerView reloadComponent:1];
            break;
        }
        }
    
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
    [manager requestWhenInUseAuthorization];
    [manager startUpdatingLocation];
    self.manage =manager;
    
    
    
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.manage startUpdatingLocation];
    [super viewWillAppear:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
     [self.manage stopUpdatingLocation];
    [[NSUserDefaults standardUserDefaults] setObject:self.weizhi.text forKey:@"weizhi"];
    [super viewWillDisappear:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *geo = [[CLGeocoder alloc] init];
//    NSLog(@"%@", location);
#warning 地理位置看反编码失败，下面这个方法进不去
#warning 这个方法有时进得去，有时进不去，真是日了狗了
    
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"%@--- %d", error.localizedDescription, error.code);
        }
        if (placemarks > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *city = placemark.addressDictionary[@"City"];
//            NSString *Street = placemark.addressDictionary[@"Street"];
//            NSString *SubLocality = placemark.addressDictionary[@"SubLocality"];
//            NSString *fullcity =
            NSUInteger length = city.length;
            NSString *fullcity;
            if (length > 5) {
                fullcity = [city substringToIndex:2];
            }else
            {
                fullcity = [city substringToIndex:length-1];
            }
            self.weizhi.text = fullcity;
            
//            NSString *fullcity = [self transformZhongwenToPinyin:city];
            if ([self.delegate respondsToSelector:@selector(choosecitywithstring:)]) {
                
                [MBProgressHUD showMessage:@"定位完成，正在跳转。。。"];
//                [NSThread sleepForTimeInterval:2.0];
                
                
                
                [self performSelector:@selector(dismiss) withObject:self afterDelay:3];
//
////                [MBProgressHUD hideHUD];
//                dispatch_after(2.0, dispatch_get_main_queue(), ^{
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                });
                
                [self.delegate choosecitywithstring:fullcity];
                
            }
            
//

        }

    }];
    


    
}


//- (NSString *)transformZhongwenToPinyin:(NSString *)zhongwen
//{
//    
//    CFMutableStringRef string = (__bridge CFMutableStringRef)zhongwen;
//    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
//    NSString *hehe = (__bridge NSString *)string;
//    return hehe;
//}

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
- (void)citybtnclick:(NSString *)cityname
{
    NSString *city;
    NSInteger length = cityname.length;
    if (length >= 5) {
        city = [cityname substringToIndex:2];
    }else{
    city = [cityname substringToIndex:length-1];
    }
    NSLog(@"%@", city);
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    citychoose *city = segue.destinationViewController;
    city.delegate = self;
    [super prepareForSegue:segue sender:sender];
}

- (IBAction)pickViewOut {

}
@end
