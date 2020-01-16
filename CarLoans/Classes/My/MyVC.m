//
//  MyVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MyVC.h"
#import "ChangePhoneAndEmailVC.h"
#import "TLUserForgetPwdVC.h"
@interface MyVC ()<RefreshDelegate>
{
    NSDictionary *dataDic;
}


@property (nonatomic , strong)UIImageView *headImg;
@property (nonatomic , strong)UILabel *nameLbl1;
@property (nonatomic , strong)UILabel *nameLbl2;
@property (nonatomic , strong)UILabel *companyLbl;

@end
@implementation MyVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self updateUserInfoWithNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        
        dataDic =  responseObject[@"data"];
        //        self.tableView.dic = dataDic;
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self dataSet];
//        [self RedDotPromptDic:responseObject[@"data"]];
    } failure:^(NSError *error) {
        
    }];
}

-(void)RedDotPromptDic:(NSDictionary *)dict
{
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"632912";
    http.parameters[@"roleCode"] = dict[@"roleCode"];
    http.parameters[@"teamCode"] = dict[@"teamCode"];
    [http postWithSuccess:^(id responseObject) {
        
        //        self.tableView.RedDotDic = responseObject[@"data"];
        //        [self.tableView reloadData];
        
        
        
        
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

-(void)dataSet
{
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[dataDic[@"photo"] convertImageUrl]] placeholderImage:kImage(@"默认头像")];
    _nameLbl1.text = [NSString stringWithFormat:@"真实姓名：%@",[BaseModel convertNull: dataDic[@"realName"]]];
    _nameLbl2.text = [NSString stringWithFormat:@"角色名称：%@",dataDic[@"roleName"]];
    _companyLbl.numberOfLines = 2;
    _companyLbl.frame = CGRectMake(_headImg.xx + 13.5, 86.5, SCREEN_WIDTH - 13.5 - 30 - _headImg.xx , 16.5);
    _companyLbl.text = [NSString stringWithFormat:@"%@-%@-%@",[BaseModel convertNull: dataDic[@"companyName"]],[BaseModel convertNull:dataDic[@"departmentName"]],[BaseModel convertNull:dataDic[@"postName"]]];
    [_companyLbl sizeToFit];
    UILabel *label1 = [self.view viewWithTag:100];
    UILabel *label2 = [self.view viewWithTag:101];
    label1.text = dataDic[@"loginName"];
    label2.text = dataDic[@"mobile"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(16) textColor:kWhiteColor];
    titleLbl.text = @"我的";
    [self.view addSubview:titleLbl];
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, - 20, SCREEN_WIDTH, 103 + 20 - 64 + kNavigationBarHeight + kStatusBarHeight)];
    
    topImage.image = kImage(@"个人中心");
    [self.view addSubview:topImage];
    
    [@"123" isPhoneNum];
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15 , kNavigationBarHeight, SCREEN_WIDTH - 30, 140 )];
    backView.backgroundColor = kWhiteColor;
    backView.layer.cornerRadius= 4;
    backView.layer.shadowOpacity = 0.22;// 阴影透明度
    backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    backView.layer.shadowRadius= 3;// 阴影扩散的范围控制
    backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
    [self.view addSubview:backView];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35, 70, 70)];
    headImg.image = kImage(@"默认头像");
    self.headImg = headImg;
    [backView addSubview:headImg];
    
    UILabel *nameLbl1 = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 37.5, SCREEN_WIDTH - 13.5 - 30, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#333333")];
    self.nameLbl1 = nameLbl1;
    [backView addSubview:nameLbl1];
    
    UILabel *nameLbl2 = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 65, SCREEN_WIDTH - 13.5 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    self.nameLbl2 = nameLbl2;
    [backView addSubview:nameLbl2];
    
    UILabel *companyLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 86.5, SCREEN_WIDTH - 13.5 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    self.companyLbl = companyLbl;
    [backView addSubview:companyLbl];
    
    NSArray *array = @[@"登录名",@"手机号",@"修改登录密码"];
    for (int i = 0 ; i < 3; i ++) {
        
        
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backBtn.frame = CGRectMake(15, backView.yy + 15 + i %3 * 50, SCREEN_WIDTH - 30, 50);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backBtn.tag = i + 1000;
        [self.view addSubview:backBtn];
        
        
        UILabel *theTitleLbl = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 15 + i %3 * 50, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        theTitleLbl.text = array[i];
        [self.view addSubview:theTitleLbl];
        
        
        UILabel *rightLbl = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 15 + i %3 * 50, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        
        rightLbl.tag = 100 + i;
        
        if (i == 0) {
            rightLbl.frame = CGRectMake(15, backView.yy + 15 + i %3 * 50, SCREEN_WIDTH - 30, 50);
            rightLbl.text = @"";
        }else
        {
            rightLbl.frame = CGRectMake(15, backView.yy + 15 + i %3 * 50, SCREEN_WIDTH - 30 - 14, 50);
            
            UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 24.5,backView.yy + 15 + i %3 * 50  + 19, 7, 12)];
            youImg.image = kImage(@"跳转");
            [self.view addSubview:youImg];
            
        }
        [self.view addSubview:rightLbl];
        
        
        UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(15, theTitleLbl.yy, SCREEN_WIDTH - 30, 1)];
        LineView.backgroundColor = kLineColor;
        [self.view addSubview:LineView];
    }
    
    
    UIButton *switchAccountBtn = [UIButton buttonWithTitle:@"切换账号" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:14];
    kViewBorderRadius(switchAccountBtn, 2, 1, kAppCustomMainColor);
    switchAccountBtn.frame = CGRectMake(15, backView.yy + 15 + 150 + 40, SCREEN_WIDTH - 30, 45);
    [switchAccountBtn addTarget:self action:@selector(switchAccountBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:switchAccountBtn];
    
}

-(void)switchAccountBtnClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退出登录" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
        LoginVC *vc = [[LoginVC alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [USERDEFAULTS removeObjectForKey:USER_ID];
        [USERDEFAULTS removeObjectForKey:TOKEN_ID];
        window.rootViewController = nvc;
    } confirm:^(UIAlertAction *action) {
        
    }];
}

-(void)backBtnClick:(UIButton *)sender
{
    switch (sender.tag - 1000) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            ChangePhoneAndEmailVC *vc = [ChangePhoneAndEmailVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            TLUserForgetPwdVC *vc = [TLUserForgetPwdVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
