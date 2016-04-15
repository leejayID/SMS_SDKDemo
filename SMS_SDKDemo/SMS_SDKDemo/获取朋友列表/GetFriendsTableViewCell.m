//
//  GetFriendsTableViewCell.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/1.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "GetFriendsTableViewCell.h"

@interface GetFriendsTableViewCell ()

@property (nonatomic, strong) UIImageView *avatarImageV;// 头像
@property (nonatomic, strong) UILabel *nameLabel;// name
@property (nonatomic, strong) UIButton *inviteBtn;// 邀请按钮

@end

@implementation GetFriendsTableViewCell
{
    BOOL _isAdd;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    
    self.avatarImageV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.avatarImageV];
    
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];

    self.inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.inviteBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [self.contentView addSubview:self.inviteBtn];   
    NSString *imageString = [Bundle pathForResource:@"button2" ofType:@"png"];
    [self.inviteBtn addTarget:self action:@selector(onInviteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.inviteBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:imageString] forState:UIControlStateNormal];
    
    [self.avatarImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.nameLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@30);
    }];
    
    [self.inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
}

- (void)setIsInviteOrAdd:(BOOL)isInviteOrAdd {
    _isAdd = !isInviteOrAdd;
    if (isInviteOrAdd) {// 邀请
        [self.inviteBtn setTitle:NSLocalizedStringFromTableInBundle(@"invitefriends", @"Localizable", Bundle, nil) forState:UIControlStateNormal];
    } else { // 添加
        [self.inviteBtn setTitle:NSLocalizedStringFromTableInBundle(@"addfriends", @"Localizable", Bundle, nil) forState:UIControlStateNormal];
    }
}

- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
    self.avatarImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"SMSSDKUI.bundle/sms_ui_default_avatar.png"]];
}

- (void)onInviteBtnClick {
    if (self.ActionHandle) {
        self.ActionHandle(self.indexPath, _isAdd);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
