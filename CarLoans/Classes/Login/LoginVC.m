//
//  LoginVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "LoginVC.h"
#import "HomeVC.h"
#import "ChangePasswordVC.h"
#import "TLTabBarController.h"
#import "RegisteredViewController.h"
@interface LoginVC ()

@property (nonatomic , strong)UITextField *mobileTextFd;

@property (nonatomic , strong)UITextField *passWordTextFd;

@property (nonatomic , strong)UIButton *ForgotPasswordButton;

@property (nonatomic , strong)UIButton *loginButton;

@property (nonatomic,strong) NSString * cvalue;

@end

@implementation LoginVC

-(UIButton *)ForgotPasswordButton
{
    if (!_ForgotPasswordButton) {
        _ForgotPasswordButton = [UIButton buttonWithTitle:@"忘记密码?" titleColor:GaryTextColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        _ForgotPasswordButton.frame = CGRectMake(SCREEN_WIDTH - 95, 130, 80, 20);
        [_ForgotPasswordButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _ForgotPasswordButton.tag = 100;
        _ForgotPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _ForgotPasswordButton;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithTitle:@"登录" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:5];

        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        
        _loginButton.frame = CGRectMake(20, 205, SCREEN_WIDTH - 40, 50);

        [_loginButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _loginButton.tag = 101;
    }
    return _loginButton;
}

-(void)buttonMethodClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        ChangePasswordVC *vc = [ChangePasswordVC new];
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        vc.state = @"100";
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (sender.tag == 102){
        RegisteredViewController *vc = [[RegisteredViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        if ([_mobileTextFd.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入手机号"];
            return;
        }
        if ([_passWordTextFd.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入密码"];
            return;
        }
        
        _loginButton.selected = sender.selected;
        TLNetworking *http = [TLNetworking new];
        http.code = @"630051";
        http.showView = self.view;
        http.parameters[@"type"] = @"P";
        http.parameters[@"loginName"] = _mobileTextFd.text;
        http.parameters[@"loginPwd"] = _passWordTextFd.text;

        [http postWithSuccess:^(id responseObject) {
            WGLog(@"%@",responseObject);
            [USERDEFAULTS setObject:responseObject[@"data"][@"token"] forKey:TOKEN_ID];
            [USERDEFAULTS setObject:responseObject[@"data"][@"userId"] forKey:USER_ID];


            [self updateUserInfoWithNotification];




        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];

    }
}

- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
    
    [http postWithSuccess:^(id responseObject) {
        TLTabBarController *vc = [TLTabBarController new];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = vc;
        [self setUserInfoWithDict:responseObject[@"data"]];

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self customTypeSetUp];
    [self.view addSubview:self.ForgotPasswordButton];
    [self.view addSubview:self.loginButton];
    
    [self setbutton];
    
    
}

-(void)setbutton{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630047";
        http.showView = self.view;
        http.parameters[@"key"] = @"is_register";
        http.parameters[@"roleCode"] = @"SR201800000000000000YWY";
        http.parameters[@"postCode"] = @"DP201906061418229735934";
        http.parameters[@"type"] = @"i";
        [http postWithSuccess:^(id responseObject) {
            self.cvalue = responseObject[@"data"][@"cvalue"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.cvalue isEqualToString:@"1"]) {
                    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
                    self.RightButton.titleLabel.font = Font(16);
                    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-50, 30, 50, 50)];
                    [self.RightButton setTitle:@"注册" forState:(UIControlStateNormal)];
                    self.RightButton.tag = 102;
                    [self.RightButton addTarget:self action:@selector(buttonMethodClick:) forControlEvents:(UIControlEventTouchUpInside)];
                }
            });
            
        }failure:^(NSError *error) {
            
        }];
        
        
    });
}


-(void)customTypeSetUp
{
    self.title = @"登录";

    _mobileTextFd = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55)];
    _mobileTextFd.font = HGfont(16);
//    _mobileTextFd.delegate = self;
    _mobileTextFd.placeholder = @"请输入账号";
    [_mobileTextFd setValue:HGfont(16) forKeyPath:@"_placeholderLabel.font"];
//    [_mobileTextFd setValue:GaryTextColor forKeyPath:@"_placeholderLabel.color"];
    [self.view addSubview:_mobileTextFd];

    _passWordTextFd = [[UITextField alloc]initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH - 30, 55)];
    _passWordTextFd.font = HGfont(16);
//    _passWordTextFd.delegate = self;

    _passWordTextFd.placeholder = @"请输入密码";
    _passWordTextFd.secureTextEntry = YES;
    [_passWordTextFd setValue:HGfont(16) forKeyPath:@"_placeholderLabel.font"];
//    [_passWordTextFd setValue:GaryTextColor forKeyPath:@"_placeholderLabel.color"];
    [self.view addSubview:_passWordTextFd];


    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 55, SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];

    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 110, SCREEN_WIDTH - 30, 1)];
    lineView1.backgroundColor = kLineColor;
    [self.view addSubview:lineView1];

}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setbutton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

@end
