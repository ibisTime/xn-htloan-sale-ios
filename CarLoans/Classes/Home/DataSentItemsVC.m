//
//  DataSentItemsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DataSentItemsVC.h"
#import "DataTransferTableView.h"
#import "DataTransferModel.h"
#import "SenderVC.h"
#import "ReceivesAuditVC.h"
#import "CadListModel.h"
#import "DataDetailsVC.h"
@interface DataSentItemsVC ()<RefreshDelegate>
@property (nonatomic , strong)DataTransferTableView *tableView;
@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;
//@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;

@end

@implementation DataSentItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    [self LoadData];
//    [self loadCadList];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{

    [self LoadData];

}
//- (void)loadCadList
//{
//
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"632217";
//    http.showView = self.view;
//
//    [http postWithSuccess:^(id responseObject) {
//        self.models = [CadListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.tableView.models = self.models;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//
//    }];
//}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}

- (void)initTableView {
    self.tableView = [[DataTransferTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];

  [self.tableView reloadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DataDetailsVC *vc = [DataDetailsVC new];
    vc.code = self.model[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SenderVC *vc = [SenderVC new];
    vc.model = self.model[index];
    NSString *state;
    if ([self.model[index].status isEqualToString:@"0"]) {
        state = @"待发件";
 
    }else if ([self.model[index].status isEqualToString:@"1"])
    {
        state = @"已发件待收件";
       
    }else if ([self.model[index].status isEqualToString:@"2"])
    {
        state = @"已收件审核";
   
        
    }else
    {
        state = @"已收件待补件";
        
    }
    vc.title = state;

    [self.navigationController pushViewController:vc animated:YES];

}

-(void)LoadData
{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632155";
    helper.parameters[@"type"] = @"1";
    helper.parameters[@"statusList"] = @[@"0",@"3"];
//    helper.parameters[@"receiver"] = [USERDEFAULTS objectForKey:USER_ID];;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[DataTransferModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
          
            //
            weakSelf.model = objs;
            weakSelf.tableView.model = objs;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{


        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);

            //
            weakSelf.model = objs;
            weakSelf.tableView.model = objs;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
