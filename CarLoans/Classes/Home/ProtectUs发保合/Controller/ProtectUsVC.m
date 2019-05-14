#import "ProtectUsVC.h"
#import "ProtectUsTableView.h"
//录入发报合
#import "ProductUsInputVC.h"
//审核发报合
#import "CheckProtextUs.h"

@interface ProtectUsVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@property (nonatomic , strong)ProtectUsTableView *tableView;
@end
@implementation ProtectUsVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self LoadData];
    self.title = @"发保合";
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
    self.tableView = [[ProtectUsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdmissionDetailsVC * vc = [[AdmissionDetailsVC alloc]init];
    vc.code = self.model[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
//    if ([state isEqualToString:@"select1"] || [state isEqualToString:@"select3"]) {
//        ProductUsInputVC * vc = [ProductUsInputVC new];
//        vc.model = self.model[index];
//
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if ([state isEqualToString:@"select2"]){
//        CheckProtextUs * vc = [CheckProtextUs new];
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    NSLog(@"%ld",index);
    if ([self.model[index].fbhgpsNode isEqualToString:@"c1"]) {
        ProductUsInputVC * vc = [ProductUsInputVC new];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.model[index].fbhgpsNode isEqualToString:@"c2"]){
        CheckProtextUs * vc = [CheckProtextUs new];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([self.model[index].fbhgpsNode isEqualToString:@"c1x"]){
        ProductUsInputVC * vc = [ProductUsInputVC new];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
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

@end
