//
//  InviteFriendViewController.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/5.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "InviteFriendViewController.h"

@interface InviteFriendViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - footerView
- (UIView *)footerView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.frame = CGRectMake(0, 10, self.view.frame.size.width, 30);
    descLabel.text = [NSString stringWithFormat:@"%@%@",self.name,NSLocalizedStringFromTableInBundle(@"notjoined", @"Localizable", Bundle, nil)];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    [view addSubview:descLabel];
    
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [inviteBtn setTitle:NSLocalizedStringFromTableInBundle(@"sendinvite", @"Localizable", Bundle, nil) forState:UIControlStateNormal];
    NSString *imageString = [Bundle pathForResource:@"button4" ofType:@"png"];
    [inviteBtn setBackgroundImage:[[UIImage alloc]initWithContentsOfFile:imageString] forState:UIControlStateNormal];
    inviteBtn.frame = CGRectMake(15, 50, self.view.frame.size.width - 30, 42);
    [inviteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [inviteBtn addTarget:self action:@selector(onInviteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:inviteBtn];
    
    return view;
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [self footerView];
    }
    return _tableView;
}

#pragma mark - DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.name;
    cell.detailTextLabel.text = self.phone;
    return cell;
}

#pragma mark - Action
- (void)onInviteBtnClick {
    
    [SMSSDK sendSMS:self.phone AndMessage:NSLocalizedStringFromTableInBundle(@"smsmessage", @"Localizable", Bundle, nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
