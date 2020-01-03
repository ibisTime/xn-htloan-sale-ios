//
//  TaskManagementVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TaskManagementVC.h"
#import "TaskManagementTableView.h"
#import "AddTaskVC1.h"
@interface TaskManagementVC ()<RefreshDelegate>

@property (nonatomic , strong)TaskManagementTableView *tableView;

@end

@implementation TaskManagementVC

-(void)viewWillDisappear:(BOOL)animated
{
    self.returnAryBlock1(self.missionList);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"任务管理";
    [self initTableView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"新增" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630066";
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.tableView.saleUserIdAry = responseObject[@"data"];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}



-(void)rightButtonClick
{
    AddTaskVC1 *vc = [AddTaskVC1 new];
    CarLoansWeakSelf;
    vc.returnAryBlock = ^(NSDictionary *missionDic, NSInteger row) {
        NSMutableArray *ary = [NSMutableArray array];
        [ary addObjectsFromArray:self.tableView.missionList];
        [ary addObject:missionDic];
        weakSelf.missionList = ary;
        weakSelf.tableView.missionList = ary;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initTableView
{
    self.tableView = [[TaskManagementTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.missionList = self.missionList;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddTaskVC1 *vc = [AddTaskVC1 new];
    vc.row = indexPath.row + 100;
    vc.dataDic = self.missionList[indexPath.row];
    CarLoansWeakSelf;
    vc.returnAryBlock = ^(NSDictionary *missionDic, NSInteger row) {
        NSMutableArray *ary = [NSMutableArray array];
        [ary addObjectsFromArray:self.tableView.missionList];
        //            [ary addObject:missionDic];
        [ary replaceObjectAtIndex:row - 100 withObject:missionDic];
        weakSelf.missionList = ary;
        weakSelf.tableView.missionList = ary;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
