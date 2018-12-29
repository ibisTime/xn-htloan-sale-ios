//
//  CarSettledInVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarSettledInVC.h"
#import "CarSettledInTableView.h"
#import "AccessSingleModel.h"
#import "CarSettledInDetailsVC.h"
#import "VehiclesInDetailsVC.h"
#import "BankMortgatee.h"
@interface CarSettledInVC ()<RefreshDelegate>

@property (nonatomic , strong)CarSettledInTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AccessSingleModel*>*model;

@end

@implementation CarSettledInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发保合";
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
    self.tableView = [[CarSettledInTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccessSingleModel *model = self.model[indexPath.row];
    VehiclesInDetailsVC *vc = [[VehiclesInDetailsVC alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
//    if ([model.advanfCurNodeCode isEqualToString:@"002_18"]) {
//        CarSettledInDetailsVC *vc = [[CarSettledInDetailsVC alloc]init];
//
////        BankMortgatee *vc = [[BankMortgatee alloc]init];
//        vc.model = model;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//    {
//        VehiclesInDetailsVC *vc = [[VehiclesInDetailsVC alloc]init];
//        vc.model = model;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    AccessSingleModel *model = self.model[index];
    CarSettledInDetailsVC *vc = [[CarSettledInDetailsVC alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632148";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    NSArray *curNodeCodeList = @[@"002_18"];
    helper.parameters[@"advanfCurNodeCodeList"] = curNodeCodeList;
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"isEntryMortgage"] = [NSString stringWithFormat:@"%d",self.isEntryMortgage];


    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[AccessSingleModel class]];
    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

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

        helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        NSArray *curNodeCodeList = @[@"002_18"];
        helper.parameters[@"advanfCurNodeCodeList"] = curNodeCodeList;
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
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
