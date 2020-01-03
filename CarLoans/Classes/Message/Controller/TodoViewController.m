//
//  TodoViewController.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TodoViewController.h"
#import "MessageTableView.h"
#import "MessageDetailsVC.h"
#import "TodoModel.h"
//发起x征信
#import "SurveyACreditVC.h"
//录入征信信息
#import "ReferenceInputVC.h"
//征信审核
#import "CreditReviewVC.h"
//准入申请
#import "ToApplyForVC.h"
//准入审核
#import "AccessAuditVC.h"
//录入发报合
#import "ProductUsInputVC.h"
//审核发报合
#import "CheckProtextUs.h"
//安装GPS
#import "GPSInstallationDetailsVC.h"
//审核GPS
#import "CheckInstallationVC.h"
//发件
#import "SenderVC.h"
//收件
#import "ReceivesAuditVC.h"
//
#import "BankLendingDetailsVC.h"
//
#import "InputLendingDetailsVC.h"
//
#import "ConfirmLendingVC.h"
//申请车辆抵押
#import "InputInformationMortgageVC.h"
//内勤确认
#import "AgentCheckVC.h"
//
#import "BankMortgatee.h"
//
#import "CheckCarVC.h"
//
#import "InputVC.h"
//
#import "CheckFileVC.h"
//
#import "FinancialTableView.h"
//确认用款单
#import "CheckFinancialVC.h"
//垫资一审、制单回录
#import "CheckVC1.h"
//垫资二审
#import "CheckVC2.h"
//垫资回录
#import "ReFinancialVC.h"
//录入卡号
#import "MakeCardEntryVC.h"
//
#import "YeWuCheckVC.h"
//
#import "FaceSignAuditVC.h"
//
#import "FaceSignMQVC.h"

#import "MakeCardApplyVC.h"

//
#import "CheckFileVC.h"

#import "DepartmentAuditVC.h"
#import "SettlementAuditDetailsVC.h"
#import "ManagerAuditVC.h"
#import "CancelVC.h"


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


@interface TodoViewController ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;

@property (nonatomic , strong)NSMutableArray <TodoModel *>*models;
@property (nonatomic , strong)SurveyModel *model;
@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
    
    MJWeakSelf;
    [self.tableView addRefreshAction:^{
        if (self.bizTasks.count == 0) {
            [weakSelf loadData];
        }
    }];
    [self.tableView beginRefreshing];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.bizTasks.count == 0) {
        [self loadData];
    }
}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self loadData];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}
-(void)initTableView
{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50- kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    if (self.bizTasks.count > 0) {
        self.title = @"代办事项";
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight );
        self.tableView.models = [TodoModel mj_objectArrayWithKeyValuesArray:self.bizTasks];
    }
    
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self ReturnModelByCode:self.models[indexPath.row].bizCode WhitNode:self.models[indexPath.row].refNode messagecode:self.models[indexPath.row].refOrder];
}


-(void)ReturnModelByCode:(NSString *)code WhitNode:(NSString *)node messagecode:(NSString *)messagecode{
    MJWeakSelf;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code  = @"632516";
    http.parameters[@"code"] = code;
    [http postWithSuccess:^(id responseObject) {
        weakSelf.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSInteger selectRow = 0;
        

        if ([node isEqualToString:@"a1"] || [node isEqualToString:@"a1x"]) {
            selectRow = 0;
            AccessToInformationVC *vc = [AccessToInformationVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.SerialNumber = self.model.code;
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"a2"]) {
            selectRow = 1;
            AccessTheAuditVC *vc = [AccessTheAuditVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b1"]) {
            selectRow = 2;
            WithLoanVC *vc = [WithLoanVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b3"]) {
            selectRow = 3;
            MakeAuditVC *vc = [MakeAuditVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b4"]) {
            selectRow = 4;
            MakingCircuitsVc *vc = [MakingCircuitsVc new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b5"]) {
            selectRow = 5;
            MatEndowmentRecordVC *vc = [MatEndowmentRecordVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //    打件，银行收件，银行提交
        if ([node isEqualToString:@"c1"] || [node isEqualToString:@"c2"] || [node isEqualToString:@"d1"] || [node isEqualToString:@"d2"]) {
            
            NSArray *leftAry = @[@"完成时间",@"完成时间",@"收件时间",@"提交时间"];
            NSArray *rightAry = @[@"请输入完成说明",@"请输入完成说明",@"请输入收件说明",@"请输入提交说明"];
            if ([node isEqualToString:@"c1"]) {
                selectRow = 0;
            }
            if ([node isEqualToString:@"c2"]) {
                selectRow = 1;
            }
            if ([node isEqualToString:@"d1"]) {
                selectRow = 2;
            }
            if ([node isEqualToString:@"d2"]) {
                selectRow = 3;
            }
            
            TimeSubmissionVC *vc = [TimeSubmissionVC new];
            vc.left = leftAry[selectRow];
            vc.model = self.model;
            vc.right = rightAry[selectRow];
            vc.selectRow = selectRow;
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = [MenuModel new].homeArray[selectRow + 6];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"d3"]) {
            selectRow = 10;
            IntoTheLoanVC *vc = [IntoTheLoanVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"d4"]) {
            selectRow = 11;
            ConfirmReceiptVC *vc = [ConfirmReceiptVC new];
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e1"] || [node isEqualToString:@"e2"]) {
            if ([node isEqualToString:@"e1"]) {
                selectRow = 12;
            }else
            {
                selectRow = 13;
            }
            MortgageVC *vc = [MortgageVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"f1"]) {
            selectRow = 14;
            IntoFileVC *vc = [IntoFileVC new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = [MenuModel new].homeArray[selectRow];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {

    }];
}

-(void)loadData{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632525";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"status"] = @"0";
//    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[TodoModel class]];
    
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <TodoModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TodoModel *model = (TodoModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    
    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        helper.parameters[@"status"] = @"0";
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <TodoModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TodoModel *model = (TodoModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
        }];
    }];
    
}




@end
