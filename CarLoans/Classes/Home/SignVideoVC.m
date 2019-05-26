//
//  SignVideoVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SignVideoVC.h"
#import "SignVideoTableView.h"
@interface SignVideoVC ()<RefreshDelegate>
@property (nonatomic,strong) SignVideoTableView * tableView;
@end

@implementation SignVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title = @"面签视频";
    // Do any additional setup after loading the view.
}


- (void)initTableView {
    self.tableView = [[SignVideoTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.array = self.Array;
    self.tableView.BankVideoArray = self.BankVideoArray;
    self.tableView.CompanyVideoArray = self.CompanyVideoArray;
    self.tableView.idreverse = self.idreverse;
    self.tableView.idfront = self.idfront;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
@end
