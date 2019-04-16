//
//  GPSCollectedVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSCollectedVC.h"
#import "DataTransferTableView.h"
#import "DataTransferModel.h"
#import "SenderVC.h"
#import "ReceivesAuditVC.h"
@interface GPSCollectedVC ()<RefreshDelegate>
@property (nonatomic , strong)DataTransferTableView *tableView;
@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;

@end

@implementation GPSCollectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    if (self.isDetail == NO) {
        [self LoadData];
    }
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
    self.tableView = [[DataTransferTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.isGps = YES;
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    if (self.isDetail == YES) {
        self.tableView.isDetail = self.isDetail;
        self.tableView.model = self.model;
        self.title = @"GPS收件详情";

        [self.tableView reloadData];
    }
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDetail == YES) {
        return;
    }
    GPSCollectedVC *vc = [GPSCollectedVC new];
    NSMutableArray <DataTransferModel *>*models = [NSMutableArray array];
    [models addObject:self.model[indexPath.row]];
    vc.isDetail = YES;
    vc.tableView.isDetail = YES;

    vc.model = models;
    vc.tableView.model = models;
    [vc.tableView reloadData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    DataTransferModel *model = self.model[index];
    if ([model.status isEqualToString:@"0"] || [model.status isEqualToString:@"3"]) {
        return;
        SenderVC *vc = [[SenderVC alloc]init];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ReceivesAuditVC *vc = [[ReceivesAuditVC alloc]init];
        vc.isGps = YES;
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632155";
    helper.parameters[@"receiver"] = [USERDEFAULTS objectForKey:USER_ID];;
    NSArray *array = @[@"1",@"2"];
    helper.parameters[@"statusList"] = array;
    helper.parameters[@"type"] = @"2";

//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[DataTransferModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <DataTransferModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                DataTransferModel *model = (DataTransferModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.isGps = YES;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{

        helper.parameters[@"receiver"] = [USERDEFAULTS objectForKey:USER_ID];;
        NSArray *array = @[@"1",@"2",@"3"];
        helper.parameters[@"statusList"] = array;
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <DataTransferModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                DataTransferModel *model = (DataTransferModel *)obj;
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
