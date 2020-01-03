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

#import "ReferenceInputVC.h"
#import "CreditReviewVC.h"

#import "CreditSingleVC.h"
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
    if ([self.title isEqualToString:@"征信发起"]) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
        [self.RightButton setTitle:@"发起征信" forState:(UIControlStateNormal)];
        [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

-(void)rightButtonClick
{
    SurveyACreditVC *vc = [SurveyACreditVC new];
    vc.state = @"101";
    [self.navigationController pushViewController:vc animated:YES];
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
    self.tableView = [[SurveyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.title = self.title;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    if ([self.title isEqualToString:@"征信派单"]) {
        CreditSingleVC *vc = [CreditSingleVC new];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        if ([_model[index].curNodeCode isEqualToString:@"a1"] || [_model[index].curNodeCode isEqualToString:@"a1x"])
        {
            SurveyACreditVC *vc = [SurveyACreditVC new];
            vc.model = self.model[index];
            vc.state = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_model[index].curNodeCode isEqualToString:@"a2"])
        {
            ReferenceInputVC *vc = [ReferenceInputVC new];
            vc.code = _model[index].code;
            vc.surveyModel = _model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_model[index].curNodeCode isEqualToString:@"a3"])
        {
            CreditReviewVC *vc = [CreditReviewVC new];
            vc.code = _model[index].code;
            vc.surveyModel = _model[index];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"curNodeCodeList"] = self.curNodeCodeList;
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
