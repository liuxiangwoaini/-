//
//  chongzhimimaVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "chongzhimimaVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD+MJ.h"
@interface chongzhimimaVC ()
@property (weak, nonatomic) IBOutlet UITextField *youxiang;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *xinmima;
@property (weak, nonatomic) IBOutlet UITextField *xinmima2;
- (IBAction)querenchongzhi;

- (IBAction)fasongyanzhengma;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@end

@implementation chongzhimimaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (IBAction)querenchongzhi {
    AVUser *user = [AVUser currentUser];
    if (self.youxiang.text.length) {
        
        
        [MBProgressHUD showMessage:@"正在发送到邮箱。。。"];
        [MBProgressHUD hideHUD];
        [AVUser requestPasswordResetForEmailInBackground:self.youxiang.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [MBProgressHUD showSuccess:@"发送成功，请去邮箱重置密码"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:@"发送失败。。。"];
            }
        }];
    }else
    {
        if (![self.xinmima.text isEqualToString:self.xinmima2.text]) {
            [MBProgressHUD showError:@"两次输入密码不一致"];
            return;
        }
        
        [AVUser resetPasswordWithSmsCode:self.yanzhengma.text newPassword:self.xinmima.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [MBProgressHUD showSuccess:@"修改成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:@"修改失败"];
            }
        }];
    }
}

- (IBAction)fasongyanzhengma {
    
    AVUser *user = [AVUser currentUser];
    
#warning 验证后的手机竟然返回0，真是。。。。
    //    if (user.mobilePhoneVerified!=1) {
    //        [MBProgressHUD showError:@"手机没有验证,请选择邮箱重置。。。。"];
    //        return;
    //    }
    [AVUser requestPasswordResetWithPhoneNumber:self.phone.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"发送验证码成功"];
        } else {
            [MBProgressHUD showError:@"发送失败。。。"];
        }
    }];
}
@end
