//
//  OperationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "OperationVC.h"
#import "OperationTableView.h"
@interface OperationVC ()<RefreshDelegate>
@property (nonatomic , strong)OperationTableView *tableView;


@end
@implementation OperationVC


- (void)viewDidLoad {
    self.title = @"操作日志";
    [self initTableView];
    [self initNavigationController];
}

-(void)initTableView
{
    self.tableView = [[OperationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.bizLogs = self.bizLogs;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
