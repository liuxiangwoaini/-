//
//  shoucangxiangxiVC2.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-15.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shoucangxiangxiVC2delegate <NSObject>

@optional
- (void)shoucangswitchonwithphonenumber:(NSDictionary*)dict1 anddelte:(NSIndexPath *)indexpath;

@end
@interface shoucangxiangxiVC2 : UIViewController
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSIndexPath *index;
@property (nonatomic, weak) id<shoucangxiangxiVC2delegate> delegate;
@end
