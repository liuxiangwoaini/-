//
//  dengluVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-13.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "dengluVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD+MJ.h"
#import "xiugaimimaVC.h"
#import "chongzhimimaVC.h"
#import "chongzimimaVC1.h"

@interface dengluVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressview;
- (IBAction)xiugaimima;
- (IBAction)chongzhimima;
@property (weak, nonatomic) IBOutlet UILabel *youxiang;
- (IBAction)zhuxiao;
- (IBAction)tianjiatouxiang;

@end

@implementation dengluVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AVUser *user = [AVUser currentUser];
    self.username.text = user.username;
    self.phone.text = user.mobilePhoneNumber;
    self.youxiang.text = user.email;
    self.progressview.hidden = YES;
#warning 卡住了，明天接着写
    AVFile *file = user[@"localData"][@"touxiang"];
    NSData *data = file.getData;
    UIImage *Image = [UIImage imageWithData:data];
    self.imageview.image = Image;
}





- (IBAction)zhuxiao {
   
    AVUser *user = [AVUser currentUser];
    if (!user) {
        [MBProgressHUD showError:@"没有登陆。。。。"];
        return;
    }
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"真的要注销吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    
//    [AVUser logOut];
//    AVUser *user = [AVUser currentUser];
//    self.username.text = user.username;
//    self.phone.text = user.mobilePhoneNumber;
//    self.youxiang.text = user.email;
    [action showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
            [AVUser logOut];
            AVUser *user = [AVUser currentUser];
            self.username.text = user.username;
            self.phone.text = user.mobilePhoneNumber;
            self.youxiang.text = user.email;
    }
}



- (IBAction)tianjiatouxiang {
   
 
    
    AVUser *user = [AVUser currentUser];
    if (!user) {
        [MBProgressHUD showError:@"没有登陆。。。。"];
        return;
    }
        [self.progressview setProgress:0];
    self.progressview.hidden = NO;
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];

    
    //当选择一张图片后进入这里

}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    AVUser *user = [AVUser currentUser];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    ;
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.imageview.image = image;
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
            AVFile *file = [AVFile fileWithName:@"1.jpg" data:data];
            [user addObject:file forKey:@"touxiang"];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
               [self.progressview setProgress:percentDone animated:YES];
                [MBProgressHUD showSuccess:@"图片上传成功"];
            }];
            [user saveInBackground];
            [AVUser currentUser];
            
            
        }
        else
        {
            data = UIImagePNGRepresentation(image);
            AVFile *file = [AVFile fileWithName:@"1.png" data:data];
            [user addObject:file forKey:@"touxiang"];
//            [file saveInBackground];
             [user saveInBackground];
            [AVUser currentUser];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
                [self.progressview setProgress:percentDone animated:YES];
                if (percentDone == 100) {
                    self.progressview.hidden = YES;
                    [MBProgressHUD showSuccess:@"图片上传成功"];
                }
            }];
        }
        
        
    }
    
}
- (IBAction)xiugaimima {
    AVUser *user = [AVUser currentUser];
    if (!user) {
        [MBProgressHUD showError:@"没有登陆。。。。"];
        return;
    }else
    {
        xiugaimimaVC *xiu  = [[xiugaimimaVC alloc] init];
        [self.navigationController pushViewController:xiu animated:YES];
    }
}

- (IBAction)chongzhimima {
    AVUser *user = [AVUser currentUser];
    if (user) {
        
        chongzimimaVC1 *xiu  = [[chongzimimaVC1 alloc] init];
        [self.navigationController pushViewController:xiu animated:YES];
        
    }else
    {
        
        chongzhimimaVC *xiu  = [[chongzhimimaVC alloc] init];
        [self.navigationController pushViewController:xiu animated:YES];
    }
}
@end
