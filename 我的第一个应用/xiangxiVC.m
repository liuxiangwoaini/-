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
@property (weak, nonatomic) IBOutlet UISwitch *shoucangswitch;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet UITextView *qianming;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (strong ,nonatomic) UIWebView *webview;
@property (strong, nonatomic) UIView *backview;
@property (assign ,nonatomic, getter=isOpen) BOOL open;

- (IBAction)call;

@end

@implementation xiangxiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webview = web;
    [self.view addSubview:web];
    [self setziliao];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor greenColor];
    
    view.hidden = YES;
    [self.view insertSubview:view belowSubview:self.imageview];
    self.backview = view;
       self.open = NO;
    self.imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dianjiview)];
    tap.numberOfTapsRequired = 2;
    [self.imageview addGestureRecognizer:tap];
    
    
}

- (void)dianjiview
{
    self.open = !self.isOpen;
    if (self.open) {
        self.backview.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.imageview.frame = CGRectMake(0, 100, 320, 320);
            
        }];
        
    }else
    {
        self.backview.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.imageview.frame = CGRectMake(89, 79, 150, 150);
            
        }];
    }
    
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
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.shoucangswitch.on) {
        if ([self.delegate respondsToSelector:@selector(shoucangswitchonwithphonenumber:)]) {
            [self.delegate shoucangswitchonwithphonenumber:self.dict];
        }
        
    }
}
@end
