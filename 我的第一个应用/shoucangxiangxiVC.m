//
//  shoucangxiangxiVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-14.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "shoucangxiangxiVC.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"

@interface shoucangxiangxiVC ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UISwitch *shoucangswitch;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet UITextView *qianming;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) UIView *backview;
@property (assign ,nonatomic, getter=isOpen) BOOL open;
- (IBAction)quxiaoshoucang:(id)sender;
@property (strong ,nonatomic) UIWebView *webview;
- (IBAction)call;
@end

@implementation shoucangxiangxiVC

- (void)viewDidLoad {
    [super viewDidLoad];
      UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectZero];
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitle:@"保存" forState:UIControlStateHighlighted];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font= [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(baocuntupia) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 100, 100);
    
    [view addSubview:btn];
    view.backgroundColor = [UIColor greenColor];
    
    view.hidden = YES;
    [self.view insertSubview:view belowSubview:self.imageview];
    self.backview = view;
    self.webview = web;
    self.open = NO;
    [self.view addSubview:web];
    [self setziliao];
    self.imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dianjiview:)];
    tap.numberOfTapsRequired = 2;
    [self.imageview addGestureRecognizer:tap];
}


- (void)baocuntupia
{
#warning 明天接着写
    UIImage *image = self.imageview.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(did), <#void *contextInfo#>)
    
    
}
- (void)dianjiview:(UITapGestureRecognizer *)ges
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
- (IBAction)call {
    
    
    [MBProgressHUD showMessage:@"正在打电话给她。。。。"];
    [self performSelector:@selector(close) withObject:self afterDelay:3];
    NSString *path = [NSString stringWithFormat:@"tel://%@", self.phone.text];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webview loadRequest:requst];
    
}



- (IBAction)quxiaoshoucang:(id)sender {
    UISwitch *s = sender;
    if (!s.on) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"真的要取消收藏吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [action showInView:self.view];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [MBProgressHUD showMessage:@"然而并没有什么卵用"];
        [self performSelector:@selector(close) withObject:self afterDelay:3];
        
    }
}

- (void)close
{
    [MBProgressHUD hideHUD];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (!self.shoucangswitch.on) {
        if ([self.delegate respondsToSelector:@selector(shoucangswitchonwithphonenumber: anddelte:)]) {
            [self.delegate shoucangswitchonwithphonenumber:self.dict anddelte:self.index];
        }
    }
}

@end
