//
//  InputLendingDetailsVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "InputLendingDetailsVC.h"
#import "InputLendingDetailsTableView.h"
#import "TextFieldCell.h"
@interface InputLendingDetailsVC ()<RefreshDelegate>{
     NSString *date;
    NSString * date1;
}
@property (nonatomic,strong) InputLendingDetailsTableView * tableView;
@end

@implementation InputLendingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录入放款信息";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[InputLendingDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
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
        else{
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.tableView.date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                [self.tableView reloadData];
                
            }];
            datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = MainColor;//确定按钮的颜色
            [datepicker show];
        }
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    TLNetworking * http = [[TLNetworking alloc]init];
    TextFieldCell * cell = [self.view viewWithTag:100];
    TextFieldCell * cell1 = [self.view viewWithTag:101];
    TextFieldCell * cell2 = [self.view viewWithTag:102];
    TextFieldCell * cell3 = [self.view viewWithTag:103];
    TextFieldCell * cell4 = [self.view viewWithTag:104];
    TextFieldCell * cell5 = [self.view viewWithTag:105];
    TextFieldCell * cell6 = [self.view viewWithTag:106];
    NSLog(@"%@",cell.nameTextField);
    if (![cell.nameTextField.text isBankCardNo]) {
        [TLAlert alertWithMsg:@"请输入正确的银行卡号"];
        return;
    }
    if ([cell1.nameTextField.text intValue] > 31 || cell1.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的账单还款日"];
        return;
    }
    else if ([cell2.nameTextField.text intValue] > 31 || cell2.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的银行还款日"];
        return;
    }
    else if ([cell3.nameTextField.text intValue] > 31 || cell3.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的公司还款日"];
        return;
    }
    else if (cell4.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的首期月供金额"];
        return;
    }
    else if (cell4.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的每期月供金额"];
        return;
    }
    else if (date1.length == 0) {
        [TLAlert alertWithMsg:@"请选择首期还款日期"];
        return;
    }
    else if (date.length == 0) {
        [TLAlert alertWithMsg:@"请选择放款日期"];
        return;
    }
    
    http.code = @"632135";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"repayBankcardNumber"] = cell.nameTextField.text;
    http.parameters[@"repayBillDate"] = cell1.nameTextField.text;
    http.parameters[@"repayBankDate"] = cell2.nameTextField.text;
    http.parameters[@"repayCompanyDate"] = cell3.nameTextField.text;
    http.parameters[@"repayFirstMonthAmount"] = cell4.nameTextField.text;
    http.parameters[@"repayMonthAmount"] = cell5.nameTextField.text;
    http.parameters[@"repayFirstMonthDatetime"] = date1;
    http.parameters[@"bankFkDate"] = date;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
