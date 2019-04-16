//
//  VehiclesInDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "VehiclesInDetailsVC.h"
#import "VehiclesInDetailsTableView.h"
@interface VehiclesInDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)VehiclesInDetailsTableView *tableView;

@end

@implementation VehiclesInDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[VehiclesInDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
