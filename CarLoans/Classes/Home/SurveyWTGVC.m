//
//  SurveyWTGVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyWTGVC.h"
#import "SurveyTableView.h"
#import "SurveyModel.h"
#import "SurveyDetailsVC.h"
#import "SurveyACreditVC.h"
@interface SurveyWTGVC ()<RefreshDelegate>
@property (nonatomic , strong)SurveyTableView *tableView;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;


@end

@implementation SurveyWTGVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.tableView = [[SurveyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    SurveyModel *model = _model[index];
    if ([model.curNodeCode isEqualToString:@"001_02"]) {

        TLNetworking *http = [TLNetworking new];

        http.code = @"632114";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = model.code;

        [http postWithSuccess:^(id responseObject) {

            [self LoadData];

        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];

    }else{


        SurveyACreditVC *vc = [SurveyACreditVC new];
        vc.model = _model[index];
        vc.state = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }



}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyDetailsVC *vc = [SurveyDetailsVC new];
    vc.code = _model[indexPath.row].code;
    vc.surveyModel = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632115";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    NSArray *array = @[@"a1",@"a2",@"a3",@"ax1"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.parameters[@"isPass"] = @"0";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//    helper.parameters[@"isPass"] = @"0";
//    helper.parameters[@"saleUserId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SurveyModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                SurveyModel *model = (SurveyModel *)obj;
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
        NSArray *array = @[@"001_01",@"001_02",@"001_03",@"001_04",@"001_05",@"001_06",@"001_07"];
        helper.parameters[@"curNodeCodeList"] = array;
        helper.parameters[@"isPass"] = @"0";
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                SurveyModel *model = (SurveyModel *)obj;
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
