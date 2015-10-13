//
//  xiugaimimaVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "xiugaimimaVC.h"
#import "MBProgressHUD+MJ.h"
#import <AVOSCloud/AVOSCloud.h>
@interface xiugaimimaVC ()
@property (weak, nonatomic) IBOutlet UITextField *yuanmima;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *xinmima;
- (IBAction)xiugai;

@end

@implementation xiugaimimaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




- (IBAction)xiugai {
    if (![self.mima.text isEqualToString:self.xinmima.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }
    AVUser *user = [AVUser currentUser];
    if (!user) {
        [MBProgressHUD showError:@"没有登陆。。。。"];
        return;
    }
    [[AVUser currentUser] updatePassword:self.yuanmima.text newPassword:self.mima.text block:^(id object, NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"操作失败, 原密码错误。。。。"];
           
        }else
        {
            [MBProgressHUD showSuccess:@"修改成功"];
        }
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
