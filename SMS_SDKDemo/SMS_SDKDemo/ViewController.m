//
//  ViewController.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/30.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "GetFriendsViewController.h"

static NSString *const kCellReuseIdentifier = @"UITableViewCell";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SMSSDK";
    
    NSString *smsRegisterStr = NSLocalizedStringFromTableInBundle(@"RegisterBySMS", @"Localizable", Bundle, nil);
    NSString *voiceRegisterStr = NSLocalizedStringFromTableInBundle(@"RegisterByVoiceCall", @"Localizable", Bundle, nil);
    NSString *addressBookStr = NSLocalizedStringFromTableInBundle(@"addressbookfriends", @"Localizable", Bundle, nil);
    NSString *submitUserInfoStr = NSLocalizedStringFromTableInBundle(@"submitUserInfo", @"Localizable", Bundle, nil);
    
    NSArray *datas = @[smsRegisterStr,voiceRegisterStr,addressBookStr,submitUserInfoStr];
    self.dataSource = datas;
    
    [self.view addSubview:self.tableView];
    
    // 添加版本号
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 15)];
    versionLabel.text = [NSString stringWithFormat:@"V%@",[SMSSDK SMSSDKVersion]];
    versionLabel.font = [UIFont systemFontOfSize:15.0f];
    versionLabel.textColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:versionLabel];
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

#pragma mark - DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    switch (indexPath.row) {
        case 0: // 短信验证码注册
        {
            RegisterViewController *regist = [[RegisterViewController alloc]init];
            regist.title = NSLocalizedStringFromTableInBundle(@"RegisterBySMS", @"Localizable", Bundle, nil);
            regist.getCodeType = SMSGetCodeMethodSMS;
            [self.navigationController pushViewController:regist animated:YES];
        }
            break;
            
        case 1: // 语音验证码注册
        {
            RegisterViewController *regist = [[RegisterViewController alloc]init];
            regist.title = NSLocalizedStringFromTableInBundle(@"RegisterByVoiceCall", @"Localizable", Bundle, nil);
            regist.getCodeType = SMSGetCodeMethodVoice;
            [self.navigationController pushViewController:regist animated:YES];
        }
            break;
            
        case 2: // 获取朋友列表
        {
            [self getAddressBookFriends];
//            GetFriendsViewController *getFriends = [[GetFriendsViewController alloc]init];
//            getFriends.title = NSLocalizedStringFromTableInBundle(@"addressbookfriends", @"Localizable", Bundle, nil);
//            [self.navigationController pushViewController:getFriends animated:YES];

        }
            break;
            
        case 3: // 提交用户信息
        {
            [self submitUserInfo];
        }
            break;
            
        default:
            break;
    }
}

- (void)getAddressBookFriends {
        
    [SMSSDK getAllContactFriends:1 result:^(NSError *error, NSArray *friendsArray) {
        
        NSLog(@"====%@",friendsArray);
        
        if (!error) {
            
            GetFriendsViewController *getFriends = [[GetFriendsViewController alloc]init];
            getFriends.title = NSLocalizedStringFromTableInBundle(@"addressbookfriends", @"Localizable", Bundle, nil);
            [getFriends setFriendsData:friendsArray];
            [self.navigationController pushViewController:getFriends animated:YES];
            
        } else {
            NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"codesenderrtitle", @"Localizable", Bundle, nil)
                                                            message:NSLocalizedStringFromTableInBundle(messageStr, @"Localizable", Bundle, nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }];
}

- (void)submitUserInfo {
    
    SMSSDKUserInfo *userInfo = [[SMSSDKUserInfo alloc] init];
    userInfo.avatar = @"http://wx.qlogo.cn/mmopen/72lRBHylxzwicgtjgia5uG5VEmIAaGyPJ2HNC2Bvs1Hgdwg84c9h7acEqUTlXqPAiaTpTjoHNSBBeOMnv0IMym3kywFt9BJ5l8J/0";
    userInfo.nickname = @"LeeJay";
    userInfo.uid = @"100";
    userInfo.phone = @"18326672676";
    
    [SMSSDK submitUserInfoHandler:userInfo result:^(NSError *error) {
        if (!error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提交成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
