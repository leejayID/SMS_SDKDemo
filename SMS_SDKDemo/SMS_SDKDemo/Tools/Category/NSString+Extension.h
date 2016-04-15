//
//  NSString+Extension.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/31.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PhoneNumType) {
    
    ChinesePhoneStringType = 0,// 中国手机号
    OthersPhoneStringType,// 其他国家手机号
};

@interface NSString (Extension)

/**
 *  判断手机号是否合法
 *
 *  @param phoneNumType 手机号类型
 *
 *  @return BOOL
 */
- (BOOL)phoneNumStringIsLegal:(PhoneNumType)phoneNumType;

@end

