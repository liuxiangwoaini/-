//
//  shoucangmeiziVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-14.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "shoucangmeiziVC.h"
#import "shoucangmeiziCell.h"
#import "shoucangxiangxiVC.h"

@interface shoucangmeiziVC ()<shoucangxiangxiVCdelegate>
@property (strong, nonatomic) NSMutableArray *datas;
@end

@implementation shoucangmeiziVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
    

}

- (void)setPhonelist:(NSMutableArray *)phonelist
{
    _phonelist = phonelist;

    self.datas = phonelist;
    
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
    
    static NSString *ID = @"shoucang";
    shoucangmeiziCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"shoucangmeiziCell" owner:nil options:nil] lastObject];
    }
    
    cell.dict = dict;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.datas[indexPath.row];
    shoucangxiangxiVC *vc = [[shoucangxiangxiVC alloc] init];
    vc.dict = dict;
    vc.delegate  =self;
    vc.index = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)shoucangswitchonwithphonenumber:(NSDictionary *)dict1 anddelte:(NSIndexPath *)indexpath
{
//    NSMutableArray *temp = [NSMutableArray array];
//    [self.datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if (![dict1 == obj]) {
//            [temp addObject:obj];
//        }
//    }];
//    self.datas = temp;
//    NSLog(@"%d--%d", indexpath.row, indexpath.section);
    [self.datas removeObjectAtIndex:indexpath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationTop];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullpath = [path stringByAppendingPathComponent:@"shoucang.plist"];
    [self.datas writeToFile:fullpath atomically:YES];
    
}


@end
