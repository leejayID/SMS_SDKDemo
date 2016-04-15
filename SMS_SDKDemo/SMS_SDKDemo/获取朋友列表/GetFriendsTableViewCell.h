//
//  GetFriendsTableViewCell.h
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/1.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIdentifier_getFriends @"GetFriendsTableViewCell"

@interface GetFriendsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^ActionHandle) (NSIndexPath *index, BOOL isAdd);
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isInviteOrAdd;// 是邀请还是添加 （邀请1，添加0）

@end
