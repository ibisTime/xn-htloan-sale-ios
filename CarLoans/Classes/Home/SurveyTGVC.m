//
//  SurveyTGVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyTGVC.h"
#import "SurveyTableView.h"
#import "SurveyModel.h"
//详情
#import "SurveyDetailsVC.h"
#import "SurveyACreditVC.h"
@interface SurveyTGVC ()<RefreshDelegate,SurveyDelegate>
@property (nonatomic , strong)SurveyTableView *tableView;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;

@end

@implementation SurveyTGVC

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

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveyDetailsVC *vc = [SurveyDetailsVC new];
    vc.code = _model[indexPath.row].code;
    vc.surveyModel = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    SurveyACreditVC *vc = [SurveyACreditVC new];
    vc.model = self.model[index];
    vc.state = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632115";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    NSArray *array = @[@"001_01",@"001_02",@"001_03",@"001_04",@"001_05",@"001_06",@"001_07",@"001_08"];
    helper.parameters[@"curNodeCodeList"] = array;
    helper.parameters[@"isPass"] = @"1";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

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
        helper.parameters[@"isPass"] = @"1";
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
