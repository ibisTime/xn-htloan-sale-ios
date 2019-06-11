//
//  WaterVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "WaterVC.h"

@interface WaterVC ()<RefreshDelegate>
@property (nonatomic,strong) WaterTableView * tableView;
@end

@implementation WaterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"流水信息";
    [self initTableView];
}
-(void)initTableView
{
    self.tableView = [[WaterTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.waterDic = self.waterDic;
    [self.view addSubview:self.tableView];
}


@end
