//
//  FinancialVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "FinancialVC.h"
#import "FinancialTableView.h"
//确认用款单
#import "CheckFinancialVC.h"
//垫资一审、制单回录
#import "CheckVC1.h"
//垫资二审
#import "CheckVC2.h"
//垫资回录
#import "ReFinancialVC.h"
@interface FinancialVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@property (nonatomic,strong) FinancialTableView * tableView;
@end

@implementation FinancialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"财务垫资";
    [self initTableView];
    [self LoadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
- (void)initTableView {
    self.tableView = [[FinancialTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
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

-(void)LoadData
{
    
    CarLoansWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
    helper.showView = self.view;
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"fbhgpsNodeList"] = self.curNodeCodeList;
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
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    NSLog(@"%ld",sender.tag);
    NSLog(@"%@",self.model[index].fbhgpsNode);
    NSString * fbhgpsNode = self.model[index].fbhgpsNode;
    if ([fbhgpsNode isEqualToString:@"g1"]) {
        CheckFinancialVC * vc = [CheckFinancialVC new];
        vc.title = @"确认用款单";
        vc.code = @"632460";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
        if ([fbhgpsNode isEqualToString:@"g2"]){
        CheckVC1 * vc = [CheckVC1 new];
        vc.title = @"用款一审";
        vc.code = @"632461";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([fbhgpsNode isEqualToString:@"g3"]){
        CheckVC2 * vc = [CheckVC2 new];
        vc.title = @"用款二审";
        vc.code = @"632462";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([fbhgpsNode isEqualToString:@"g4"]){
        CheckVC1 * vc = [CheckVC1 new];
        vc.title = @"制单回录";
        vc.code = @"632463";
        vc.state = @"制单回录";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([fbhgpsNode isEqualToString:@"g5"]){
        ReFinancialVC * vc = [ReFinancialVC new];
        vc.title = @"垫资回录";
        vc.code = @"632464";
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AdmissionDetailsVC * vc = [[AdmissionDetailsVC alloc]init];
    vc.code = self.model[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
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
