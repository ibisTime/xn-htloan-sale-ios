//
//  CheckInstallationVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckInstallationVC.h"
#import "CheckInstallationTableView.h"
#import "CheckGPSVC.h"
#import "TextFieldCell.h"
@interface CheckInstallationVC ()<RefreshDelegate>
@property (nonatomic,strong) CheckInstallationTableView * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) UIButton * UnpassBtn;
@end

@implementation CheckInstallationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS审核";
    self.view.backgroundColor = kWhiteColor;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    
    self.passBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1001;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH  / 2 - 20, 50);
    [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    self.UnpassBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.UnpassBtn.tag = 1000;
    self.UnpassBtn.frame = CGRectMake((SCREEN_WIDTH - 20) / 2 + 10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20) / 2 - 20, 50);
    [self.UnpassBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.UnpassBtn];
    
    [http postWithSuccess:^(id responseObject) {
        self.model = [GPSInstallationModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(void)Confirm:(UIButton *)sender{
    TLNetworking * http = [TLNetworking new];
    TextFieldCell * cell = [self.view viewWithTag:100001];
    NSString * approveResult;
    if (sender.tag == 1001) {
        approveResult = @"1";
    }
    else
        approveResult = @"0";
    http.code = @"632127";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"approveResult"] = approveResult;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = cell.nameTextField.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (void)initTableView {
    self.tableView = [[CheckInstallationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.peopleAray = self.model.budgetOrderGps;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CheckGPSVC * vc = [CheckGPSVC new];
        vc.model = self.model;
        vc.peopleAray = self.model.budgetOrderGps[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
