//
//  BankLendingDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankLendingDetailsVC.h"
#import "WSDatePickerView.h"
#import "BankLendingDetailsTableView.h"
@interface BankLendingDetailsVC ()<RefreshDelegate>
{
    NSString *date;
}
@property (nonatomic , strong)BankLendingDetailsTableView *tableView;

@end

@implementation BankLendingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.t
    self.title = @"确认银行提交";
    date = @"";
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.showView = self.view;
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else{
        http.parameters[@"code"] = self.model.code;
    }
    [http postWithSuccess:^(id responseObject) {
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
//    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[BankLendingDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            self.tableView.date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            [self.tableView reloadData];

        }];
        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
        [datepicker show];
    }
}



-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    if ([date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择时间"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632129";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    if (![textFid1.text isEqualToString:@""]) {
        http.parameters[@"bankCommitNote"] = textFid1.text;
    }
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"bankCommitDatetime"] = date;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提交成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
