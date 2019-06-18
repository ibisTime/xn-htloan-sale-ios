//
//  AccessAuditVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AccessAuditVC.h"
#import "AccessAuditTableView.h"
@interface AccessAuditVC ()<RefreshDelegate>

@property (nonatomic , strong)AccessAuditTableView *tableView;

@end

@implementation AccessAuditVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    
}


- (void)initTableView {
    self.tableView = [[AccessAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
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
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    
    UITextField *textField = [self.view viewWithTag:10000];
    
    
    NSString * approveResult;
    if (index == 1000) {
        approveResult = @"1";
    }
    else{
        approveResult = @"0";
        if ([textField.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入审核意见"];
            return;
        }
    }
    
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.showView = self.view;
    http.code = self.code;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = textField.text;
    if (index == 1000) {
        http.parameters[@"approveResult"] = @"1";
    }else
    {
        http.parameters[@"approveResult"] = @"0";
    }
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"审核成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
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
