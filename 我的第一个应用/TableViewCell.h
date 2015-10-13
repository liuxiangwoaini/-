//
//  TableViewCell.h
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tabeleviewCelldelegate <NSObject>

@optional
- (void)cellbtncliclWithstring:(NSString *)str;

@end


@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *array;
@property (nonatomic,weak) id<tabeleviewCelldelegate> delegate;
@end
