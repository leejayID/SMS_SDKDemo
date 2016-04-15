//
//  UIButton+CountDown.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/31.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 *  倒计时按钮
 *
 *  @param timeInterVal 时间间隔
 *  @param normalTitle  正常的title
 *  @param disableTitle 不能点击的title
 *  @param normalColor  正常的color
 *  @param disableColor 不能点击的的color
 */
- (void)startWithTimeInterval:(NSInteger)timeInterval normalTitle:(NSString *)normalTitle disableTitle:(NSString *)disableTitle normalColor:(UIColor *)normalColor disableColor:(UIColor *)disableColor;

@end
