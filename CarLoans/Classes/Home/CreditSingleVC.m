//
//  CreditSingleVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditSingleVC.h"
#import "CreditSingleTableView.h"
#import "AdmissionDetailsVC.h"
@interface CreditSingleVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSArray *dataArray;
    NSDictionary *dataDic;
}
@property (nonatomic , strong)CreditSingleTableView *tableView;

@end

@implementation CreditSingleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"派单";
    [self loadData];
}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630066";
    http.showView = self.view;
    http.parameters[@"roleCode"] = @"SR20180000000000000NQZY";

    [http postWithSuccess:^(id responseObject) {
        
        dataArray = responseObject[@"data"];
        
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

- (void)initTableView {
    self.tableView = [[CreditSingleTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)rightButtonClick
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i ++) {
            [array addObject:dataArray[i][@"realName"]];
        }
        BaseModel *baseModel = [BaseModel new];
        baseModel.ModelDelegate = self;
        [baseModel CustomBouncedView:array setState:@"100"];
        
    }
 
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632119";
    http.showView = self.view;
    
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"bizCode"] = self.model.code;
    http.parameters[@"insideJob"] = dataDic[@"userId"];
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"派单成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    dataDic = dataArray[sid];
    UILabel *label = [self.view viewWithTag:10000];
    label.text = Str;
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
