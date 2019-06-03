//
//  CancelVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CancelVC.h"
#import "CancelTableView.h"
@interface CancelVC ()<RefreshDelegate>{
    NSString * date;
}
@property (nonatomic,strong) CancelTableView * tableView;
@end

@implementation CancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    UIButton * button = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:MainColor titleFont:18 cornerRadius:3];
    [button addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 65, SCREEN_WIDTH - 30, 50);
    [self.view addSubview:button];
}
- (void)initTableView {
    self.tableView = [[CancelTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 80) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)selectTime
{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        self.tableView.date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"%@",self.tableView.date);
        [self.tableView reloadData];
        
    }];
    datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = MainColor;//确定按钮的颜色
    [datepicker show];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        [self selectTime];
    }
}
-(void)click{
    if (date.length == 0) {
        [TLAlert alertWithMsg:@"请选择解除日期"];
        return;
    }
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630554";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] =[USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"releaseDatetime"] = date;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
