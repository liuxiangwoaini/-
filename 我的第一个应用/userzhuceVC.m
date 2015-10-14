//
//  userzhuceVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-9.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "userzhuceVC.h"
#import "MBProgressHUD+MJ.h"
#import <AVOSCloud/AVOSCloud.h>
#import "dengluVC.h"
@interface userzhuceVC ()<UITextFieldDelegate>
- (IBAction)close;
@property (weak, nonatomic) IBOutlet UITextField *youxiang;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *zhucebtn;
@property (strong ,nonatomic) UIView *barview;
@property (nonatomic, assign) NSInteger num;
- (IBAction)sendyanzhengma;
@property (assign ,nonatomic, getter=isUp) BOOL up;
- (IBAction)zhuce;

@end

@implementation userzhuceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.youxiang.delegate = self;
    self.username.delegate = self;
    self.mima.delegate =self;
    self.phone.delegate =self;
    self.yanzhengma.delegate =self;
//    self.zhucebtn.enabled = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 207, 320, 20)];
    view.userInteractionEnabled =  YES;
    
//    view.frame   = ;
    view.backgroundColor = [UIColor greenColor];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"上一个" forState:UIControlStateNormal];
    [btn1 setTitle:@"上一个" forState:UIControlStateHighlighted];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn1.frame = CGRectMake(0, 0, 80, 19);
    btn1.userInteractionEnabled = YES;
    [btn1 addTarget:self action:@selector(last) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"下一个" forState:UIControlStateNormal];
    
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(80, 0, 80, 19);
    [view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setTitle:@"完成" forState:UIControlStateNormal];
    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(260, 0, 50, 19);
    [view addSubview:btn3];
    [self.view addSubview:view];

    self.barview = view;
    self.barview.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jianpanout:) name:UIKeyboardWillShowNotification object:nil];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jianpanhide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}

- (void)last
{
    if (self.num ==1) {
        return;
    }
    NSInteger last = self.num - 1;
    
    switch (last) {
        case 1:
        {
            [self.youxiang becomeFirstResponder];
            if (self.isUp) {
                self.view.transform = CGAffineTransformMakeTranslation(0, 130);
                self.up = NO;
            }
            
//            self.barview.transform = CGAffineTransformMakeTranslation(0, -130);
            
            break;
        }
        case 2:
        {
            
            if (self.isUp) {
                self.view.transform = CGAffineTransformIdentity;
                self.barview.transform = CGAffineTransformIdentity;
                self.up = NO;
            }
            [self.username becomeFirstResponder];
            break;
        }
        case 3:
        {
//            self.up = NO;
//            self.view.transform = CGAffineTransformMakeTranslation(0, 130);
//            self.barview.transform = CGAffineTransformMakeTranslation(0, -130);
            [self.mima becomeFirstResponder];
            break;
        }
        case 4:
        {
            [self.phone becomeFirstResponder];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)next
{
    if (self.num ==5) {
        return;
    }
    NSInteger next = self.num + 1;
    
    switch (next) {

        case 2:
        {
            

            [self.username becomeFirstResponder];
            break;
        }
        case 3:
        {
            //            self.up = NO;
            //            self.view.transform = CGAffineTransformMakeTranslation(0, 130);
            //            self.barview.transform = CGAffineTransformMakeTranslation(0, -130);
            [self.mima becomeFirstResponder];
            break;
        }
        case 4:
        {
            [self.phone becomeFirstResponder];
            self.up = YES;
            self.view.transform = CGAffineTransformMakeTranslation(0, -130);
            self.barview.transform = CGAffineTransformMakeTranslation(0, 130);
            
            break;
        }
            
        default:
        {
            [self.yanzhengma becomeFirstResponder];
            break;
        }
    }
}
- (void)done
{
    [self zhuce];
}
- (void)jianpanhide:(NSNotification *)noti
{
    
    self.barview.hidden = YES;
    
}

- (void)jianpanout:(NSNotification *)noti
{
   
    self.barview.hidden = NO;
    
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            self.num = 1;
            break;
        }
        case 2:
            self.num = 2;
            break;
        case 3:
        {
            self.num = 3;
            if (self.isUp) {
                return;
            }
            self.up = YES;
            self.view.transform = CGAffineTransformMakeTranslation(0, -130);
            self.barview.transform = CGAffineTransformMakeTranslation(0, 130);
            break;
        }
        case 4:
        {
            self.num = 4;
            if (self.isUp) {
                return;
            }
            self.up = YES;
            self.view.transform = CGAffineTransformMakeTranslation(0, -130);
            self.barview.transform = CGAffineTransformMakeTranslation(0, 130);
            break;
        }
            
        default:
        {
            self.num = 5;
            if (self.isUp) {
                return;
            }
            self.up = YES;
            self.view.transform = CGAffineTransformMakeTranslation(0, -130);
            self.barview.transform = CGAffineTransformMakeTranslation(0, 130);
            break;
        }
    }
}


- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 
    switch (textField.tag) {
        case 1:
        {
            [self.youxiang endEditing:YES];
            [self.username becomeFirstResponder];

             break;
        }
        case 2:
        {
            [self.username endEditing:YES];
            [self.mima becomeFirstResponder];
            
            break;
        }
        case 3:
        {
            [self.mima endEditing:YES];
            [self.phone becomeFirstResponder];
            self.up = YES;
            self.view.transform = CGAffineTransformMakeTranslation(0, -100);
            self.barview.transform = CGAffineTransformMakeTranslation(0, 100);
            break;
        }
        case 4:
        {
            [self.phone endEditing:YES];
            [self.yanzhengma becomeFirstResponder];
            
            break;
        }

        default:
            [self.yanzhengma endEditing:YES];
            self.up = NO;
            self.view.transform = CGAffineTransformIdentity;
            self.barview.transform = CGAffineTransformIdentity;
            break;
    }
    return YES;
}
- (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

- (IBAction)zhuce {
    [self.view endEditing:YES];
    self.view.transform = CGAffineTransformIdentity;
    self.barview.transform = CGAffineTransformIdentity;
    if (self.youxiang.text.length< 8) {
        [MBProgressHUD showError:@"邮箱输入错误"];
        return;
    }else if (self.username.text.length< 5)
    {
        [MBProgressHUD showError:@"用户名输入错误"];
        return;
    }
    else if (self.mima.text.length < 5)
    {
        [MBProgressHUD showError:@"密码输入错误"];
        return;
    }
    else if (self.phone.text.length !=11 )
    {
        [MBProgressHUD showError:@"手机号码输入错误"];
        return;
    }
    else if (![self isPureInt:self.phone.text] )
    {
        [MBProgressHUD showError:@"手机号码输入错误"];
        return;
    }
    else if (self.yanzhengma.text.length != 6 )
    {
        [MBProgressHUD showError:@"验证码输入格式不对"];
        return;
    }
    [AVUser verifyMobilePhone:self.yanzhengma.text withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
           
            [MBProgressHUD showSuccess:@"注册成功。。。正在帮你登陆"];
            [AVUser logInWithUsernameInBackground:self.username.text password:self.mima.text block:^(AVUser *user, NSError *error) {
                if (user != nil) {
                    
                    [MBProgressHUD showSuccess:@"登陆成功。。。正在跳转"];
                    AVUser *user = [AVUser currentUser];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [MBProgressHUD showError:@"登陆失败。。。不晓得啥子情况"];
                    
                }
            }];
            
            
        }else
        {
            
            [MBProgressHUD showError:@"注册失败。。。不晓得啥子情况"];
        }
    }];

    
}
- (IBAction)sendyanzhengma {
     if (self.phone.text.length !=11 )
    {
        [MBProgressHUD showError:@"手机号码输入错误"];
        return;
    }
    else if (![self isPureInt:self.phone.text] )
    {
        [MBProgressHUD showError:@"手机号码输入错误"];
        return;
    }
    AVUser *user = [AVUser user];
    user.username = self.username.text;
    user.password =  self.mima.text;
    user.email = self.youxiang.text;
    user.mobilePhoneNumber =self.phone.text;
    NSError *error = nil;
    [user signUp:&error];
    
  
    
}
@end
