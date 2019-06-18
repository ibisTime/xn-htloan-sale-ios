//
//  BankResultVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BankResultVC.h"
#import "BankResultTableView.h"
@interface BankResultVC ()<RefreshDelegate>
@property (nonatomic,strong) BankResultTableView * tableView;
@end

@implementation BankResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行征信结果";
    
}

- (void)initTableView {
    self.tableView = [[BankResultTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataDic = self.dataDic;
    [self.view addSubview:self.tableView];
    
    
}

@end
