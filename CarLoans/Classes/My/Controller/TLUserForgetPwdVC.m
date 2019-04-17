//
//  TLUserForgetPwdVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLUserForgetPwdVC.h"

@interface TLUserForgetPwdVC ()

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;


@end

@implementation TLUserForgetPwdVC
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改密码";
    self.view.backgroundColor = kWhiteColor;
    [self initSubviews];
}


- (void)initSubviews {
    
    NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults]objectForKey:USERDATA];
    NSArray *array = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请确认密码"];
    for (int i = 0 ; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = array[i];
        [textField setValue:Font(16) forKeyPath:@"_placeholderLabel.font"];
        textField.font = Font(16);
        //        self.pwdTf = textField;
        [self.view addSubview:textField];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, textField.yy, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
        
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        switch (i) {
            case 0:
            {
                ;
                self.phoneTf = textField;
                if ([BaseModel isBlankString:dataDic[@"mobile"]] == NO) {
                    self.phoneTf.text = dataDic[@"mobile"];
                    self.phoneTf.enabled = YES;
                }
                
                
            }
                break;
            case 1:
            {
                self.codeTf = textField;
                
                UIButton *codeBtn = [UIButton buttonWithTitle:@"获取验证码" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:13];
                [codeBtn sizeToFit];
                codeBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - codeBtn.width - 30, textField.y + 10, codeBtn.width + 30, 30);
                kViewBorderRadius(codeBtn, 2, 1, kAppCustomMainColor);
                [codeBtn addTarget:self action:@selector(sendCaptcha:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 2:
            {
                if ([self.titleString isEqualToString:@"设置交易密码"]) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                if ([self.titleString isEqualToString:@"修改交易密码"]) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                self.pwdTf = textField;
                textField.secureTextEntry = YES;
                
            }
                break;
            case 3:
            {
                if ([self.titleString isEqualToString:@"设置交易密码"]) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                if ([self.titleString isEqualToString:@"修改交易密码"]) {
                    textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                self.rePwdTf = textField;
                textField.secureTextEntry = YES;
                
            }
                break;
                
            default:
                break;
        }
        
    }
    UIButton *changePwdBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16.0 cornerRadius:5];
    changePwdBtn.frame = CGRectMake(15, self.rePwdTf.yy + 66, SCREEN_WIDTH - 30, 48);
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePwdBtn];
}



#pragma mark - Events
- (void)sendCaptcha:(UIButton *)sender {
    if (![self.phoneTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入正确的手机号"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if ([self.phoneTf.text hasPrefix:@"@"]) {
        http.code = @"630093";
        http.parameters[@"email"] = self.phoneTf.text;
        
    }else
    {
        http.code = CAPTCHA_CODE;
        http.parameters[@"mobile"] = self.phoneTf.text;
    }
    
    http.parameters[@"client"] = @"ios";
//    http.parameters[@"sessionId"] = sessionId;
    http.parameters[@"bizType"] = @"805063";
    
    
    
//    http.parameters[@"interCode"] = [NSString stringWithFormat:@"00%@",[self.PhoneCode.text substringFromIndex:1]];
    
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"验证码已发送,请注意查收"];
        [[BaseModel user] phoneCode:sender];
//        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)changePwd {
    if ([self.phoneTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入正确的手机号"];
        return;
    }
    if ([self.codeTf.text  isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入正确的验证码"];
        return;
    }
    if ([self.pwdTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入密码"];
        return;
    }
    if (![self.pwdTf.text isEqualToString:self.rePwdTf.text]) {
        [TLAlert alertWithInfo:@"输入的密码不一致"];
        return;
    }
    
    [self.view endEditing:YES];

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    if (self.pwdTf.text.length < 6 || self.pwdTf.text.length > 16) {
        [TLAlert alertWithInfo:@"密码必须为6~16个字符或数字组成"];
        return;
    }
    
    http.code = @"805063";
    http.parameters[@"mobile"] = self.phoneTf.text;
    http.parameters[@"smsCaptcha"] = self.codeTf.text;
    http.parameters[@"newLoginPwd"] = self.pwdTf.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        [self requesUserInfoWithResponseObject];
        
        
    } failure:^(NSError *error) {

    }];
}

- (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}



- (void)requesUserInfoWithResponseObject
{
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"设置成功"];
        //        self.tableView.dic = dataDic;
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}


- (void)setUserInfoWithDict:(NSDictionary *)dict
{
    [USERDEFAULTS setObject:dict forKey:USERDATA];
    [USERDEFAULTS setObject:dict[@"roleCode"] forKey:ROLECODE];
    [USERDEFAULTS setObject:dict[@"postCode"] forKey:ROSTCODE];
    [USERDEFAULTS setObject:dict[@"teamCode"] forKey:TEAMCODE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
