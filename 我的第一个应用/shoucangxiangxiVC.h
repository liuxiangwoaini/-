//
//  shoucangxiangxiVC.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-14.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shoucangxiangxiVCdelegate <NSObject>

@optional
- (void)shoucangswitchonwithphonenumber:(NSDictionary*)dict1 anddelte:(NSIndexPath *)indexpath;

@end
@interface shoucangxiangxiVC : UIViewController
@property (nonatomic ,strong) NSDictionary *dict;
@property (nonatomic ,strong) NSIndexPath *index;
@property (nonatomic, weak) id<shoucangxiangxiVCdelegate> delegate;
@end
