//
//  RepaymentPlanVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanVC.h"
#import "RepaymentPlanTableView.h"
#import "RepaymentPlanHeadView.h"
@interface RepaymentPlanVC ()<RefreshDelegate>
@property (nonatomic , strong)RepaymentPlanTableView *tableView;
@property (nonatomic , strong)RepaymentPlanHeadView *headView;

@end

@implementation RepaymentPlanVC

-(RepaymentPlanHeadView *)headView
{
    if (!_headView) {
        _headView = [[RepaymentPlanHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        
    }
    return _headView;
}

- (void)viewDidLoad {
    self.title = @"还款计划表";
    [self initTableView];
    [self initNavigationController];
}

-(void)initTableView
{
    self.tableView = [[RepaymentPlanTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
