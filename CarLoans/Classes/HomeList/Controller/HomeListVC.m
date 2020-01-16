//
//  HomeListVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "HomeListVC.h"
#import "HomeListTableView.h"
#import "AccessToInformationVC.h"
#import "AccessTheAuditVC.h"
#import "WithLoanVC.h"
#import "MakeAuditVC.h"
#import "MakingCircuitsVc.h"
#import "MatEndowmentRecordVC.h"
#import "TimeSubmissionVC.h"
#import "IntoTheLoanVC.h"
#import "ConfirmReceiptVC.h"
#import "MortgageVC.h"
#import "IntoFileVC.h"

@interface HomeListVC ()<RefreshDelegate>

@property (nonatomic , strong)HomeListTableView *tableView;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*models;
@end

@implementation HomeListVC

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    if ([self.title isEqualToString:@"准入资料"]) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"630167";
        http.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            
            NSArray *ary = responseObject[@"data"];
            for (int i = 0; i < ary.count; i ++) {
                if ([ary[i][@"code"] isEqualToString:@"a1"]) {
                    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                    negativeSpacer.width = -10;
                    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
                    [self.RightButton setTitle:@"新建" forState:(UIControlStateNormal)];
                    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
                }
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    CarLoansWeakSelf;
    [self.tableView addRefreshAction:^{
    
        [weakSelf loadData];
        
    }];
    [self.tableView beginRefreshing];
}


-(void)rightButtonClick
{
    AccessToInformationVC *vc = [AccessToInformationVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
    //    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//    helper.parameters[@"isMy"] = @"1";
    if ([self.curNodeCodeList[0] isEqualToString:@"e1"] || [self.curNodeCodeList[0] isEqualToString:@"e2"]) {
        helper.parameters[@"pledgeNodeCodeList"]  =self.curNodeCodeList;
        self.tableView.pledgeNodeCode = self.curNodeCodeList[0];
    }else
    {
        helper.parameters[@"curNodeCodeList"]  =self.curNodeCodeList;
    }
    
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SurveyModel class]];
    
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SurveyModel *model = (SurveyModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SurveyModel *model = (SurveyModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    
}


-(void)initTableView
{
    self.tableView = [[HomeListTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectRow == 0) {
        AccessToInformationVC *vc = [AccessToInformationVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.SerialNumber = self.models[indexPath.row].code;
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 1) {
        AccessTheAuditVC *vc = [AccessTheAuditVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 2) {
        WithLoanVC *vc = [WithLoanVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 3) {
        MakeAuditVC *vc = [MakeAuditVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 4) {
        MakingCircuitsVc *vc = [MakingCircuitsVc new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 5) {
        MatEndowmentRecordVC *vc = [MatEndowmentRecordVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    打件，银行收件，银行提交
    if (self.selectRow == 6 || self.selectRow == 7 || self.selectRow == 8 || self.selectRow == 9) {
        NSArray *leftAry = @[@"完成时间",@"完成时间",@"收件时间",@"提交时间"];
        NSArray *rightAry = @[@"请输入完成说明",@"请输入完成说明",@"请输入收件说明",@"请输入提交说明"];
        TimeSubmissionVC *vc = [TimeSubmissionVC new];
        vc.left = leftAry[_selectRow - 6];
        vc.model = self.models[indexPath.row];
        vc.right = rightAry[_selectRow - 6];
        vc.selectRow = _selectRow - 6;
        vc.title = [MenuModel new].homeArray[self.selectRow];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 10) {
        IntoTheLoanVC *vc = [IntoTheLoanVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 11) {
        ConfirmReceiptVC *vc = [ConfirmReceiptVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 12 || self.selectRow == 13) {
        MortgageVC *vc = [MortgageVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.selectRow == 14) {
        IntoFileVC *vc = [IntoFileVC new];
        vc.title = [MenuModel new].homeArray[self.selectRow];
        vc.model = self.models[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
