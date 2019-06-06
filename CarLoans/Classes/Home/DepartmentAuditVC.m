//
//  DepartmentAuditVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DepartmentAuditVC.h"
#import "DepartmentAuditTableView.h"
@interface DepartmentAuditVC ()<RefreshDelegate>
@property (nonatomic,strong) DepartmentAuditTableView * tableView;
@end

@implementation DepartmentAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630521";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }
    else{
        http.parameters[@"code"] = self.model.code;
    }
    
    [http postWithSuccess:^(id responseObject) {
        self.model = [SettlementAuditModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
//    [self initTableView];
    // Do any additional setup after loading the view.
}
- (void)initTableView {
    self.tableView = [[DepartmentAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
//    UITextField * text = [self.view viewWithTag:100000];
    UITextField * text1 = [self.view viewWithTag:100001];
//    UITextField * text2 = [self.view viewWithTag:100002];
    UITextField * text3 = [self.view viewWithTag:100003];
    if (text1.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入扣除违约金金额"];
        return;
    }
//    if (text2.text.length == 0) {
//        [TLAlert alertWithMsg:@"请输入扣除违约金金额"];
//        return;
//    }
    if (text3.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入审核意见"];
        return;
    }
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630550";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"cutLyDeposit"] = [NSString stringWithFormat:@"%.f",[text1.text floatValue] * 1000];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"remark"] = text3.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}
@end
