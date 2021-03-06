
//
//  WithLoanVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "WithLoanVC.h"
#import "WithLoanTableView.h"
@interface WithLoanVC ()<RefreshDelegate>
@property (nonatomic , strong)WithLoanTableView *tableView;
@end

@implementation WithLoanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[WithLoanTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630196";
    http.parameters[@"code"] = self.model.teamCode;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView.dataDic = responseObject[@"data"];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"返回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)throughBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)noThroughBtnClick
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632550";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"确认用款申请"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
}


@end
