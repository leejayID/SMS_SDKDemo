//
//  RegisterViewController.m
//  SMS_SDKDemo
//
//  Created by LeeJay on 16/4/1.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "RegisterViewController.h"
#import "SelectCountryViewController.h"
#import "UIButton+CountDown.h"
#import "NSString+Extension.h"

@interface RegisterViewController () <SelectCountryDelegate,UIAlertViewDelegate>

@end

@implementation RegisterViewController
{
    UIButton *_countryCodeBtn;
    UITextField *_phoneNumText;
    UITextField *_verifyCodeText;
    UIButton *_nextBtn;
    UIButton *_countDownBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
}

- (void)configureUI {
    
    UILabel *noticeLabel = [[UILabel alloc]init];
    noticeLabel.numberOfLines = 0;
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.text = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"labelnotice", @"Localizable", Bundle, nil)];
    [self.view addSubview:noticeLabel];
    
    _countryCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_countryCodeBtn setTitle:@"+86" forState:0];
    [_countryCodeBtn addTarget:self action:@selector(selectCountryCode:) forControlEvents:UIControlEventTouchUpInside];
    [_countryCodeBtn setTitleColor:[UIColor grayColor] forState:0];
    [self.view addSubview:_countryCodeBtn];
    
    _phoneNumText = [[UITextField alloc]init];
    _phoneNumText.placeholder = NSLocalizedStringFromTableInBundle(@"telfield", @"Localizable", Bundle, nil);
    _phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumText];
    
    UILabel *verifyCodeLabel = [[UILabel alloc]init];
    verifyCodeLabel.text = @"验证码";
    verifyCodeLabel.textColor = [UIColor grayColor];
    verifyCodeLabel.font = [UIFont systemFontOfSize:15];
    verifyCodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:verifyCodeLabel];
    
    _verifyCodeText = [[UITextField alloc]init];
    _verifyCodeText.placeholder = NSLocalizedStringFromTableInBundle(@"verifycode", @"Localizable", Bundle, nil);
    _verifyCodeText.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_verifyCodeText];
    
    _countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_countDownBtn setTitle:@"获取验证码" forState:0];
    _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countDownBtn setBackgroundColor:[UIColor orangeColor]];
    [_countDownBtn addTarget:self action:@selector(onCountDownBtn:) forControlEvents:UIControlEventTouchUpInside];
    _countDownBtn.layer.cornerRadius = 10;
    _countDownBtn.layer.masksToBounds = YES;
    [self.view addSubview:_countDownBtn];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:NSLocalizedStringFromTableInBundle(@"nextbtn", @"Localizable", Bundle, nil) forState:0];
    [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    _nextBtn.enabled = NO;
    _nextBtn.layer.cornerRadius = 20;
    _nextBtn.layer.masksToBounds = YES;
    [_nextBtn addTarget:self action:@selector(onNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [_countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(noticeLabel.mas_bottom).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    [_phoneNumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countryCodeBtn.mas_right).offset(10);
        make.top.equalTo(noticeLabel.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [verifyCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(_countryCodeBtn.mas_bottom).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    [_verifyCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countryCodeBtn.mas_bottom).offset(10);
        make.left.equalTo(_countryCodeBtn.mas_right).offset(10);
        make.right.equalTo(_countDownBtn.mas_left).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@100);
        make.top.equalTo(_countryCodeBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyCodeLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
}

#pragma mark - Actions
- (void)textFieldDidChange:(UITextField *)text {
    if (text.text.length == 4) {
        _nextBtn.enabled = YES;
        [_nextBtn setBackgroundColor:[UIColor greenColor]];
    } else {
        _nextBtn.enabled = NO;
        [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (void)onNextBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if(_verifyCodeText.text.length != 4) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"notice", @"Localizable", Bundle, nil)
                                                        message:NSLocalizedStringFromTableInBundle(@"verifycodeformaterror", @"Localizable", Bundle, nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSString *zone = [_countryCodeBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    /**
     * @brief              提交验证码(Commit the verification code)
     *
     * @param code         验证码(Verification code)
     * @param phoneNumber  电话号码(The phone number)
     * @param zone         区域号，不要加"+"号(Area code)
     * @param result       请求结果回调(Results of the request)
     */
    [SMSSDK commitVerificationCode:_verifyCodeText.text phoneNumber:_phoneNumText.text zone:zone result:^(NSError *error) {
        
        if (!error) { // 验证成功
            
            NSString *messageStr = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"verifycoderightmsg", @"Localizable", Bundle, nil)];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"verifycoderighttitle", @"Localizable", Bundle, nil)
                                                            message:messageStr
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                                  otherButtonTitles:nil, nil];
            alert.tag = 222;
            [alert show];
            
        } else { // 验证失败
            
            NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"verifycodeerrortitle", @"Localizable", Bundle, nil)
                                                            message:NSLocalizedStringFromTableInBundle(messageStr, @"Localizable", Bundle, nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }];
}

- (void)selectCountryCode:(UIButton *)sender {
    
    SelectCountryViewController *select = [[SelectCountryViewController alloc]init];
    select.delegate = self;
    [self.navigationController pushViewController:select animated:YES];
}

- (void)onCountDownBtn:(UIButton *)sender {
    
    PhoneNumType type;
    if ([_countryCodeBtn.titleLabel.text isEqualToString:@"+86"]) {
        type = ChinesePhoneStringType; // 中国区手机号
    } else {
        type = OthersPhoneStringType; // 其他国家手机号
    }
        
    int compareResult = 0;
    if (![_phoneNumText.text phoneNumStringIsLegal:type]) {
        
        compareResult = 1;
        
        // 手机号码格式不正确
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"notice", @"Localizable", Bundle, nil)
                                                        message:NSLocalizedStringFromTableInBundle(@"errorphonenumber", @"Localizable", Bundle, nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if (!compareResult) {
        if (_phoneNumText.text.length != 11) {
            
            // 手机号码格式不正确
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"notice", @"Localizable", Bundle, nil)
                                                            message:NSLocalizedStringFromTableInBundle(@"errorphonenumber", @"Localizable", Bundle, nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    }
    
    NSString *messageStr = [NSString stringWithFormat:@"%@:%@ %@",NSLocalizedStringFromTableInBundle(@"willsendthecodeto", @"Localizable", Bundle, nil),_countryCodeBtn.titleLabel.text,_phoneNumText.text];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"surephonenumber", @"Localizable", Bundle, nil)
                                                    message:messageStr delegate:self
                                          cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"cancel", @"Localizable", Bundle, nil)
                                          otherButtonTitles:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil), nil];
    alert.tag = 111;
    [alert show];
    
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 111) {
        if (1 == buttonIndex){
            NSString *zone = [_countryCodeBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
            
            /**
             *  @brief                   获取验证码(Get verification code)
             *
             *  @param method            获取验证码的方法(The method of getting verificationCode)
             *  @param phoneNumber       电话号码(The phone number)
             *  @param zone              区域号，不要加"+"号(Area code)
             *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
             *  @param result            请求结果回调(Results of the request)
             */
            [SMSSDK getVerificationCodeByMethod:self.getCodeType phoneNumber:_phoneNumText.text zone:zone customIdentifier:nil result:^(NSError *error) {
                
                if (!error) { // 发送成功
                    
                    [_countDownBtn startWithTimeInterval:60 normalTitle:@"获取验证码" disableTitle:@"s重新获取" normalColor:[UIColor orangeColor] disableColor:[UIColor lightGrayColor]];
                    
                } else { // 发送失败
                    
                    NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTableInBundle(@"codesenderrtitle", @"Localizable", Bundle, nil)
                                                                    message:NSLocalizedStringFromTableInBundle(messageStr, @"Localizable", Bundle, nil)
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", Bundle, nil)
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
            }];
        }
    }
    
    if (alertView.tag == 222) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - SelectCountryDelegate
- (void)selectCountryAndAreaCode:(SMSSDKCountryAndAreaCode *)data {
    NSString *title = [NSString stringWithFormat:@"+%@",data.areaCode];
    [_countryCodeBtn setTitle:title forState:0];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
