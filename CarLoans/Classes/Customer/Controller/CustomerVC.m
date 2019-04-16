//
//  CustomerVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerVC.h"
#import "CustomerTableView.h"
@interface CustomerVC ()<RefreshDelegate>
@property (nonatomic , strong)CustomerTableView *tableView;


@end


@implementation CustomerVC



- (void)viewDidLoad {
    self.title = @"客户";
    [self initTableView];
    [self initNavigationController];
}

-(void)initTableView
{
    self.tableView = [[CustomerTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


@end
