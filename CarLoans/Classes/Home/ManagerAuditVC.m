//
//  ManagerAuditVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ManagerAuditVC.h"
#import "ManagerAuditTableView.h"
@interface ManagerAuditVC ()<RefreshDelegate>
@property (nonatomic,strong) ManagerAuditTableView * tableView;
@end

@implementation ManagerAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630521";
    http.showView = self.view;
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
    self.tableView = [[ManagerAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    UITextField * text3 = [self.view viewWithTag:100003];
    if (text3.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入审核意见"];
        return;
    }
    TLNetworking * http = [[TLNetworking alloc]init];
    if ([self.model.curNodeCode isEqualToString:@"j4"]) {
        http.code = @"630552";
    }
    if ([self.model.curNodeCode isEqualToString:@"j5"]) {
        http.code = @"630553";
    }
    
    if (index == 100) {
        http.parameters[@"approveResult"] = @"1";
    }else{
        http.parameters[@"approveResult"] = @"0";
    }
    http.parameters[@"code"] = self.model.code;
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
