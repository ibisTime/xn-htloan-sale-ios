//
//  CreditDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsVC.h"
#import "CreditDetailsTableView.h"
#import "CreditDetailsPeopleVC.h"
@interface CreditDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)CreditDetailsTableView *tableView;

@end

@implementation CreditDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"征信单详情";
}

-(void)initTableView
{
    self.tableView = [[CreditDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
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
        CreditDetailsPeopleVC *vc = [CreditDetailsPeopleVC new];
        vc.dataDic = self.model.credit[@"creditUserList"][indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
