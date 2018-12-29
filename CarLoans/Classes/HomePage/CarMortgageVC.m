//
//  CarMortgageVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarMortgageVC.h"
#import "AccessSingleTableView.h"
#import "AccessSingleModel.h"
#import "InputInformationMortgageVC.h"
#import "insideMortgatee.h"
#import "BankMortgatee.h"
#import "InsideSureVC.h"
@interface CarMortgageVC ()<RefreshDelegate>
@property (nonatomic , strong)AccessSingleTableView *tableView;

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;

@property (nonatomic , assign)BOOL  isSucess;

@end

@implementation CarMortgageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"车辆抵押";
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
    self.tableView = [[AccessSingleTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    self.tableView.refreshDelegate = self;
    self.tableView.isCar = YES;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    InputInformationMortgageVC *vc = [[InputInformationMortgageVC alloc]init];
//    vc.model = self.model[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    AccessSingleModel *model = self.model[index];
//    if ([model.curNodeCode isEqualToString:@"002_18"]) {
//        InputInformationMortgageVC *vc = [[InputInformationMortgageVC alloc]init];
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if ( [model.curNodeCode isEqualToString:@"002_20"])
//    {
//        BankMortgatee *vc = [[BankMortgatee alloc]init];
////        insideMortgatee *vc = [[insideMortgatee alloc]init];
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else if ( [model.curNodeCode isEqualToString:@"002_21"]){
////        InsideSureVC *vc = [[InsideSureVC alloc] init];
//
//        insideMortgatee *vc = [[insideMortgatee alloc]init];
//
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if ( [model.curNodeCode isEqualToString:@"002_33"]){
//        //        InsideSureVC *vc = [[InsideSureVC alloc] init];
//
//        insideMortgatee *vc = [[insideMortgatee alloc]init];
//
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if ( [model.curNodeCode isEqualToString:@"002_34"]){
//        //        InsideSureVC *vc = [[InsideSureVC alloc] init];
//
//        insideMortgatee *vc = [[insideMortgatee alloc]init];
//
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else{
        InputInformationMortgageVC *vc = [[InputInformationMortgageVC alloc]init];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
        
//    }
  
}

-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632148";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    NSArray *array = @[@"002_18",@"002_19",@"002_20",@"002_21"];
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
        helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        NSArray *array = @[@"002_18",@"002_19",@"002_20",@"002_21"];

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
