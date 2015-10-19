//
//  liaotianVC.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-15.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "liaotianVC.h"
//#import <AVOSCloud/AVOSCloud.h>
//#import <AVOSCloudIM/AVOSCloudIM.h>
@interface liaotianVC ()
//@property (nonatomic, strong) AVIMClient *client;
@end

@implementation liaotianVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.client = [[AVIMClient alloc] init];
//    [self tomSendMessageToJerry];
}


//- (void)tomSendMessageToJerry {
//    // Tom 创建了一个 client
//    self.client = [[AVIMClient alloc] init];
//    
//    // Tom 用自己的名字作为 ClientId 打开 client
//    [self.client openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
//        // Tom 建立了与 Jerry 的会话
//        [self.client createConversationWithName:@"猫和老鼠" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
//            // Tom 发了一条消息给 Jerry
//            [conversation sendMessage:[AVIMTextMessage messageWithText:@"耗子，起床！" attributes:nil] callback:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    NSLog(@"发送成功！");
//                }
//            }];
//        }];
//    }];
//}


@end
