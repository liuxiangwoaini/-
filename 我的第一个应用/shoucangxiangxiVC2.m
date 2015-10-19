//
//  shoucangxiangxiVC2.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-15.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "shoucangxiangxiVC2.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
@interface shoucangxiangxiVC2 ()<shoucangxiangxiVC2delegate>
@property (strong, nonatomic) UIScrollView *scrollview;

@end

@implementation shoucangxiangxiVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.contentSize =  CGSizeMake(320*self.array.count, 480);
        scroll.backgroundColor = [UIColor blueColor];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    self.scrollview= scroll;
    [self.view addSubview:scroll];
    
    
}








@end
