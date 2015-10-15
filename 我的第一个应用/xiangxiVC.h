//
//  xiangxiVC.h
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol xiangxiVCdelegate <NSObject>

@optional
- (void)shoucangswitchonwithphonenumber:(NSDictionary*)dict1;

@end

@interface xiangxiVC : UIViewController
@property (nonatomic ,strong) NSDictionary *dict;
@property (nonatomic, weak) id<xiangxiVCdelegate> delegate;
@end
