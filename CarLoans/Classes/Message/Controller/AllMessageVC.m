//
//  AllMessageVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AllMessageVC.h"
#import "MessageTableView.h"
#import "MessageDetailsVC.h"
@interface AllMessageVC ()<RefreshDelegate>
@property (nonatomic , strong)MessageTableView *tableView;
@property (nonatomic , strong)NSMutableArray <TodoModel *>*models;
@end
@implementation AllMessageVC

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    MJWeakSelf;
    [self.tableView addRefreshAction:^{
        [weakSelf loadData];
    }];
    [self.tableView beginRefreshing];
}

-(void)initTableView
{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.index = 0;
    [self.view addSubview:self.tableView];
    [self loadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailsVC *vc = [MessageDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.models[indexPath.row];
    vc.index = 0;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadData{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"805305";
    helper.parameters[@"type"] = @"2";
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"notifier"] = [USERDEFAULTS objectForKey:USER_ID];
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
