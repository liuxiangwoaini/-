//
//  lifeCell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "lifeCell.h"
@interface lifeCell()
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *shortstr;
@property (weak, nonatomic) IBOutlet UITextView *longstr;

@end
@implementation lifeCell

- (void)setItem:(lifeitem *)item
{
    _item = item;
    self.userInteractionEnabled = NO;
    self.name.text = item.name;
    self.shortstr.text = item.shortstr;
    self.longstr.text = item.longstr;
    
}


@end
