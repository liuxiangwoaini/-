//
//  zhouweimeizi.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol zhouweimeiziDelegate <NSObject>

@optional
- (void)cellclickwith:(NSDictionary *)dict;

@end
@interface zhouweimeizi : UITableViewController
@property (weak, nonatomic) id<zhouweimeiziDelegate> delegate;
@property (nonatomic, assign) NSInteger num;
@end
