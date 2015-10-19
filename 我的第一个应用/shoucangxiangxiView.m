//
//  shoucangxiangxiView.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-15.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "shoucangxiangxiView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"

@interface shoucangxiangxiView()
- (IBAction)liaotian:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UISwitch *shoucangswitch;
@property (weak, nonatomic) IBOutlet UILabel *juli;
@property (weak, nonatomic) IBOutlet UITextView *qianming;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) UIView *backview;
@property (strong, nonatomic) UIScrollView *scrollview;
@property (assign ,nonatomic, getter=isOpen) BOOL open;
- (IBAction)quxiaoshoucang:(id)sender;
@property (assign ,nonatomic) CGPoint begin;
@property (assign ,nonatomic) CGPoint change;
@property (assign ,nonatomic) CGPoint end;
@property (strong ,nonatomic) UIWebView *webview;
- (IBAction)call;
@end
@implementation shoucangxiangxiView

- (void)setDict:(NSDictionary *)dict
{
    _dict  = dict;
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

@end
