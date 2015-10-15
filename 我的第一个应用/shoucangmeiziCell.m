//
//  shoucangmeiziCell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-14.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "shoucangmeiziCell.h"
@interface shoucangmeiziCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end
@implementation shoucangmeiziCell



- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.name.text = dict[@"name"];
    self.age.text = dict[@"age"];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:nil];
    
}

@end
