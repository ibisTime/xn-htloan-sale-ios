//
//  GPSClaimsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsVC.h"
#import "GPSClaimsTableView.h"
#import "GPSClaimsModel.h"
#import "ClaimsVC.h"
#import "GPSClaimsDetailsVC.h"
#import "CheckInputGPS.h"
@interface GPSClaimsVC ()<RefreshDelegate>

@property (nonatomic , strong)NSMutableArray <GPSClaimsModel *>*model;

@property (nonatomic , strong)GPSClaimsTableView *tableView;

@end

@implementation GPSClaimsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigativeView];
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
    self.tableView = [[GPSClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.model[indexPath.row].status == 0) {
        CheckInputGPS *vc = [CheckInputGPS new];
        vc.model = self.model[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        GPSClaimsDetailsVC *vc = [GPSClaimsDetailsVC new];
        vc.model = self.model[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    CheckInputGPS * vc = [CheckInputGPS new];
    vc.model = self.model[index];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)navigativeView
{
    self.title = @"GPS审核";

}

-(void)rightButtonClick
{
    ClaimsVC *vc = [[ClaimsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gps_apply_statusLoadData
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"gps_apply_status";
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView.dataAry = responseObject[@"data"];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632715";
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[GPSClaimsModel class]];

    [self.tableView addRefreshAction:^{

        [weakSelf gps_apply_statusLoadData];
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <GPSClaimsModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                GPSClaimsModel *model = (GPSClaimsModel *)obj;
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

        helper.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <GPSClaimsModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                GPSClaimsModel *model = (GPSClaimsModel *)obj;
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
