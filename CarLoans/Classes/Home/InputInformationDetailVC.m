//
//  InputInformationDetailVC.m
//  CarLoans
//
//  Created by shaojianfei on 2018/12/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InputInformationDetailVC.h"
#import "VehiclesInDetailsTableView.h"
#import "WSDatePickerView.h"
#import "CarDetailTb.h"
@interface InputInformationDetailVC ()<RefreshDelegate>

@property (nonatomic , strong)CarDetailTb *tableView;

@end

@implementation InputInformationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self loaddetails];
}
-(void)loaddetails{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else
        http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",[AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]]);
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)initTableView {
    self.tableView = [[CarDetailTb alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
