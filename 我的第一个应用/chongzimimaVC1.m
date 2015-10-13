//
//  chongzimimaVC1.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "chongzimimaVC1.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD+MJ.h"
@interface chongzimimaVC1 ()
- (IBAction)youxiang;
- (IBAction)shouji;
- (IBAction)queding;
@property (weak, nonatomic) IBOutlet UITextField *xinmima;
@property (weak, nonatomic) IBOutlet UITextField *xinmima2;

@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@end

@implementation chongzimimaVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
}





- (IBAction)youxiang {
    AVUser *user = [AVUser currentUser];
    if (!user[@"localData"][@"emailVerified"]) {
        [MBProgressHUD showError:@"邮箱没有验证,请选择手机重置。。。。"];
        return;
    }
    [MBProgressHUD showMessage:@"正在发送到邮箱。。。"];
    [MBProgressHUD hideHUD];
    [AVUser requestPasswordResetForEmailInBackground:user.email block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"发送成功，请去邮箱重置密码"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:@"发送失败。。。"];
        }
    }];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)shouji {
    AVUser *user = [AVUser currentUser];
    NSLog(@"%d", user.mobilePhoneVerified);
#warning 验证后的手机竟然返回0，真是。。。。
//    if (user.mobilePhoneVerified!=1) {
//        [MBProgressHUD showError:@"手机没有验证,请选择邮箱重置。。。。"];
//        return;
//    }
    [AVUser requestPasswordResetWithPhoneNumber:user.mobilePhoneNumber block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"发送验证码成功"];
        } else {
            [MBProgressHUD showError:@"发送失败。。。"];
        }
    }];
    
}

- (IBAction)queding {
    if (![self.xinmima.text isEqualToString:self.xinmima2.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
    
    [AVUser resetPasswordWithSmsCode:self.yanzhengma.text newPassword:self.xinmima.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [MBProgressHUD showSuccess:@"修改成功"];
        } else {
            [MBProgressHUD showError:@"修改失败"];
        }
    }];
}
@end
