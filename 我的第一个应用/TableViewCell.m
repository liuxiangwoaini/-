//
//  TableViewCell.m
//  我的第一个应用
//
//  Created by liuxiang on 15-9-28.
//  Copyright (c) 2015年 liuxiang. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tianqi;
@property (weak, nonatomic) IBOutlet UILabel *wendu;
@property (weak, nonatomic) IBOutlet UIView *bigview;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *bioamiaolable;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGPoint panendPoint;
@property (nonatomic, assign) CGFloat temp;
@property (nonatomic, assign, getter=isopen) BOOL open;


@property (nonatomic, assign) CGAffineTransform trans;
- (IBAction)btnclick:(id)sender;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%@", self.contentView.subviews);
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.bigview addGestureRecognizer:self.panRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setArray:(NSDictionary *)array
{
    _array = array;
    self.tianqi.text = array[@"cond"][@"txt_n"];
    self.wendu.text = array[@"tmp"][@"max"];
    self.time.text = array[@"date"];
    self.bioamiaolable.text = array[@"date"];;
//    self.bioamiaolable.text = @"dasd";
//    NSLog(@"%d", self.tag);
}

- (IBAction)btnclick:(id)sender {
    UIButton *btn = sender;
    [self.delegate cellbtncliclWithstring:btn.titleLabel.text];
}

#warning 监听cell的手势拖拽，可以实现左右拖拽，但是实现不了tableview的正常滚动,不晓得怎么做了。。。。伤心啊，改天问大神
- (void)panThisCell:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            
//            self.panStartPoint = [recognizer translationInView:self.bigview];
//            if (self.panendPoint.x > (-self.panendPoint.x)) {
//                return;
//            }
//         self.trans = CGAffineTransformIdentity;
//            self.bigview.transform= CGAffineTransformMakeTranslation(self.panendPoint.x, 0);
            NSLog(@"Pan start-- %f", self.panStartPoint.x);
            break;
        case UIGestureRecognizerStateChanged: {
            
            
            
            CGPoint currentPoint = [recognizer translationInView:self.bigview];
//            self.bigview.transform = CGAffineTransformMakeTranslation(0, currentPoint.y);
            if (currentPoint.x > 0) {
                self.open = NO;
                
            }
            CGFloat deltaX = currentPoint.x + self.panendPoint.x;
            if (deltaX<-145) {
                self.bigview.transform = CGAffineTransformMakeTranslation(-145, 0);
                
//                self.temp = -145;
            }
            else if (deltaX > 0){
//            self.bigview.transform= CGAffineTransformTranslate(self.trans, deltaX, 0);
            
//                self.temp = deltaX;
                self.bigview.transform = CGAffineTransformIdentity;
                
//            self.trans = self.bigview.transform;
            }else
            {
                self.bigview.transform = CGAffineTransformMakeTranslation(deltaX, 0);
                if (deltaX < -75) {
                    self.open = YES;
                }
            }


            
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.isopen) {
                self.bigview.transform = CGAffineTransformMakeTranslation(-145, 0);
            }
            self.temp = self.panendPoint.x;
            self.panendPoint = [recognizer translationInView:self.bigview];
//            self.trans = CGAffineTransformTranslate(self.trans,self.panendPoint.x,0);
//            self.trans = CGAffineTransformIdentity;
            CGPoint temp1 = CGPointMake(self.temp + self.panendPoint.x, self.panendPoint.y);
            self.panendPoint = temp1;

            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Pan Cancelled");
            break;
        default:
            break;
    }
    
}
@end
