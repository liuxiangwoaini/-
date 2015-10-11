//
//  zhouweimeizi.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "zhouweimeizi.h"
#import "UIImageView+WebCache.h"
#import "xiangxiVC.h"
#import "meizicell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
@interface zhouweimeizi ()
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) NSMutableArray *meizis;
@property (strong, nonatomic) NSMutableArray *dicts;
@end

@implementation zhouweimeizi


- (NSMutableArray *)meizis
{
    if (_meizis == nil) {
        _meizis = [NSMutableArray array];
    }
    return _meizis;
}
- (NSMutableArray *)dicts
{
    if (_dicts == nil) {
        _dicts = [NSMutableArray array];
    }
    return _dicts;
}
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"meizi.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSInteger num = self.num;
        for (int i = 0; i < num; i ++) {
            NSInteger num1 = arc4random_uniform(130);
            id obj = array[num1];
            [self.meizis addObject:obj];
        }
        _datas =self.meizis;
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [MBProgressHUD showMessage:@"正在刷新周围的妹子。。。。"];
        
        
        [self performSelector:@selector(close) withObject:self afterDelay:3];
        
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
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [MBProgressHUD showMessage:@"正在加载更多的妹子。。。。"];
        [self performSelector:@selector(footclose) withObject:self afterDelay:3];
    }];
   
    self.tableView.footer = footer;
    
    

}


- (void)footclose
{
    [self.tableView.footer endRefreshing];
    
    
    
    [MBProgressHUD hideHUD];
    
    NSInteger num = arc4random_uniform(10);
    NSString *str = [NSString stringWithFormat:@"%d.plist",num];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    [self.datas addObjectsFromArray:array];
    [self.tableView reloadData];
    
}

- (void)close
{
    
    
    [self.tableView.header endRefreshing];
    
    
  
    [MBProgressHUD hideHUD];
    
    self.datas = nil;
    self.num = arc4random_uniform(20);
    NSString *str = [NSString stringWithFormat:@"此次刷新%d只ji", self.num];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"刷新完成" message:str delegate:nil cancelButtonTitle:@"呵呵" otherButtonTitles:nil, nil];
    [alert show];
    [self.tableView reloadData];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.datas[indexPath.row];
    
    static NSString *ID = @"hehe";
    meizicell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"meizicell" owner:nil options:nil] lastObject];
    }
    
    cell.dict = dict;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.datas[indexPath.row];
    [self.dicts addObject:dict];
    [self cellchoose];
}

- (void)cellchoose
{
    xiangxiVC *vc = [[xiangxiVC alloc] init];
    vc.dict = [self.dicts lastObject];
    NSLog(@"%@", [self.dicts lastObject]);
    [self.navigationController pushViewController:vc animated:YES];
}



@end
