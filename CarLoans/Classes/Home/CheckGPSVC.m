//
//  CheckGPSVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckGPSVC.h"
#import "CheckGPSTableView.h"
@interface CheckGPSVC ()<RefreshDelegate>
@property (nonatomic,strong) CheckGPSTableView * tableView;
@end

@implementation CheckGPSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS审核";
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView {
    self.tableView = [[CheckGPSTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
//    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.peopleAray = self.peopleAray;
    [self.view addSubview:self.tableView];
}
@end
