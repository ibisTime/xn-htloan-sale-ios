//
//  DataSentItemsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DataSentItemsVC.h"
#import "SendDataTransferTableView.h"
#import "DataTransferModel.h"
#import "SenderVC.h"
#import "ReceivesAuditVC.h"
#import "CadListModel.h"
@interface DataSentItemsVC ()<RefreshDelegate>
@property (nonatomic , strong)SendDataTransferTableView *tableView;
@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;
@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;

@end

@implementation DataSentItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    if (self.isDetail == NO) {
        
        [self LoadData];

    }
    [self loadCadList];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{

    [self LoadData];

}
- (void)loadCadList
{
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632217";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        self.models = [CadListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.models = self.models;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}

- (void)initTableView {
    self.tableView = [[SendDataTransferTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    if (self.isDetail == YES) {
        self.title = @"发件详情";
        self.tableView.isDetail = YES;
        self.tableView.isRecview = YES;
        self.tableView.model = self.model;
        [self.tableView reloadData];
    }
  
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDetail == YES) {
        return;
    }
    DataSentItemsVC *vc = [DataSentItemsVC new];
    NSMutableArray <DataTransferModel *>*models = [NSMutableArray array];
    [models addObject:self.model[indexPath.row]];
    vc.title = @"资料发件";
    vc.isDetail = YES;
    vc.tableView.isDetail = YES;
    vc.tableView.isRecview = YES;

    vc.model = models;
    vc.tableView.model = models;
    [vc.tableView reloadData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    DataTransferModel *model = self.model[index];
    if ([model.status isEqualToString:@"0"] || [model.status isEqualToString:@"3"] ) {
        SenderVC *vc = [[SenderVC alloc]init];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ReceivesAuditVC *vc = [[ReceivesAuditVC alloc]init];
        vc.model = self.model[index];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)LoadData
{

    CarLoansWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632155";
//    NSArray *array = @[@"0",@"3"];
//    helper.parameters[@"statusList"] = array;
//    NSArray *array1 = @[@"0",@"3"];
    helper.parameters[@"type"] = @"1";

//    helper.parameters[@"typeList"] = array1;


//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];


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

//        NSArray *array = @[@"0",@"3"];
//        helper.parameters[@"statusList"] = array;
        helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
        NSArray *array1 = @[@"1",@"3"];
        helper.parameters[@"typeList"] = array1;

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
