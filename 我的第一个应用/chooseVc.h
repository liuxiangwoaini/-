//
//  chooseVc.h
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chooseVcdelegate <NSObject>

@optional
- (void)choosecitywithcode:(NSInteger )code;
- (void)choosecitywithstring:(NSString *)string;

@end

@interface chooseVc : UIViewController
@property (weak ,nonatomic)id <chooseVcdelegate>delegate;
@end
