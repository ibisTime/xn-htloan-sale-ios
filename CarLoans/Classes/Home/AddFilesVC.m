//
//  AddFilesVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddFilesVC.h"
#import "AddFilesTableView.h"
@interface AddFilesVC ()<RefreshDelegate>{
    NSString *date;
}
@property (nonatomic,strong) AddFilesTableView * tableView;
@end

@implementation AddFilesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增档案";
    [self initTable];
    if (self.fileModel) {
        self.tableView.content = self.fileModel.content;
        self.tableView.fileCount =self.fileModel.fileCount;
        self.tableView.remark = self.fileModel.remark;
        self.tableView.date = [self.fileModel.depositDateTime convertDateWithFormat:@"yyyy-MM-dd HH:mm"];
        date = [self.fileModel.depositDateTime convertDateWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    UIButton * btn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    btn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20), 50);
    [btn addTarget:self action:@selector(confirm) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
-(void)initTable{
    self.tableView = [[AddFilesTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
            date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.tableView.date = date;
            [self.tableView reloadData];
            
        }];
        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
        [datepicker show];
    }
}
-(void)confirm{
    UITextField * text = [self.view viewWithTag:1000];//文件内容
    UITextField * text1 = [self.view viewWithTag:1001];//文件份数
    UITextField * text2 = [self.view viewWithTag:1003];//文件备注
    
    if (text.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入文件内容"];
        return;
    }
    if (date.length == 0) {
        [TLAlert alertWithMsg:@"请输入存放时间"];
        return;
    }
    if (text1.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入文件份数"];
        return;
    }
    if (text2.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入文件备注"];
        return;
    }
    
    TLNetworking * http = [[TLNetworking alloc]init];
    if (self.fileModel) {
        http.code = @"632222";
        http.parameters[@"code"] = self.fileModel.code;
    }
    else{
        http.code = @"632220";
        http.parameters[@"bizCode"] = self.model.code;
    }
    
    http.parameters[@"content"] = text.text;
    http.parameters[@"fileCount"] = text1.text;
    http.parameters[@"depositDateTime"] = date;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"remark"] = text2.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}
@end
