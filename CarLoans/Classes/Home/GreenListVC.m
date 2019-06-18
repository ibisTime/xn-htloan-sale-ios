//
//  GreenListVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GreenListVC.h"
#import "GreenListTableView.h"
@interface GreenListVC ()<RefreshDelegate>
@property (nonatomic,strong) GreenListTableView * tableView;
@end

@implementation GreenListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绿名单";
    [self initTableView];
}
-(void)initTableView{
    self.tableView = [[GreenListTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    [self loadData];
}
-(void)loadData{
    MJWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    help.code = @"630540";
    help.parameters[@"refType"] = @"0";
    help.parameters[@"curNodeCode"] = @"l4";
    help.isCurrency = YES;
    help.tableView = self.tableView;
    [help modelClass:[ListModel class]];
    help.showView = self.view;
    [self.tableView addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }];
    [self.tableView beginRefreshing];
}
@end
