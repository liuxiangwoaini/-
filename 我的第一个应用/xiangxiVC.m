//
//  xiangxiVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-7.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "xiangxiVC.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
@interface xiangxiVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet UITextView *qianming;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (strong ,nonatomic) UIWebView *webview;

- (IBAction)call;

@end

@implementation xiangxiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webview = web;
    [self.view addSubview:web];
    [self setziliao];
    
}

- (void)setziliao
{
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:self.dict[@"image"]] placeholderImage:nil];
    self.name.text =self.dict[@"name"];
    self.age.text =self.dict[@"age"];
    self.qianming.text = self.dict[@"qianming"];
    self.qianming.userInteractionEnabled = NO;
    self.phone.text = self.dict[@"phone"];
    NSInteger num = arc4random_uniform(1000);
    NSString *str = [NSString stringWithFormat:@"距离%dkm", num];
    self.juli.text = str;
    
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;

    
}


- (IBAction)call {
    
    
    [MBProgressHUD showMessage:@"正在打电话给她。。。。"];
    [self performSelector:@selector(close) withObject:self afterDelay:3];
    NSString *path = [NSString stringWithFormat:@"tel://%@", self.phone.text];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webview loadRequest:requst];
    
}

- (void)close
{
    [MBProgressHUD hideHUD];
}
@end
