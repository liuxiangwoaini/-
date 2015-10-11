//
//  lifeCell.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lifeitem.h"
@interface lifeCell : UITableViewCell
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) lifeitem *item;
@end
