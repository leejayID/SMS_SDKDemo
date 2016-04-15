//
//  SelectCountryViewController.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/3/30.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "SelectCountryViewController.h"

@interface SelectCountryViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *keys;

@end

@implementation SelectCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedStringFromTableInBundle(@"countrychoose", @"Localizable", Bundle, nil);
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSMutableArray *keys = [NSMutableArray array];
    [keys addObjectsFromArray:[[dict allKeys]sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keys;
    
    NSMutableArray *datas = [NSMutableArray array];
    for (NSString *key in keys) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[dict[key] sortedArrayUsingSelector:@selector(compare:)] forKey:key];
        [datas addObject:dic];
    }
    self.dataSource = datas;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Getters
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString *text = [self.dataSource[indexPath.section] allValues][0][indexPath.row];
    NSRange range = [text rangeOfString:@"+"];
    NSString *subText = [text substringFromIndex:range.location];
    NSString *areaCode = [subText stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString *countryName = [text substringToIndex:range.location];
    
    cell.textLabel.text = countryName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"+%@",areaCode];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource[section] allKeys][0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSString *key = [self.dataSource[index] allKeys][0];
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }else {
        return index;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = [self.dataSource[indexPath.section] allValues][0][indexPath.row];
    NSRange range = [text rangeOfString:@"+"];
    NSString *subText = [text substringFromIndex:range.location];
    NSString *areaCode = [subText stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString *countryName = [text substringToIndex:range.location];
    
    SMSSDKCountryAndAreaCode *country = [[SMSSDKCountryAndAreaCode alloc] init];
    country.countryName = countryName;
    country.areaCode = areaCode;
    
    if ([self.delegate respondsToSelector:@selector(selectCountryAndAreaCode:)]) {
        [self.delegate selectCountryAndAreaCode:country];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
