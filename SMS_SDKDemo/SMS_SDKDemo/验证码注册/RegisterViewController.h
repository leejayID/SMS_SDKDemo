//
//  RegisterViewController.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/1.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMS_SDK/Extend/SMSSDKResultHanderDef.h>

@interface RegisterViewController : UIViewController

/**
 *  获取验证码的方式
 */
@property (nonatomic, assign) SMSGetCodeMethod getCodeType;

@end
