//
//  BeyondListVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BeyondListVC.h"
#import "BeyondListTableView.h"
@interface BeyondListVC ()<RefreshDelegate>
@property (nonatomic,strong) BeyondListTableView * tableView;
@end

@implementation BeyondListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逾期名单";
    [self initTableView];
    // Do any additional setup after loading the view.
}
-(void)initTableView{
    self.tableView = [[BeyondListTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
    [self loadData];
}

-(void)loadData{
    MJWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    help.code = @"630540";
    help.parameters[@"refType"] = @"0";
    help.parameters[@"curNodeCode"] = @"l3";
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
