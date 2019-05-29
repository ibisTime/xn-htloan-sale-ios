//
//  DataCollectedVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DataCollectedVC.h"
#import "DataTransferTableView.h"
#import "DataTransferModel.h"
#import "SenderVC.h"
#import "ReceivesAuditVC.h"
#import "CadListModel.h"
#import "AdmissionDetailsVC.h"
#import "DataDetailsVC.h"
@interface DataCollectedVC ()<RefreshDelegate>
@property (nonatomic , strong)DataTransferTableView *tableView;

@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*models;

@end

@implementation DataCollectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    if (self.isDetail == NO) {

        [self LoadData];
        
    }
//    [self loadCadList];
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
    self.tableView = [[DataTransferTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];

    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    DataTransferModel *model = self.models[index];
    if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"2"]) {
       
        ReceivesAuditVC *vc = [[ReceivesAuditVC alloc]init];
        vc.model = self.models[index];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        SenderVC *vc = [[SenderVC alloc]init];
        vc.model = self.models[index];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    DataCollectedVC *vc = [DataCollectedVC new];
//    AdmissionDetailsVC * vc = [[AdmissionDetailsVC alloc]init];
//    vc.code = self.models[indexPath.row].bizCode;
//    [self.navigationController pushViewController:vc animated:YES];
    DataDetailsVC *vc = [DataDetailsVC new];
    vc.code = self.models[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)loadCadList
//{
//    
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"632217";
//    http.showView = self.view;
//    
//    [http postWithSuccess:^(id responseObject) {
//        self.models = [DataTransferModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.tableView.model = self.models;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
//}

-(void)LoadData
{
    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632155";
    helper.parameters[@"type"] = @"1";
    helper.parameters[@"statusList"] = @[@"1",@"2"];
//    helper.parameters[@"receiver"] =    [USERDEFAULTS objectForKey:USER_ID];
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
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{

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
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
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
