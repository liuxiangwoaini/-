//
//  UIImage+resizeimage.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "UIImage+resizeimage.h"

@implementation UIImage (resizeimage)

+ (instancetype)resizeimgaeWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height* 0.5];
    return image;
}

@end
