//
//  SettlementAuditDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SettlementAuditDetailsVC.h"
#import "SettlementAuditDetailsTableView.h"
#import "WSDatePickerView.h"
@interface SettlementAuditDetailsVC ()<RefreshDelegate>

@property (nonatomic , strong)SettlementAuditDetailsTableView *tableView;

@property (nonatomic , strong)TLImagePicker *imagePicker;

//@property (nonatomic , strong)NSMutableArray *proveArray;

@property (nonatomic , strong)NSMutableArray *proveDataArray;

@property (nonatomic , copy)NSString *date;

@end

@implementation SettlementAuditDetailsVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){

            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);

            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];

            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                //                [SVProgressHUD dismiss];
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];

            } failure:^(NSError *error) {

            }];
        };
    }

    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    [self.proveDataArray addObject:data];
//    [self.proveArray addObject:image];
    self.tableView.proveArray = self.proveDataArray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.proveArray = [NSMutableArray array];
    self.proveDataArray = [NSMutableArray array];
    [self initTableView];
    self.title = @"审核";
    _date = @"";

}
- (void)initTableView {
    self.tableView = [[SettlementAuditDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"]) {
        [self.imagePicker picker];
    }else
    {
//        [self.proveArray removeObjectAtIndex:index - 1000];
        [self.proveDataArray removeObjectAtIndex:index - 1000];
        _tableView.proveArray = self.proveDataArray;
        [self.tableView reloadData];
    }

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:1000];
    if ([_date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择时间"];
        return;
    }
    if (_proveDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传结清证明"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"630551";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    if (![textFid1.text isEqualToString:@""]) {
        http.parameters[@"remark"] = textFid1.text;
    }
    if (index == 100) {
        http.parameters[@"approveResult"] = @"1";
    }else
    {
        http.parameters[@"approveResult"] = @"0";
    }
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"settleDatetime"] = _date;
    NSString *settlePdf = [_proveDataArray componentsJoinedByString:@"||"];
    http.parameters[@"settlePdf"] = settlePdf;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提交成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
            _date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.tableView.date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            [self.tableView reloadData];

        }];
        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
        [datepicker show];
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