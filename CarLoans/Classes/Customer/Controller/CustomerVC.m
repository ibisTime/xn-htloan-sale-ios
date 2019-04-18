//
//  CustomerVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerVC.h"
#import "CustomerTableView.h"
#import "CustomerDetailsVC.h"
#import "CustomerModel.h"
@interface CustomerVC ()<RefreshDelegate>
@property (nonatomic , strong)CustomerTableView *tableView;
@property (nonatomic , strong)NSMutableArray <CustomerModel *>*models;



@end


@implementation CustomerVC



- (void)viewDidLoad {
    self.title = @"客户";
    [self initTableView];
    [self initNavigationController];
    [self loadData];
    
}

-(void)cdbiz_statusLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"cdbiz_status";
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView.dataArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)initTableView
{
    self.tableView = [[CustomerTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerDetailsVC *vc = [CustomerDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.models[indexPath.row];
    vc.dataArray = self.tableView.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
//    helper.parameters[@"ywyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[CustomerModel class]];
    [self.tableView addRefreshAction:^{
        [weakSelf cdbiz_statusLoadData];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <CustomerModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CustomerModel *model = (CustomerModel *)obj;
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
            NSMutableArray <CustomerModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CustomerModel *model = (CustomerModel *)obj;
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
