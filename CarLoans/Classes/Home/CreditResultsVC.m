//
//  CreditResultsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditResultsVC.h"
#import "CreditResultsTableView.h"
@interface CreditResultsVC ()<RefreshDelegate,BaseModelDelegate>
@property (nonatomic , strong)CreditResultsTableView *tableView;


@end
@implementation CreditResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"征信结果";
    [self initTableView];

}

- (void)initTableView {
    self.tableView = [[CreditResultsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataDic = self.dataDic;
    self.tableView.bankCreditReport = [self.dataDic[@"BankCreditReport"] componentsSeparatedByString:@"||"];
    self.tableView.dataCreditReport = [self.dataDic[@"dataCreditReport"] componentsSeparatedByString:@"||"];
    [self.view addSubview:self.tableView];
}

@end
