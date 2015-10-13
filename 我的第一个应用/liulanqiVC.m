//
//  liulanqiVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "liulanqiVC.h"

@interface liulanqiVC ()<UIWebViewDelegate>
- (IBAction)houtui;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)qianjin;
- (IBAction)shuaxin;
- (IBAction)stop;

@end

@implementation liulanqiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.hao123.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
    self.webview.delegate =self;
    
}




- (IBAction)qianjin {
    [self.webview goForward];
}

- (IBAction)shuaxin {
    [self.webview reload];
}

- (IBAction)stop {
    [self.webview stopLoading];
}
- (IBAction)houtui {
    [self.webview goBack];
}
@end
