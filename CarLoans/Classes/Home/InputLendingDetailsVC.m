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
@interface InputLendingDetailsVC ()<RefreshDelegate,BaseModelDelegate>{
     NSString *date;
    NSString * date1;
    NSString * day1;
    NSString * day2;
    NSString * day3;
    NSInteger selectRow;
}
@property (nonatomic,strong) InputLendingDetailsTableView * tableView;
@property (nonatomic,strong) NSMutableArray * array;
@property (nonatomic,strong) BaseModel * baseModel;
@end

@implementation InputLendingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录入放款信息";
    NSArray * array1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    self.array = [NSMutableArray arrayWithArray:array1];
    self.baseModel = [BaseModel new];
    self.baseModel.ModelDelegate = self;
//    [self initTableView];
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
}

- (void)initTableView {
    self.tableView = [[InputLendingDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            selectRow = 1000 + indexPath.row;
            [self.baseModel CustomBouncedView:[NSMutableArray arrayWithArray:self.array] setState:@"100"];
        }
        if (indexPath.row == 2) {
            selectRow = 1000 + indexPath.row;
            [self.baseModel CustomBouncedView:[NSMutableArray arrayWithArray:self.array] setState:@"100"];
        }
        if (indexPath.row == 3) {
            selectRow = 1000 + indexPath.row;
            [self.baseModel CustomBouncedView:[NSMutableArray arrayWithArray:self.array] setState:@"100"];
        }
    }
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
//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    NSLog(@"%@",Str);
    if (selectRow == 1001) {
        self.tableView.day1 = Str;
        day1 = Str;
        [self.tableView reloadData];
    }
    if (selectRow == 1002) {
        self.tableView.day2 = Str;
        day2 = Str;
        [self.tableView reloadData];
    }
    if (selectRow == 1003) {
        self.tableView.day3 = Str;
        day3 = Str;
        [self.tableView reloadData];
    }
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    TLNetworking * http = [[TLNetworking alloc]init];
    TextFieldCell * cell = [self.view viewWithTag:100];
//    TextFieldCell * cell1 = [self.view viewWithTag:101];
//    TextFieldCell * cell2 = [self.view viewWithTag:102];
//    TextFieldCell * cell3 = [self.view viewWithTag:103];
    TextFieldCell * cell4 = [self.view viewWithTag:104];
    TextFieldCell * cell5 = [self.view viewWithTag:105];
//    TextFieldCell * cell6 = [self.view viewWithTag:106];
    NSLog(@"%@",cell.nameTextField);
    if (![cell.nameTextField.text isBankCardNo]) {
        [TLAlert alertWithMsg:@"请输入正确的银行卡号"];
        return;
    }
    if (day1.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的账单还款日"];
        return;
    }
    else if (day2.length == 0) {
        [TLAlert alertWithMsg:@"请输入正确的银行还款日"];
        return;
    }
    else if (day3.length == 0) {
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
    http.parameters[@"repayBillDate"] = day1;
    http.parameters[@"repayBankDate"] = day2;
    http.parameters[@"repayCompanyDate"] = day3;
    http.parameters[@"repayFirstMonthAmount"] = [NSString stringWithFormat:@"%.f", [cell4.nameTextField.text floatValue]*1000];
    http.parameters[@"repayMonthAmount"] = [NSString stringWithFormat:@"%.f", [cell5.nameTextField.text floatValue]*1000];
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
