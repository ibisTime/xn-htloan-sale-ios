//
//  TimeSubmissionVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TimeSubmissionVC.h"
#import "TimeSubmissionTableView.h"
@interface TimeSubmissionVC ()<RefreshDelegate>
{
    NSString *Datetime;
}
@property (nonatomic , strong)TimeSubmissionTableView *tableView;

@end

@implementation TimeSubmissionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[TimeSubmissionTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.left = _left;
    self.tableView.right = _right;
    self.tableView.model = self.model;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    Datetime = [formatter stringFromDate:datenow];
    self.tableView.Datetime = Datetime;
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
- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
                Datetime = date;
                self.tableView.Datetime = date;
                [self.tableView reloadData];
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
    }
}

-(void)throughBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)noThroughBtnClick
{
    UITextView *textView = [self.view viewWithTag:1000];
    //    UITextView
    if ([BaseModel isBlankString:Datetime] == YES) {
        [TLAlert alertWithInfo:@"请选择时间"];
        return;
    }
    if ([textView.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入说明"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    if (self.selectRow == 0)  {
        http.code = @"632560";
        http.parameters[@"rationaleDatetime"] = Datetime;
        http.parameters[@"rationaleNote"] = textView.text;
    }
    if (self.selectRow == 1)  {
        http.code = @"632561";
        http.parameters[@"hitPieceDatetime"] = Datetime;
        http.parameters[@"hitPieceNote"] = textView.text;
    }
    if (self.selectRow == 2)  {
        http.code = @"632570";
        http.parameters[@"bankFkDate"] = Datetime;
        http.parameters[@"bankFkNote"] = textView.text;
    }
    if (self.selectRow == 3)  {
        http.code = @"632571";
        http.parameters[@"bankCommitDatetime"] = Datetime;
        http.parameters[@"bankCommitNote"] = textView.text;
    }
    
    
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.model.code;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        if (self.selectRow == 0) {
            [TLAlert alertWithSucces:@"理件成功"];
        }
        if (self.selectRow == 1) {
            [TLAlert alertWithSucces:@"打件成功"];
        }
        if (self.selectRow == 2) {
            [TLAlert alertWithSucces:@"银行收件成功"];
        }
        if (self.selectRow == 3) {
            [TLAlert alertWithSucces:@"银行提交成功"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
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
