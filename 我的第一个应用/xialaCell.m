//
//  xialaCell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-10-4.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "xialaCell.h"
@interface xialaCell()
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *returncity;
@property (weak, nonatomic) IBOutlet UILabel *water;
@property (weak, nonatomic) IBOutlet UILabel *pm;


@property (nonatomic, strong) NSDictionary *weatherdict;
@property (weak, nonatomic) IBOutlet UILabel *wendu;
@property (weak, nonatomic) IBOutlet UILabel *tianqi;
@end
@implementation xialaCell





- (IBAction)closeVC {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"btnclick" object:self];
    
}


- (void)setArray:(NSArray *)array
{
    _array = array;
    self.returncity.text = array[0][@"basic"][@"city"];
    
    
    self.wendu.text = array[0][@"now"][@"tmp"];
    
    self.tianqi.text =array[0][@"now"][@"cond"][@"txt"];
    self.pm.text =array[0][@"aqi"][@"city"][@"pm25"];
    
    self.water.text =array[0][@"now"][@"pcpn"];
    
}
@end
