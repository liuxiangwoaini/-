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
#import "UIImageView+WebCache.h"
#import "shoucangmeiziVC.h"

@interface dengluVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIProgressView *progressview;
- (IBAction)xiugaimima;
- (IBAction)myshoucang;
- (IBAction)chongzhimima;
@property (weak, nonatomic) IBOutlet UILabel *youxiang;
- (IBAction)zhuxiao;
- (IBAction)tianjiatouxiang;

@end

@implementation dengluVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    AVUser *user = [AVUser currentUser];
//    AVUser *user1 = [AVUser objectWithoutDataWithObjectId:user.objectId];
//    NSDictionary *dict = (NSDictionary *)user1;
//    NSLog(@"%@\n%@", dict, user);
#pragma user类有权限设置，要改一下
 
    
//    AVObject *obj = [AVObject objectWithClassName:@"xixi"];
//    [obj setObject:@"liuxiang" forKey:@"hehe"];
//    [obj saveInBackground];
    
    self.username.text = user.username;
    self.phone.text = user.mobilePhoneNumber;
    self.youxiang.text = user.email;
    self.progressview.hidden = YES;

    
 
    
    [self setupimageview];
 
    
}


- (void)setupimageview
{
    AVUser *user = [AVUser currentUser];
    if (!user)return;
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:user.username];
    //    [query whereKeyExists:@"name"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"检索成功");
            AVUser *user = [objects lastObject];
            AVFile *file = user[@"touxiang"];
            
//            NSString *str = user[@"touxiang"][@"url"];
            if (file.url) {
                [self.imageview sd_setImageWithURL:[NSURL URLWithString:file.url]];
            }
//            if (file) {
//                NSData *data = file.getData;
//                UIImage *Image = [UIImage imageWithData:data];
//                self.imageview.image = Image;
//            }
            
        } else {
            // 输出错误信息
            NSLog(@"检索失败");
        }
    }];
    
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
        self.imageview.image = nil;
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
#warning 不知道返回的图片的扩展名。。。。。搜也搜不到
        if (UIImagePNGRepresentation(image))
        {
            AVUser *user = [AVUser currentUser];
            data = UIImageJPEGRepresentation(image, 1.0);
            AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@.jpg", user.username] data:data];
            
            [user setObject:file forKey:@"touxiang"];
            
            [user setObject:@"liuxiang" forKey:@"haoleng"];
            

            
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
                [self.progressview setProgress:percentDone animated:YES];
                if (percentDone == 100) {
                    self.progressview.hidden = YES;
                    [MBProgressHUD showSuccess:@"图片上传成功"];
                }
            }];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    NSLog(@"保存失败");
                }
            }];

            
        }
        else
        {
            AVUser *user = [AVUser currentUser];
            data = UIImagePNGRepresentation(image);
            AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@.png", user.username] data:data];
            
            
            [user setObject:file forKey:@"touxiang"];

            
            
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            } progressBlock:^(NSInteger percentDone) {
                [self.progressview setProgress:percentDone animated:YES];
                if (percentDone == 100) {
                    self.progressview.hidden = YES;
                    [MBProgressHUD showSuccess:@"图片上传成功"];
                }
            }];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    NSLog(@"保存失败");
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

- (IBAction)myshoucang {
    AVUser *user = [AVUser currentUser];
    if (!user) {
        [MBProgressHUD showError:@"没有登陆。。。。"];
        return;
    }
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullpath = [path stringByAppendingPathComponent:@"shoucang.plist"];
    NSMutableArray *shoucang = [NSMutableArray arrayWithContentsOfFile:fullpath];
    shoucangmeiziVC *VC = [[shoucangmeiziVC alloc] init];
    VC.phonelist = shoucang;
    [self.navigationController pushViewController:VC animated:YES];
    
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
