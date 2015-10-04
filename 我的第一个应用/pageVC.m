//
//  pageVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-2.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "pageVC.h"
#import "pageVc1.h"
#import "pageVC2.h"
@interface pageVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@end

@implementation pageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [[pageVc1 alloc] init];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [[pageVC2 alloc] init];
}

@end