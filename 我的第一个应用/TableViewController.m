//
//  TableViewController.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    NSLog(@"%@", self.array[0][@"daily_forecast"]);

}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray *temp = self.array[0][@"daily_forecast"];
    return temp.count;
   
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    TableViewCell *Cell= [tableView dequeueReusableCellWithIdentifier:ID];
    if (Cell == nil) {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] lastObject];
        
        
    }
    Cell.tag = indexPath.row;
    
    Cell.array = self.array[0][@"daily_forecast"][indexPath.row];
    return Cell;
}



@end
