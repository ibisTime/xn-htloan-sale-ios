//
//  AccessApplyVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AccessApplyVC.h"
#import "AccessApplyTableView.h"
#import "AccessApplyApplyVC.h"
#import "ToApplyForVC.h"
#import "AccessAuditVC.h"
@interface AccessApplyVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@property (nonatomic , strong)AccessApplyTableView *tableView;
@end

@implementation AccessApplyVC

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


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.showView = self.view;
    http.code = @"632516";
    http.parameters[@"code"] = self.model[index].code;
    
    [http postWithSuccess:^(id responseObject) {
    
        if ([_model[index].curNodeCode isEqualToString:@"b1"] || [_model[index].curNodeCode isEqualToString:@"b1x"])
        {
            ToApplyForVC *vc = [ToApplyForVC new];
            vc.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b2"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632140";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b3"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632121";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b4"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632138";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b5"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632122";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b6"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632139";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([_model[index].curNodeCode isEqualToString:@"b7"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632143";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_model[index].curNodeCode isEqualToString:@"b8"])
        {
            AccessAuditVC *vc = [AccessAuditVC new];
            vc.title = [[BaseModel user]note:self.model[index].curNodeCode];
            vc.code = @"632540";
            vc.model = self.model[index];
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    } failure:^(NSError *error) {
        
    }];
    
    
//    }

}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initTableView {
    self.tableView = [[AccessApplyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)LoadData
{
    
    CarLoansWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632115";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
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
