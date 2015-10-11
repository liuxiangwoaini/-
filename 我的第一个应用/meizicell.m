//
//  meizicell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "meizicell.h"
#import "UIImageView+WebCache.h"
@interface meizicell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation meizicell


- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.name.text = dict[@"name"];
    self.age.text = dict[@"age"];
    [self.image sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:nil];
    
}

@end
