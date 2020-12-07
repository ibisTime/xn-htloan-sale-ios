//
//  ChangePhoneAndEmailVC.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/28.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "ChangePhoneAndEmailVC.h"

@interface ChangePhoneAndEmailVC ()

@property (nonatomic,strong) UITextField *phoneTf;
@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UITextField *pwdTf;
@property (nonatomic,strong) UITextField *rePwdTf;

@end

@implementation ChangePhoneAndEmailVC

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    if (@available(iOS 13.0, *)) {[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;} else {[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;}
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机号";
    self.view.backgroundColor = kWhiteColor;
    [self initSubviews];
}


- (void)initSubviews {
    NSArray *array;
    NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults]objectForKey:USERDATA];
    array = @[@"请输入手机号",@"请输入验证码",@"新手机号",@"请输入验证码"];
    for (int i = 0 ; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30, 50)];
        textField.placeholder = array[i];
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
                codeBtn.tag = 100;
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                
            }
                break;
            case 2:
            {
                self.pwdTf = textField;
            }
                break;
            case 3:
            {
                self.rePwdTf = textField;
                UIButton *codeBtn = [UIButton buttonWithTitle:@"获取验证码" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:13];
                [codeBtn sizeToFit];
                codeBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - codeBtn.width - 30, textField.y + 10, codeBtn.width + 30, 30);
                kViewBorderRadius(codeBtn, 2, 1, kAppCustomMainColor);
                [codeBtn addTarget:self action:@selector(sendCaptcha:) forControlEvents:(UIControlEventTouchUpInside)];
                [self.view addSubview:codeBtn];
                
                textField.frame = CGRectMake(15, 20 + i% 4 * 60, SCREEN_WIDTH - 30 - codeBtn.width - 10, 50);
                
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
    
    if (sender.tag == 100) {
        if ([self.phoneTf.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入正确的手机号"];
            return;
        }
    }else
    {
        if ([self.pwdTf.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入正确的手机号"];
            return;
        }
    }
    
    TLNetworking *http = [TLNetworking new];

    http.code = VERIFICATION_CODE_CODE;
    http.showView = self.view;
    http.parameters[@"kind"] = @"B";
    http.parameters[@"bizType"] = @"630052";
    if (sender.tag == 100) {
        http.parameters[@"mobile"] = self.phoneTf.text;
    }
    else
    {
        http.parameters[@"mobile"] = self.pwdTf.text;
    }
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
        [TLAlert alertWithInfo:@"请输入新手机号"];
        return;
    }
    if ([self.rePwdTf.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"输入的新手机号验证码"];
        return;
    }
    
    
    [self.view endEditing:YES];
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
    http.code = @"630052";
    http.parameters[@"oldMobile"] = self.phoneTf.text;
    http.parameters[@"oldCaptcha"] = self.codeTf.text;
    http.parameters[@"newMobile"] = self.pwdTf.text;
    http.parameters[@"newCaptcha"] = self.rePwdTf.text;
    
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

    [http postWithSuccess:^(id responseObject) {
        
        [self requesUserInfoWithResponseObject];
        
       
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)requesUserInfoWithResponseObject
{
    TLNetworking *http = [TLNetworking new];
    //    http.showView = self.view;
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"修改成功"];
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

@end
