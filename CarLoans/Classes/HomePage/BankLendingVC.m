//
//  BankLendingVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankLendingVC.h"
#import "BankLendingTableView.h"
#import "AccessSingleModel.h"
#import "BankLendingDetailsVC.h"
@interface BankLendingVC ()
<RefreshDelegate>
@property (nonatomic , strong)BankLendingTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@end

@implementation BankLendingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行放款";
    [self initTableView];
    [self LoadData];
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
    self.tableView = [[BankLendingTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
//    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    BankLendingDetailsVC *vc = [[BankLendingDetailsVC alloc]init];
    vc.model = self.model[index];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632148";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

    NSArray *array = @[@"002_11",@"002_13",@"002_14",@"002_15",@"002_16",@"002_17"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AccessSingleModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSMutableArray <AccessSingleModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessSingleModel *model = (AccessSingleModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        NSArray *array = @[@"002_11",@"002_13",@"002_14",@"002_15",@"002_16",@"002_17"];
        helper.parameters[@"curNodeCodeList"] = array;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <AccessSingleModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                AccessSingleModel *model = (AccessSingleModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {

                [shouldDisplayCoins addObject:model];
                //                }

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
