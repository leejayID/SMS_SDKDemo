//
//  NSString+Extension.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/31.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)phoneNumStringIsLegal:(PhoneNumType)phoneNumType {
    
    // 正则
    NSString *regex = nil;
    switch (phoneNumType) {
        case ChinesePhoneStringType:
            regex = @"^0{0,1}(13[0-9]|15[3-9]|15[0-2]|18[0-9]|17[5-8]|145|147)[0-9]{8}$";
            break;
        case OthersPhoneStringType:
            regex = @"^\\d+";
            break;
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

@end
