//
//  IntoTheLoanVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "IntoTheLoanVC.h"
#import "IntoTheLoanTableView.h"
#import "BankContractVC.h"
@interface IntoTheLoanVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *repayBankDate;
    NSString *repayBillDate;
    NSInteger selectRow;
}
@property (nonatomic , strong)IntoTheLoanTableView *tableView;

@end

@implementation IntoTheLoanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[IntoTheLoanTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    self.tableView.repayBankDate = @"25";
    repayBankDate = @"25";
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"返回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            BankContractVC *vc = [BankContractVC new];
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2 || indexPath.row == 3) {
            selectRow = indexPath.row;
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 1; i < 31; i ++) {
                [array addObject:[NSString stringWithFormat:@"%ld",i]];
            }
            BaseModel *baseModel = [BaseModel user];
            baseModel.ModelDelegate = self;
            [baseModel CustomBouncedView:array setState:@"100"];
        }
    }
    
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if (selectRow == 2) {
        self.tableView.repayBankDate = Str;
        repayBankDate = Str;
    }else
    {
        self.tableView.repayBillDate = Str;
        repayBillDate = Str;
    }
    [self.tableView reloadData];
}

-(void)noThroughBtnClick
{
    UITextField *tf1 = [self.view viewWithTag:101];
    UITextField *tf2 = [self.view viewWithTag:104];
    UITextField *tf3 = [self.view viewWithTag:105];
    if ([tf1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入贷款编号"];
        return;
    }
    if ([BaseModel isBlankString:repayBankDate] == YES) {
        [TLAlert alertWithInfo:@"请选择银行还款日"];
        return;
    }
    if ([BaseModel isBlankString:repayBillDate] == YES) {
        [TLAlert alertWithInfo:@"请选择账单日"];
        return;
    }
    if ([tf2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入卡号"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632572";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"repayBankDate"] = repayBankDate;
    http.parameters[@"repayBillDate"] = repayBillDate;
    http.parameters[@"bankcardNumber"] = tf2.text;
    http.parameters[@"loanNumber"] = tf1.text;
    http.parameters[@"bankFkRemark"] = tf3.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"录入放款成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)throughBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
