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

#import "MakeCardApplyVC.h"
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
//    MessageDetailsVC *vc = [MessageDetailsVC new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    if ([self.models[indexPath.row].refNode isEqualToString:@"h1"]) {
    
        
//        [self ReturnModelByCode:self.models[indexPath.row].bizCode];
    [self ReturnModelByCode:self.models[indexPath.row].bizCode WhitNode:self.models[indexPath.row].refNode];
//    }
}


-(void)ReturnModelByCode:(NSString *)code WhitNode:(NSString *)node{
    MJWeakSelf;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code  = @"632516";
    http.parameters[@"code"] = code;
    [http postWithSuccess:^(id responseObject) {
        
        if ([node isEqualToString:@"h1"]) {
            weakSelf.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
            MakeCardApplyVC * vc = [MakeCardApplyVC new];
            vc.model = weakSelf.model;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
