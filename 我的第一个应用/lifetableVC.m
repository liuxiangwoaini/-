//
//  lifetableVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "lifetableVC.h"
#import "lifeCell.h"
#import "lifeitem.h"
@interface lifetableVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *array;
@end

@implementation lifetableVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CGRect rect = CGRectMake(0, 0, 320, 80);
    UIView *headview = [[UIView alloc] initWithFrame:rect];
    headview.userInteractionEnabled = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 40, 40);
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitle:@"关闭" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:btn];
    headview.backgroundColor = [UIColor blueColor];

//    self.tableView.userInteractionEnabled =NO;
    self.tableView.delegate = self;
    self.tableView.rowHeight =  80;
    self.tableView.tableHeaderView = headview;
    //    NSLog(@"%@", self.tableView.)
}


- (NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    lifeitem *item = [[lifeitem alloc] init];
    item.name = @"舒适度指数";
    item.shortstr = dict[@"comf"][@"brf"];
    item.longstr = dict[@"comf"][@"txt"];
    
    lifeitem *item1 = [[lifeitem alloc] init];
    item1.name = @"洗车指数";
    item1.shortstr = dict[@"cw"][@"brf"];
    item1.longstr = dict[@"cw"][@"txt"];
    
    lifeitem *item2 = [[lifeitem alloc] init];
    item2.name = @"穿衣指数";
    item2.shortstr = dict[@"drsg"][@"brf"];
    item2.longstr = dict[@"drsg"][@"txt"];
    
    lifeitem *item3 = [[lifeitem alloc] init];
    item3.name = @"感冒指数";
    item3.shortstr = dict[@"flu"][@"brf"];
    item3.longstr = dict[@"flu"][@"txt"];
    
    lifeitem *item4 = [[lifeitem alloc] init];
    item4.name = @"运动指数";
    item4.shortstr = dict[@"sport"][@"brf"];
    item4.longstr = dict[@"sport"][@"txt"];
    
    lifeitem *item5 = [[lifeitem alloc] init];
    item5.name = @"旅游指数";
    item5.shortstr = dict[@"trav"][@"brf"];
    item5.longstr = dict[@"trav"][@"txt"];
    
    lifeitem *item6 = [[lifeitem alloc] init];
    item6.name = @"紫外线指数";
    item6.shortstr = dict[@"uv"][@"brf"];
    item6.longstr = dict[@"uv"][@"txt"];
    
    [self.array addObject:item];
    [self.array addObject:item1];
    [self.array addObject:item2];
    [self.array addObject:item3];
    [self.array addObject:item4];
    [self.array addObject:item5];
    [self.array addObject:item6];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    lifeCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"life"];
    if (Cell == nil) {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"lifeCell" owner:nil options:nil] lastObject];
    }
    
    Cell.item = self.array[indexPath.row];
    
    
    return Cell;
}



- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
