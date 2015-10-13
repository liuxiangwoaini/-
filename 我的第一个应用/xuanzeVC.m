//
//  xuanzeVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "xuanzeVC.h"
#import "userzhuceVC.h"
#import "denglujiemianVC.h"
@interface xuanzeVC ()
- (IBAction)denglu;

- (IBAction)zhuce;
@end

@implementation xuanzeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}





- (IBAction)denglu {
    denglujiemianVC *de = [[denglujiemianVC alloc] init];
        [self.navigationController pushViewController:de
        animated:YES];
    
}

- (IBAction)zhuce {
    userzhuceVC *us = [[userzhuceVC alloc] init];
    [self.navigationController presentViewController:us animated:YES completion:nil];
}
@end
