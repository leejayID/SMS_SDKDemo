//
//  Header.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/30.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Bundle [[NSBundle alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"SMSSDKUI" ofType:@"bundle"]]

#import <Masonry.h>

#import <MOBFoundation/MOBFoundation.h>
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import <SMS_SDK/Extend/SMSSDKResultHanderDef.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>
#import <SMS_SDK/Extend/SMSSDKAddressBook.h>
#import <SMS_SDK/Extend/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/Extend/SMSSDK+DeprecatedMethods.h>

#endif /* Header_h */
