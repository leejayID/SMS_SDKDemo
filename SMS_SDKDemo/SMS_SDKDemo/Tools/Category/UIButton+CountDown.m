//
//  UIButton+CountDown.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/31.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)

- (void)startWithTimeInterval:(NSInteger)timeInterval normalTitle:(NSString *)normalTitle disableTitle:(NSString *)disableTitle normalColor:(UIColor *)normalColor disableColor:(UIColor *)disableColor {
    
    __block NSInteger count = timeInterval;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC,  0);
    dispatch_source_set_event_handler(timer, ^{
        if (count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = disableColor;
                [self setTitle:[NSString stringWithFormat:@"%2zd%@",count+1,disableTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            count--;
        } else {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = normalColor;
                [self setTitle:normalTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }
    });
    dispatch_resume(timer);
}

@end
