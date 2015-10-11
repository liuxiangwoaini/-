//
//  TableViewCell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tianqi;
@property (weak, nonatomic) IBOutlet UILabel *wendu;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setArray:(NSDictionary *)array
{
    _array = array;
    self.tianqi.text = array[@"cond"][@"txt_n"];
    self.wendu.text = array[@"tmp"][@"max"];
    self.time.text = array[@"date"];
    NSLog(@"%d", self.tag);
}

@end
