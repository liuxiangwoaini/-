//
//  denglujiemianVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "denglujiemianVC.h"
#import "MBProgressHUD+MJ.h"
#import <AVOSCloud/AVOSCloud.h>
#import "chongzhimimaVC.h"
@interface denglujiemianVC ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
- (IBAction)sendyanzhengma;
- (IBAction)wangjimima;
- (IBAction)denglu;

@end

@implementation denglujiemianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆界面";
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)sendyanzhengma {
    if (![self isPureInt:self.username.text])
    {
        [MBProgressHUD showError:@"手机号输入错误"];
        return;
    }
    [AVUser requestLoginSmsCode:self.username.text withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            [MBProgressHUD showSuccess:@"发送成功"];
;
        } else {
            [MBProgressHUD showError:@"发送失败"];
            
        }
    }];
}

- (IBAction)wangjimima {
    
    chongzhimimaVC *ch = [[chongzhimimaVC alloc] init];
    
    [self.navigationController pushViewController:ch animated:YES];
}

- (IBAction)denglu {
    if (self.username.text.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }else if (self.mima.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }

    
    
    if ([self isPureInt:self.username.text]) {
        if (self.yanzhengma.text.length) {
            [AVUser logInWithMobilePhoneNumberInBackground:self.username.text smsCode:self.yanzhengma.text block:^(AVUser *user, NSError *error) {
                if (user != nil) {
                    
                    [MBProgressHUD showSuccess:@"登陆成功。。。正在跳转"];
                    AVUser *user = [AVUser currentUser];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else {
                    [MBProgressHUD showError:@"登陆失败。。。不晓得啥子情况"];
                    
                }
                
                
            }];
            return;
        }else{
        
        [AVUser logInWithMobilePhoneNumberInBackground:self.username.text password:self.mima.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                
                [MBProgressHUD showSuccess:@"登陆成功。。。正在跳转"];
                AVUser *user = [AVUser currentUser];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:@"登陆失败。。。不晓得啥子情况"];
                
            }
            
        }];
            return;
        }
    }else
    {
    
    [AVUser logInWithUsernameInBackground:self.username.text password:self.mima.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            
            [MBProgressHUD showSuccess:@"登陆成功。。。正在跳转"];
            AVUser *user = [AVUser currentUser];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:@"登陆失败。。。不晓得啥子情况"];
            
        }
    }];
        return;
    }
}
- (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}
@end
