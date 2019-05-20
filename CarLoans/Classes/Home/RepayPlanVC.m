//
//  RepayPlanVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "RepayPlanVC.h"
#import "RepayPlanTableView.h"
@interface RepayPlanVC ()<RefreshDelegate>
@property (nonatomic,strong) RepayPlanTableView * tableView;
@end

@implementation RepayPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款计划";
    [self initTableView];
}
- (void)initTableView {
    self.tableView = [[RepayPlanTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


@end
