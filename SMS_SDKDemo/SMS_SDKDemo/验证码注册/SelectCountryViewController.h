//
//  SelectCountryViewController.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/30.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSSDKCountryAndAreaCode;
@protocol SelectCountryDelegate;

@interface SelectCountryViewController : UIViewController

@property (nonatomic, weak) id<SelectCountryDelegate> delegate;

@end

@protocol SelectCountryDelegate <NSObject>

- (void)selectCountryAndAreaCode:(SMSSDKCountryAndAreaCode *)data;

@end
