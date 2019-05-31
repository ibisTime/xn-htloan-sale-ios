//
//  CheckRepayDetailsVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckRepayDetailsVC.h"
#import "CheckRepayDetailsTableView.h"
@interface CheckRepayDetailsVC ()<RefreshDelegate>
@property (nonatomic,strong) CheckRepayDetailsTableView * tableView;
@property (nonatomic,strong) RepayModel * model;
@end

@implementation CheckRepayDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务详情";
    TLNetworking * http = [TLNetworking new];
    http.code = @"630521";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [RepayModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initTableView {
    self.tableView = [[CheckRepayDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    
    NSLog(@"overdueAmounttttt");
    NSLog(@"overdueAmounttttt = %.2f",[self.model.overdueAmount floatValue]/1000);
}

@end
