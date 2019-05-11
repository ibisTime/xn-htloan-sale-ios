//
//  CheckCarVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckCarVC.h"
#import "CheckCarTableView.h"
#import "ChooseCell.h"
@interface CheckCarVC ()<RefreshDelegate>
@property (nonatomic,strong) CheckCarTableView * tableView;
@property (nonatomic,strong) NSString * checktime;
@end

@implementation CheckCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认提交";
    [self inittable];
    // Do any additional setup after loading the view.
}
-(void)inittable{
    self.tableView = [[CheckCarTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    UITextField * text = [self.view viewWithTag:1001];
    if (text.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入提交说明"];
        return;
    }
    if (self.checktime.length == 0) {
        [TLAlert alertWithInfo:@"请选择提交时间"];
        return;
    }
    if ([state isEqualToString:@"confirm"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632132";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"pledgeBankCommitDatetime"] = self.checktime;
        http.parameters[@"pledgeBankCommitNot"] = [BaseModel convertNull:text.text];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithInfo:@"确认成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
        
    }
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                ChooseCell * cell = [self.view viewWithTag:1000 + indexPath.row];
                cell.details = date;
                self.checktime = date;
                
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
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
