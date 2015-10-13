//
//  TableViewController.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "MJRefresh.h"
@interface TableViewController ()<tabeleviewCelldelegate>
@property (nonatomic, strong) NSMutableArray *muarray;
@end

@implementation TableViewController

//- (NSMutableArray *)muarray
//{
//    if (_muarray == nil) {
//        _muarray = [NSMutableArray array];
//    }
//    return _muarray;
//}
- (void)viewDidLoad {
//    self.muarray = (NSMutableArray *)self.array[0][@"daily_forecast"];
    self.muarray = [NSMutableArray arrayWithArray:self.array[0][@"daily_forecast"]];
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(3.0, dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
    }];
    
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"放开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.header =header;
    self.view.backgroundColor = [UIColor greenColor];
    

}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return self.muarray.count;
   
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *ID = @"cell";
    
    TableViewCell *Cell= [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (Cell == nil) {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];
        
        
    }
    Cell.transform = CGAffineTransformIdentity;
    Cell.tag = indexPath.row;
    Cell.delegate = self;
    Cell.array = self.muarray[indexPath.row];
//    Cell.array = @[@"asdas", @"dawdas", @"asdas", @"dawdas",@"asdas", @"dawdas",];
#warning 用来递归打印所有子视图的私有法方法
//#ifdef DEBUG
//    NSLog(@"Cell recursive description:\n\n%@\n\n", [Cell performSelector:@selector(recursiveDescription)]);
//#endif
    return Cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [self.muarray removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }else
    {
        NSLog(@"not delete");
    }

}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}

- (void)cellbtncliclWithstring:(NSString *)str
{
    NSLog(@"%@", str);
}

@end
