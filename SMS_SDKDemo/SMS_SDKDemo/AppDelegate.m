//
//  AppDelegate.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/30.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "AppDelegate.h"

// SMSSDK官网公共key
#define appKey @"1108df028ec7f"
#define appSecrect @"5a6d7285709128c899ce2a78c728d00f"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 提示:所填写APPKEY仅供测试使用，且不定期失效，请到http://www.mob.com后台申请正式APPKEY
    
    [SMSSDK registerApp:appKey withSecret:appSecrect];
    [SMSSDK enableAppContactFriends:YES];
    
    return YES;
}

@end
