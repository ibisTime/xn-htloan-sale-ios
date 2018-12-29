//
//  ClaimsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ClaimsVC.h"
#import "ClaimsTableView.h"
#import "AccessSingleVC.h"
@interface ClaimsVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) AccessSingleModel *model;

@end

@implementation ClaimsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申领";
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ApplyForCancellation object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    
    self.tableView.model = notification.userInfo[@"userInfo"];
    self.model = self.tableView.model;
    self.tableView.isList = YES;
    [self.tableView reloadData];
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row == 0) {
        AccessSingleVC *vc = [[AccessSingleVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    NSLog(@"%ld",index);
    UITextField *textFid1 = [self.view viewWithTag:101];
    UITextField *textFid2 = [self.view viewWithTag:102];
    UITextField *textFid3 = [self.view viewWithTag:103];

    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入申领个数"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632710";
    http.showView = self.view;
    http.parameters[@"applyWiredCount"] = textFid1.text;
    http.parameters[@"applyWirelessCount"] = textFid2.text;
    http.parameters[@"customerName"] =self.model.applyUserName;

    if (self.model) {
        http.parameters[@"applyUsername"] = self.model.applyUserName;

    }
    http.parameters[@"budgetOrderCode"] = self.model.code;


    http.parameters[@"applyReason"] = textFid3.text;
    http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"申领成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
