//
//  MatEndowmentRecordVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MatEndowmentRecordVC.h"
#import "MatEndowmentRecordTableView.h"
@interface MatEndowmentRecordVC ()<RefreshDelegate>
{
    NSString *advanceFundDatetime;
    NSArray *billPdf;
}
@property (nonatomic , strong)MatEndowmentRecordTableView *tableView;

@end

@implementation MatEndowmentRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[MatEndowmentRecordTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        billPdf = imgAry;
    };
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    advanceFundDatetime = [formatter stringFromDate:datenow];
    self.tableView.advanceFundDatetime = advanceFundDatetime;
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"退回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
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
        if ([self.model.isPay isEqualToString:@"1"]) {
            if (indexPath.row != 4) {
                return;
            }
        }else
        {
            if (indexPath.row != 2) {
                return;
            }

        }
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            advanceFundDatetime = date;
            self.tableView.advanceFundDatetime = date;
            [self.tableView reloadData];
        }];
        datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
        [datepicker show];
    }
}

-(void)throughBtnClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退回上一节点" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
        
    } confirm:^(UIAlertAction *action) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632554";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"approveResult"] = @"0";
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:@"退回成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)noThroughBtnClick
{
    
    UITextField *textTf;
    if ([self.model.isPay isEqualToString:@"1"]) {
        textTf = [self.view viewWithTag:105];
    }else
    {
        textTf = [self.view viewWithTag:102];
    }
        
    UITextView *textView = [self.view viewWithTag:1000];
//    UITextView
    if ([BaseModel isBlankString:advanceFundDatetime] == YES) {
        [TLAlert alertWithInfo:@"请选择垫资日期"];
        return;
    }
    if ([textTf.text floatValue] != 0) {
        [TLAlert alertWithInfo:@"请输入垫资金额"];
    }
    if (billPdf.count == 0) {
        [TLAlert alertWithInfo:@"请上传水单"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632554";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"billPdf"] = billPdf[0];
    http.parameters[@"approveResult"] = @"1";
    http.parameters[@"advanceFundDatetime"] = advanceFundDatetime;
    http.parameters[@"advanceFundAmount"] = [BaseModel Cheng1000:textTf.text];
    http.parameters[@"advanceNote"] = textView.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"确认垫资回录"];
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
