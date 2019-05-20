//
//  SettlementAuditVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SettlementAuditVC.h"
#import "SettlementAuditTableView.h"
#import "SettlementAuditModel.h"
#import "SettlementAuditDetailsVC.h"
//
#import "DepartmentAuditVC.h"

#import "ManagerAuditVC.h"
@interface SettlementAuditVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;
@property (nonatomic , strong)SettlementAuditTableView *tableView;
@end

@implementation SettlementAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self LoadData];
    self.title = @"结清审核";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self LoadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}

- (void)initTableView {
    self.tableView = [[SettlementAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"003_02"]) {
        DepartmentAuditVC * vc = [DepartmentAuditVC new];
        vc.model =self.model[index];
        vc.title = @"清欠催收部审核";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([state isEqualToString:@"003_03"]) {
        SettlementAuditDetailsVC *vc = [SettlementAuditDetailsVC new];
        vc.model = self.model[index];
        vc.title = @"驻行人员审核";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([state isEqualToString:@"003_04"]) {
        ManagerAuditVC *vc = [ManagerAuditVC new];
        vc.model = self.model[index];
        vc.title = @"总经理审核";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([state isEqualToString:@"003_05"]) {
        ManagerAuditVC *vc = [ManagerAuditVC new];
        vc.model = self.model[index];
        vc.title = @"财务审核";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630520";
    NSArray *array = @[@"003_02",@"003_03",@"003_04",@"003_05"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.parameters[@"refType"] = @"0";
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SettlementAuditModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SettlementAuditModel *model = (SettlementAuditModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {

        }];
    }];
    [self.tableView addLoadMoreAction:^{

        NSArray *array = @[@"003_02",@"003_03",@"003_04",@"003_05"];
        helper.parameters[@"curNodeCodeList"] = array;
        helper.parameters[@"refType"] = @"0";
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <SettlementAuditModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                SettlementAuditModel *model = (SettlementAuditModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
