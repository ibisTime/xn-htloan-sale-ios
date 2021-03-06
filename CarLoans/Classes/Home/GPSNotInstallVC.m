//
//  GPSNotInstallVC.m
//  CarLoans
//
//  Created by shaojianfei on 2018/9/29.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSNotInstallVC.h"
#import "GPSInstallationModel.h"
#import "GPSInstallationTableView.h"
//录入
#import "GPSInstallationDetailsVC.h"
#import "InstallationDetailsVC.h"
@interface GPSNotInstallVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <GPSInstallationModel *>*model;
@property (nonatomic , strong)GPSInstallationTableView *tableView;

@end

@implementation GPSNotInstallVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"GPS安装";
    [self initTableView];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self LoadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}

- (void)initTableView {
    self.tableView = [[GPSInstallationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    
    //    GPSInstallationDetailsVC *vc = [[GPSInstallationDetailsVC alloc]init];
    //    vc.model = self.model[index];
    //    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    GPSInstallationDetailsVC *vc = [[GPSInstallationDetailsVC alloc]init];
    vc.model = self.model[index];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstallationDetailsVC *vc = [[InstallationDetailsVC alloc]init];
    vc.model = self.model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

    NSArray *array = @[@"002_09",@"002_10",@"002_12",@"002_32"];
    helper.parameters[@"advanfCurNodeCodeList"] = array;
    
    helper.parameters[@"isGpsAz"] = @"0";
        
    
 
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[GPSInstallationModel class]];
    
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            
            NSMutableArray <GPSInstallationModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GPSInstallationModel *model = (GPSInstallationModel *)obj;
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
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        
        NSArray *array = @[@"002_09",@"002_10",@"002_12",@"002_32"];
        helper.parameters[@"advanfCurNodeCodeList"] = array;
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <GPSInstallationModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GPSInstallationModel *model = (GPSInstallationModel *)obj;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
