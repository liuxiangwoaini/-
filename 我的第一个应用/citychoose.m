//
//  citychoose.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "citychoose.h"

@interface citychoose ()
@property (strong, nonatomic) NSDictionary *dict;
@property (strong ,nonatomic) NSMutableArray *keys;
@property (strong ,nonatomic) NSMutableArray *indexs;
@end




#warning 右边的导航栏怎么做
@implementation citychoose


- (NSMutableArray *)indexs
{
    if (_indexs == nil) {
        _indexs = [NSMutableArray array];
    }
    
    return _indexs;
}
- (NSMutableArray *)keys
{
    if (_keys == nil) {
        _keys = [NSMutableArray array];
    }
    
    return _keys;
}

- (NSDictionary *)dict
{
    if (_dict == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict.plist" ofType:nil];
        _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
        NSArray *array = [_dict allKeys];
        NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        [self.keys addObjectsFromArray:result];
    }

    return _dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    head.backgroundColor = [UIColor greenColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [head addSubview:btn];
    
    self.tableView.tableHeaderView = head;
    
    
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = self.keys[section];
    NSArray *array = self.dict[key];
    return array.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.keys[indexPath.section];
    NSArray *array = self.dict[key];
    
    static NSString *ID = @"hehe";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text =array[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    return key;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.indexs addObject:indexPath];
    NSString *key = self.keys[indexPath.section];
    NSArray *array = self.dict[key];
    if ([self.delegate respondsToSelector:@selector(citybtnclick:)]) {
        [self.delegate citybtnclick:array[indexPath.row]];
    }
    [self close];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
}


@end
