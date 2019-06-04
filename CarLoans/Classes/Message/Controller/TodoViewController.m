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
        if ([node isEqualToString:@"a2"]) {
            ReferenceInputVC * vc = [ReferenceInputVC new];
            vc.surveyModel = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if ([node isEqualToString:@"a3"]) {
            CreditReviewVC * vc = [CreditReviewVC new];
            vc.surveyModel = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"a1x"]) {
            SurveyACreditVC * vc = [SurveyACreditVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b02"]) {
            FaceSignAuditVC *vc = [FaceSignAuditVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b01"] || [node isEqualToString:@"b01x"]) {
            FaceSignMQVC *vc = [[FaceSignMQVC alloc]init];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b1"]) {
            ToApplyForVC * vc = [ToApplyForVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b1x"]) {
            ToApplyForVC * vc = [ToApplyForVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if ([node isEqualToString:@"b2"]) {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:weakSelf.model.curNodeCode];
            vc.code = @"632140";
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b3"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:weakSelf.model.curNodeCode];
            vc.code = @"632121";
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b4"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:weakSelf.model.curNodeCode];
            vc.code = @"632138";
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"b8"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:weakSelf.model.curNodeCode];
            vc.code = @"632540";
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"c1"]) {
            ProductUsInputVC * vc = [ProductUsInputVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
       if ([node isEqualToString:@"c2"]){
            CheckProtextUs * vc = [CheckProtextUs new];
            vc.model = weakSelf.model;
           vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"c1x"]){
            ProductUsInputVC * vc = [ProductUsInputVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"d1"]) {
            GPSInstallationDetailsVC * vc = [GPSInstallationDetailsVC new];
            vc.code = weakSelf.model.code;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"d2"]){
            CheckInstallationVC * vc = [CheckInstallationVC new];
            vc.code = weakSelf.model.code;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"d3"]){
            GPSInstallationDetailsVC * vc = [GPSInstallationDetailsVC new];
            vc.code = weakSelf.model.code;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e1"] || [node isEqualToString:@"e1x"] || [node isEqualToString:@"e7"]|| [node isEqualToString:@"f11"]|| [node isEqualToString:@"f2"] || [node isEqualToString:@"f2x"] || [node isEqualToString:@"f5"]|| [node isEqualToString:@"f5x"]|| [node isEqualToString:@"f7"]) {
            SenderVC * vc = [SenderVC new];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e2"] || [node isEqualToString:@"e8"] || [node isEqualToString:@"f12"]|| [node isEqualToString:@"f3"] || [node isEqualToString:@"f6"] || [node isEqualToString:@"f8"]) {
            ReceivesAuditVC * vc = [ReceivesAuditVC new];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ( [node isEqualToString:@"e3"]) {
            BankLendingDetailsVC *vc = [[BankLendingDetailsVC alloc]init];
            vc.title = @"确认提交银行";
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e4"]){
            InputLendingDetailsVC * vc = [[InputLendingDetailsVC alloc]init];
            vc.title = @"录入放款信息";
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e5"]){
            ConfirmLendingVC * vc = [[ConfirmLendingVC alloc]init];
            vc.title = @"确认收款";
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ( [node isEqualToString:@"e6"])
        {
            //抵押提交银行
            InputInformationMortgageVC *vc = [[InputInformationMortgageVC alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"e9"] || [node isEqualToString:@"f13"]) {
            InputVC * vc = [[InputVC alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"f14"]) {
            CheckFileVC * vc = [[CheckFileVC alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ( [node isEqualToString:@"f1"]){
            //内勤录入抵押信息
            AgentCheckVC *vc = [[AgentCheckVC alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ( [node isEqualToString:@"f4"]){
            
            BankMortgatee *vc = [[BankMortgatee alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if ( [node isEqualToString:@"f9"]){
            
            CheckCarVC * vc = [[CheckCarVC alloc]init];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"f15"]) {
            CheckFileVC * vc = [CheckFileVC new];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"g1"]) {
            CheckFinancialVC * vc = [CheckFinancialVC new];
            vc.title = @"确认用款单";
            vc.code = @"632460";
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"g2"]){
                CheckVC1 * vc = [CheckVC1 new];
                vc.title = @"用款一审";
                vc.code = @"632461";
                vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        if ([node isEqualToString:@"g3"]){
                CheckVC2 * vc = [CheckVC2 new];
                vc.title = @"用款二审";
                vc.code = @"632462";
                vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        if ([node isEqualToString:@"g4"]){
                CheckVC1 * vc = [CheckVC1 new];
                vc.title = @"制单回录";
                vc.code = @"632463";
                vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        if ([node isEqualToString:@"g5"]){
                ReFinancialVC * vc = [ReFinancialVC new];
                vc.title = @"垫资回录";
                vc.code = @"632464";
                vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        
        if ([node isEqualToString:@"h1"]) {
            MakeCardApplyVC * vc = [MakeCardApplyVC new];
            vc.model = weakSelf.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"h2"])
        {
            MakeCardEntryVC *vc = [MakeCardEntryVC new];
            vc.model = weakSelf.model;
            vc.title = @"录入";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"i1"])
        {
            YeWuCheckVC * vc = [YeWuCheckVC new];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([node isEqualToString:@"i2"])
        {
            YeWuCheckVC * vc = [YeWuCheckVC new];
            vc.code = messagecode;
            vc.hidesBottomBarWhenPushed = YES;
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
    [self.tableView addRefreshAction:^{
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
    [self.tableView beginRefreshing];
}




@end
