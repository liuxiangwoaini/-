//
//  citychoose.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol citychooseVcdelegate <NSObject>

@optional
- (void)citybtnclick:(NSString *)cityname;

@end
@interface citychoose : UITableViewController
@property (weak, nonatomic) id<citychooseVcdelegate> delegate;
@end
