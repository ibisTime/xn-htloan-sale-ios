//
//  CustomerDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerDetailsVC.h"
#import "CustomerDetailsTableView.h"
#import "OperationVC.h"
#import "AdmissionDetailsVC.h"
#import "AttachmentPoolVC.h"
#import "RepaymentPlanVC.h"
#import "TodoViewController.h"
#import "CreditDetailsVC.h"
@interface CustomerDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)CustomerDetailsTableView *tableView;

@end

@implementation CustomerDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"业务详情";
}

-(void)initTableView
{
    self.tableView = [[CustomerDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataArray = self.dataArray;
    self.tableView.model = self.model;
    for (int i = 0; i < self.dataArray.count; i ++) {
        if ([self.dataArray[i][@"dkey"] isEqualToString:_model.status]) {
            self.tableView.state = self.dataArray[i][@"dvalue"];
        }
    }
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (self.model.bizTasks.count == 0) {
                [TLAlert alertWithInfo:@"无代办事项"];
                return;
                
            }
            TodoViewController *vc = [TodoViewController new];
            vc.bizTasks = self.model.bizTasks;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            OperationVC *vc = [OperationVC new];
            vc.bizLogs = self.model.bizLogs;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2) {
            CreditDetailsVC *vc = [CreditDetailsVC new];
            vc.model = self.model;
            vc.dataArray = self.dataArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 3) {
            AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
            [self.navigationController pushViewController:vc animated:YES];

        }
        if (indexPath.row == 4) {
            AttachmentPoolVC *vc = [AttachmentPoolVC  new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 5) {
            RepaymentPlanVC *vc = [RepaymentPlanVC  new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
 
    
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
