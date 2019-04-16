//
//  MyVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MyVC.h"
@interface MyVC ()<RefreshDelegate>

@end
@implementation MyVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    [backView addSubview:headImg];
    
    UILabel *nameLbl1 = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 37.5, SCREEN_WIDTH - 13.5 - 30, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#333333")];
    nameLbl1.text = @"真实姓名：张三";
    [backView addSubview:nameLbl1];
    
    UILabel *nameLbl2 = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 65, SCREEN_WIDTH - 13.5 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    nameLbl2.text = @"角色名称：李四";
    [backView addSubview:nameLbl2];
    
    UILabel *companyLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 13.5, 86.5, SCREEN_WIDTH - 13.5 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
    companyLbl.text = @"杭州余杭公司研发部门UI设计";
    [backView addSubview:companyLbl];
    
    NSArray *array = @[@"登录名",@"手机号",@"修改登录密码"];
    for (int i = 0 ; i < 3; i ++) {
        UILabel *theTitle = [UILabel labelWithFrame:CGRectMake(15, backView.yy + 15, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        theTitle.text = array[i];
        [self.view addSubview:titleLbl];
    }
    
}


@end
