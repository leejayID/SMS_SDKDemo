//
//  GetFriendsViewController.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/1.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "GetFriendsViewController.h"
#import "GetFriendsTableViewCell.h"
#import "InviteFriendViewController.h"

@interface GetFriendsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *addressBookDataSource;// 通讯录的好友
@property (nonatomic, strong) NSMutableArray *friendsArray;// 用于接收传过来的friendsArray
@property (nonatomic, strong) NSMutableArray *unRegisterFriends;// 未注册该应用的通讯录好友（待邀请）
@property (nonatomic, strong) NSMutableArray *registerFriends;// 注册该应用的通讯录的好友（待添加）
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation GetFriendsViewController

- (void)setFriendsData:(NSArray *)array {
    self.friendsArray = [NSMutableArray arrayWithArray:array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addressBookDataSource = [SMSSDK addressBook];
    
    [self.view addSubview:self.tableView];

    
    [self configureData];
    
}

// 分离出 未注册该应用的通讯录好友 和 已注册该应用的通讯录的好友 （可优化）
- (void)configureData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        
    });
    
    // 双层循环 取出注册该应用的通讯录好友
    for (int i = 0; i< _friendsArray.count; i++) {
        NSDictionary *dict = [_friendsArray objectAtIndex:i];
        //电话
        NSString *phone = dict[@"phone"];
        //姓名
        NSString *name = dict[@"nickname"];
        
        for (int j = 0; j < _addressBookDataSource.count; j++) {
            SMSSDKAddressBook *person = [_addressBookDataSource objectAtIndex:j];
            for (int k = 0; k < person.phonesEx.count; k++) {
                if ([phone isEqualToString:[person.phonesEx objectAtIndex:k]]) {
                    if (person.name) {
                        NSString *str1 = [NSString stringWithFormat:@"%@+%@",name,person.name];
                        // 加标志
                        NSString *str2 = [str1 stringByAppendingString:@"@"];
                        [self.registerFriends addObject:str2];
                    }
                    [_addressBookDataSource removeObjectAtIndex:j];
                }
            }
        }
    }
    
    // 取出已注册该应用的通讯录的好友
    for (int i = 0; i < _addressBookDataSource.count; i++) {
        SMSSDKAddressBook *person = [_addressBookDataSource objectAtIndex:i];
        NSString *str1 = [NSString stringWithFormat:@"%@+%@",person.name,person.phones];
        // 加标志
        NSString *str2 = [str1 stringByAppendingString:@"#"];
        [self.unRegisterFriends addObject:str2];
    }

    NSLog(@"%@",_registerFriends);
    
    // 装入最终的数据源
    if (_registerFriends.count > 0) {
        NSDictionary *dict = @{NSLocalizedStringFromTableInBundle(@"hasjoined", @"Localizable", Bundle, nil):_registerFriends};
        [self.dataSource addObject:dict];
    } else {
        // 方便测试加入假数据
        NSDictionary *dict = @{NSLocalizedStringFromTableInBundle(@"hasjoined", @"Localizable", Bundle, nil):@[@"我是假数据哦+110@"]};
        [self.dataSource addObject:dict];
    }
    
    if (_unRegisterFriends.count > 0) {
        NSDictionary *dict = @{NSLocalizedStringFromTableInBundle(@"toinvitefriends", @"Localizable", Bundle, nil):_unRegisterFriends};
        [self.dataSource addObject:dict];
    }
    
//    NSLog(@"%@===%@",_unRegisterFriends,_registerFriends);
    
//    NSLog(@"%@",self.dataSource);
    
    [self.tableView reloadData];
}

#pragma mark - Getters
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)friendsArray {
    if (!_friendsArray) {
        _friendsArray = [NSMutableArray array];
    }
    return _friendsArray;
}

- (NSMutableArray *)addressBookDataSource {
    if (!_addressBookDataSource) {
        _addressBookDataSource = [NSMutableArray array];
    }
    return _addressBookDataSource;
}

- (NSMutableArray *)unRegisterFriends {
    if (!_unRegisterFriends) {
        _unRegisterFriends = [NSMutableArray array];
    }
    return _unRegisterFriends;
}

- (NSMutableArray *)registerFriends {
    if (!_registerFriends) {
        _registerFriends = [NSMutableArray array];
    }
    return _registerFriends;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60;
        [_tableView registerClass:[GetFriendsTableViewCell class] forCellReuseIdentifier:kIdentifier_getFriends];
    }
    return _tableView;
}

#pragma mark - DataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource[section] allValues][0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GetFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier_getFriends forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    NSString* str1 = [self.dataSource[indexPath.section] allValues][0][indexPath.row];
    NSString* newStr1 = [str1 substringFromIndex:(str1.length-1)];
    NSRange range = [str1 rangeOfString:@"+"];
    NSString* name = [str1 substringToIndex:range.location];
    
    cell.name = name;
    
    if ([newStr1 isEqualToString:@"@"]) { // 添加
        cell.isInviteOrAdd = 0;
    } else { // 邀请
        cell.isInviteOrAdd = 1;
    }
    
    __weak typeof(self) weakSelf = self;
    
    cell.ActionHandle = ^(NSIndexPath *index, BOOL isAdd){
        
        if (!isAdd) { // 邀请
            
            NSString *str1 = [weakSelf.dataSource[index.section] allValues][0][index.row];
            NSRange range = [str1 rangeOfString:@"+"];
            NSString *str2 = [str1 substringFromIndex:range.location];
            NSString *phone = [str2 stringByReplacingOccurrencesOfString:@"+" withString:@""];
            NSString *phoneString = [phone substringToIndex:[phone length] - 1];
            NSString *name = [str1 substringToIndex:range.location];
            
            InviteFriendViewController *invite = [[InviteFriendViewController alloc]init];
            invite.name = name;
            invite.phone = phoneString;
            [weakSelf.navigationController pushViewController:invite animated:YES];

        } else { // 添加
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"addfriendstitle", @"Localizable", Bundle, nil) message:NSLocalizedStringFromTableInBundle(@"addfriendsmsg", @"Localizable", Bundle, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    };

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource[section] allKeys][0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
