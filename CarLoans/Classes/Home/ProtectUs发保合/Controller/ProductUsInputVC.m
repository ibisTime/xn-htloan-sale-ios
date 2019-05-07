//
//  ProductUsInputVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ProductUsInputVC.h"
#import "ProductUsInputTableView.h"

@interface ProductUsInputVC ()<RefreshDelegate>
@property (nonatomic,strong) ProductUsInputTableView * tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic,strong) UIButton * button;
@property (nonatomic,strong) NSString * policyDatetime;//保单开始日期
@property (nonatomic,strong) NSString * policyDueDate;//保单到期日期
@property (nonatomic,strong) NSMutableArray * carSettleOtherPdf;//其它资料
@property (nonatomic,strong) NSMutableArray * carSyx;//商业险
@property (nonatomic,strong) NSMutableArray * carJqx;//交强险
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic,strong) NSMutableArray * carHgzPic;//合格证


@end

@implementation ProductUsInputVC
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
    if (self.selectInt == 100)
    {
        //        征信授权书
        [self.carInvoice addObject:data];
        self.tableView.carInvoice = self.carInvoice;
        
    }
    else if (self.selectInt == 101)
    {
        //        面签照片
//        [self.dataCreditReport addObject:data];
        [self.carJqx addObject: data];
        self.tableView.carJqx = self.carJqx;
        
    }
    else if (self.selectInt == 102){
        [self.carSyx addObject: data];
        self.tableView.carSyx = self.carSyx;
    }
    else if (self.selectInt == 103){
        [self.carHgzPic addObject: data];
        self.tableView.carHgzPic = self.carHgzPic;
    }
    else if (self.selectInt == 104){
        [self.carSettleOtherPdf addObject: data];
        self.tableView.carSettleOtherPdf = self.carSettleOtherPdf;
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _carInvoice = [NSMutableArray array];
    _carJqx = [NSMutableArray array];
    _carSyx = [NSMutableArray array];
    _carHgzPic = [NSMutableArray array];
    _carSettleOtherPdf = [NSMutableArray array];
    
    self.title=@"录入发报合";
    [self initTable];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 20, 50)];
    view.backgroundColor = kNavBarBackgroundColor;
    [self.view addSubview:view];
    
    self.button = [[UIButton alloc]init];
    self.button.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 20, 50);
    [self.button setTitle:@"确认" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(Confirm) forControlEvents:(UIControlEventTouchUpInside)];
    kViewRadius(self.button, 3);
    [self.view addSubview:self.button];
}

-(void)initTable{
    self.tableView = [[ProductUsInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {

        switch (index) {
                case 100:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
                break;
                case 101:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
                break;
                case 102:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
                break;
                case 103:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
                break;
                case 104:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
                break;
            default:
                break;
        }
        
    }
}
-(void)Confirm{
//    if (self.policyDatetime.length < 1) {
//        [TLAlert alertWithInfo:@"请选择保单开始日期"];
//    }
//    else if (self.policyDueDate.length < 1){
//        [TLAlert alertWithInfo:@"请选择保单到期日期"];
//    }
//    else{
    if (self.policyDatetime.length == 0) {
        [TLAlert alertWithMsg:@"请选择保单开始日期"];
        return;
    }
    else if (self.policyDueDate.length == 0){
        [TLAlert alertWithMsg:@"请选择保单到期日期"];
        return;
    }
    else if (self.carInvoice.count == 0){
        [TLAlert alertWithMsg:@"请上传发票"];
        return;
    }
    else if (self.carJqx.count == 0){
        [TLAlert alertWithMsg:@"请上传交强险"];
        return;
    }
    else if (self.carSyx.count == 0){
        [TLAlert alertWithMsg:@"请上传商业险"];
        return;
    }
    else if (self.policyDueDate.length == 0){
        [TLAlert alertWithMsg:@"请选择保单到期日期"];
        return;
    }
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632131";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"policyDatetime"] = self.policyDatetime;
        http.parameters[@"policyDueDate"] = self.policyDueDate;
        http.parameters[@"carSettleOtherPdf"] = [self convertToStringWithArray:self.carSettleOtherPdf];
        http.parameters[@"carSyx"] = [self convertToStringWithArray:self.carSyx] ;
        http.parameters[@"carJqx"] = [self convertToStringWithArray:self.carJqx];
        http.parameters[@"carInvoice"] = [self convertToStringWithArray:self.carInvoice];
        http.parameters[@"carHgzPic"] = [self convertToStringWithArray:self.carHgzPic];
        [http postWithSuccess:^(id responseObject) {
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
//    }
    
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                ChooseCell * cell = [self.view viewWithTag:1000 + indexPath.row];
                cell.details = date;
                self.policyDatetime = date;
                
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
        else if (indexPath.row == 1) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                ChooseCell * cell = [self.view viewWithTag:1000 + indexPath.row];
                cell.details = date;
                self.policyDueDate = date;
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
    }
}
-(NSString *)convertToStringWithArray:(NSMutableArray *)array{
    NSString * string =  [array componentsJoinedByString:@"||"];
    return string;
}
@end
