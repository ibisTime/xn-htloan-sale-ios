//
//  ReFinancialVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ReFinancialVC.h"
#import "ReFinancialTableView.h"
#import "ChooseCell.h"
#import "InputBoxCell.h"
#import "MultiBaseView.h"
@interface ReFinancialVC ()<RefreshDelegate,BaseModelDelegate>{
    NSArray *LoanProductsArray;
    NSArray * collectarray;
    NSArray *_phostsArr;
    NSMutableArray * collectCardCodeList;
}
@property (nonatomic,strong) ReFinancialTableView * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) NSString * policyDatetime;//保单开始日期
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic,strong) NSString * carInvoicestr;//发票
@property (nonatomic , strong)BaseModel *baseModel;
@property (nonatomic,strong) NSString * bancode;
@property (nonatomic,strong) NSMutableArray * bankarray;
@property (nonatomic , assign)NSInteger count;
@end

@implementation ReFinancialVC


- (void)viewDidLoad {
    [super viewDidLoad];
    collectCardCodeList = [NSMutableArray array];
//    [self initTableView];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
        NSString *idNoFront;
        NSString *idNoReverse;
        NSString *authPdf;
        NSString *interviewPic;
        NSString *xszFront;
        NSString *secondCarReport;
        NSString *xszReverse;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int j = 0; j < self.model.creditUserList.count; j ++) {
            NSDictionary *dataDic;
            NSDictionary *creditUser = self.model.creditUserList[j];
            if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"1"]) {
                
                for (int k = 0; k < self.model.attachments.count; k ++) {
                    NSDictionary *attachments = self.model.attachments[k];
                    if ([attachments[@"kname"] isEqualToString:@"id_no_front_apply"]) {
                        idNoFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"id_no_reverse_apply"]) {
                        idNoReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"auth_pdf_apply"]) {
                        authPdf = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_pic_apply"]) {
                        interviewPic = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_front"]) {
                        xszFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_reverse"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"second_car_report"]) {
                        secondCarReport = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_other_pdf"]) {
                        secondCarReport = attachments[@"url"];
                    }
                }
                
                dataDic  = @{
                             @"userName":[BaseModel convertNull:creditUser[@"userName"]],
                             @"mobile":[BaseModel convertNull:creditUser[@"mobile"]],
                             @"loanRole":[BaseModel convertNull:creditUser[@"loanRole"]],
                             @"relation":[BaseModel convertNull:creditUser[@"relation"]],
                             @"idNo":[BaseModel convertNull:creditUser[@"idNo"]],
                             @"idFront":[BaseModel convertNull:idNoFront],
                             @"idReverse":[BaseModel convertNull:idNoReverse],
                             @"authPdf":[BaseModel convertNull:authPdf],
                             @"interviewPic":[BaseModel convertNull:interviewPic],
                             @"xszFront":[BaseModel convertNull:xszFront],
                             @"xszReverse":[BaseModel convertNull:xszReverse],
                             @"secondCarReport":[BaseModel convertNull:secondCarReport],
                             @"advance_fund_amount_pdf":[BaseModel convertNull:xszReverse],
                             @"interview_other_pdf":[BaseModel convertNull:secondCarReport]
                             };
                [array addObject:dataDic];
            }
            if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"2"]) {
                
                for (int k = 0; k < self.model.attachments.count; k ++) {
                    NSDictionary *attachments = self.model.attachments[k];
                    if ([attachments[@"kname"] isEqualToString:@"id_no_front_gh"]) {
                        idNoFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"id_no_reverse_gh"]) {
                        idNoReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"auth_pdf_gh"]) {
                        authPdf = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_pic_gh"]) {
                        interviewPic = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_front"]) {
                        xszFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_reverse"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"second_car_report"]) {
                        secondCarReport = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_other_pdf"]) {
                        secondCarReport = attachments[@"url"];
                    }
                }
                
                dataDic  = @{
                             @"userName":[BaseModel convertNull:creditUser[@"userName"]],
                             @"mobile":[BaseModel convertNull:creditUser[@"mobile"]],
                             @"loanRole":[BaseModel convertNull:creditUser[@"loanRole"]],
                             @"relation":[BaseModel convertNull:creditUser[@"relation"]],
                             @"idNo":[BaseModel convertNull:creditUser[@"idNo"]],
                             @"idFront":[BaseModel convertNull:idNoFront],
                             @"idReverse":[BaseModel convertNull:idNoReverse],
                             @"authPdf":[BaseModel convertNull:authPdf],
                             @"interviewPic":[BaseModel convertNull:interviewPic],
                             @"xszFront":[BaseModel convertNull:xszFront],
                             @"xszReverse":[BaseModel convertNull:xszReverse],
                             @"secondCarReport":[BaseModel convertNull:secondCarReport],
                             @"advance_fund_amount_pdf":[BaseModel convertNull:xszReverse],
                             @"interview_other_pdf":[BaseModel convertNull:secondCarReport]
                             };
                [array addObject:dataDic];
            }
            
            if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"3"]) {
                for (int k = 0; k < self.model.attachments.count; k ++) {
                    NSDictionary *attachments = self.model.attachments[k];
                    if ([attachments[@"kname"] isEqualToString:@"id_no_front_gua"]) {
                        idNoFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"id_no_reverse_gua"]) {
                        idNoReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"auth_pdf_gua"]) {
                        authPdf = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_pic_gua"]) {
                        interviewPic = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_front"]) {
                        xszFront = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"drive_license_reverse"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"second_car_report"]) {
                        secondCarReport = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
                        xszReverse = attachments[@"url"];
                    }
                    if ([attachments[@"kname"] isEqualToString:@"interview_other_pdf"]) {
                        secondCarReport = attachments[@"url"];
                    }
                    
                }
                
                dataDic  = @{
                             @"userName":[BaseModel convertNull:creditUser[@"userName"]],
                             @"mobile":[BaseModel convertNull:creditUser[@"mobile"]],
                             @"loanRole":[BaseModel convertNull:creditUser[@"loanRole"]],
                             @"relation":[BaseModel convertNull:creditUser[@"relation"]],
                             @"idNo":[BaseModel convertNull:creditUser[@"idNo"]],
                             @"idFront":[BaseModel convertNull:idNoFront],
                             @"idReverse":[BaseModel convertNull:idNoReverse],
                             @"authPdf":[BaseModel convertNull:authPdf],
                             @"interviewPic":[BaseModel convertNull:interviewPic],
                             @"xszFront":[BaseModel convertNull:xszFront],
                             @"xszReverse":[BaseModel convertNull:xszReverse],
                             @"secondCarReport":[BaseModel convertNull:secondCarReport],
                             @"advance_fund_amount_pdf":[BaseModel convertNull:xszReverse],
                             @"interview_other_pdf":[BaseModel convertNull:secondCarReport]
                             };
                [array addObject:dataDic];
            }
        }
        self.tableView.peopleAray = array;
    } failure:^(NSError *error) {
        
    }];
    _baseModel = [BaseModel new];
    _baseModel.ModelDelegate = self;
    self.bankarray = [NSMutableArray array];
    
   
    
    _carInvoice = [NSMutableArray array];
    self.passBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1000;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20), 50);
    [self.passBtn addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    
    
    TLNetworking *http1 = [TLNetworking new];
    http1.isShowMsg = NO;
    http1.code = @"632007";
    http1.parameters[@"type"] = @"4";
    http1.parameters[@"advanceType"] = @"2";
    [http1 postWithSuccess:^(id responseObject) {
        LoanProductsArray = responseObject[@"data"];
    }failure:^(NSError *error) {
        }];
    
    
    TLNetworking *http2 = [TLNetworking new];
    http2.isShowMsg = NO;
    http2.code = @"632007";
    http2.parameters[@"type"] = @"4";
    http2.parameters[@"advanceType"] = @"1";
    [http2 postWithSuccess:^(id responseObject) {
        collectarray = responseObject[@"data"];
    }failure:^(NSError *error) {
    }];
    
    
}

- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.type = @"many";
        _imagePicker.count = 9;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
            
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
                
            } failure:^(NSError *error) {
                [TLAlert alertWithInfo:@"上传失败"];
            }];
        };
        _imagePicker.ManyPick = ^(NSMutableArray *info) {
            _phostsArr = info;
            weakSelf.count = info.count - 1;
            [weakSelf updataphoto];
        };
    }
    
    return _imagePicker;
}

-(void)updataphoto
{
    CarLoansWeakSelf;
    UIImage *image = _phostsArr[self.count][@"image"];
    NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    manager.imgData = imgData;
    manager.image = image;
    manager.isdissmiss = NO;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
        WGLog(@"%@",key);
        self.count --;
        [weakSelf setImage:image setData:key];
        if (self.count >= 0) {
            [self updataphoto];
        }
    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"上传失败"];
    }];
}
-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (self.selectInt == 100)
    {
        //        征信授权书
        [self.carInvoice addObject:data];
        self.carInvoicestr = data;
        
        self.tableView.carInvoice = self.carInvoice;
        
    }
    [self.tableView reloadData];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    if ([state isEqualToString:@"DeletePhotos1"]) {
        [self.carInvoice removeObjectAtIndex:index - 1000];
        self.tableView.carInvoice = self.carInvoice;
        [self.tableView reloadData];
    }
}

-(void)initTableView{
    self.tableView = [[ReFinancialTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model= self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 9) {
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
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self LoanProducts];
        }
        if (indexPath.row == 1) {
            [self chooseMainIncome];
        }
    }
    
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid{
    self.bancode = LoanProductsArray[sid][@"code"];
    ChooseCell * cell = [self.view viewWithTag:1050];
    NSString * str = [NSString stringWithFormat:@"%@-%@",LoanProductsArray[sid][@"bankName"],LoanProductsArray[sid][@"bankcardNumber"]];
    cell.details = str;
    NSLog(@"%@",self.bancode);
}
-(void)confirm:(UIButton *)sender{
    InputBoxCell * cell = [self.view viewWithTag:1010];
    if (cell.nameTextField.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入垫资金额"];
        return;
    }
    if (self.policyDatetime.length == 0) {
        [TLAlert alertWithMsg:@"请选择垫资日期"];
        return;
    }
    if (self.carInvoicestr.length == 0) {
        [TLAlert alertWithMsg:@"请上传水单"];
        return;
    }
    if (self.bancode.length == 0) {
        [TLAlert alertWithMsg:@"请选择垫资账号"];
        return;
    }else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = self.code;
        http.showView = self.view;
        self.carInvoicestr = [self.carInvoice componentsJoinedByString:@"||"];
        http.parameters[@"advanceFundAmount"] = [NSString stringWithFormat:@"%.f", [cell.nameTextField.text floatValue] * 1000];
        http.parameters[@"advanceFundDatetime"] = self.policyDatetime;
        http.parameters[@"billPdf"] = self.carInvoicestr;
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"advanceCardCode"] = self.bancode;
        http.parameters[@"collectCardCodeList"] = collectCardCodeList;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    
}
-(void)LoanProducts
{
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < LoanProductsArray.count; i ++) {
            NSString * str = [NSString stringWithFormat:@"%@\n%@",LoanProductsArray[i][@"bankName"],LoanProductsArray[i][@"bankcardNumber"]];
            [array addObject:str];
        }
        self.bankarray = array;
        [_baseModel CustomBouncedView:array setState:@"100"];
}
-(void)chooseMainIncome{
    NSMutableArray * valuearray = [NSMutableArray array];
    for (int i = 0; i < collectarray.count; i ++) {
        [valuearray addObject:[NSString stringWithFormat:@"%@-%@",collectarray[i][@"bankName"],collectarray[i][@"bankcardNumber"]]];
    }
    
    [MultiBaseView showMultiSheetAlertWithTitle:@"选择" conditions:valuearray resultBlock:^(NSArray *selectArr) {
        collectCardCodeList = [NSMutableArray array];
        for (NSString *str in selectArr) {
            for (int i = 0; i < valuearray.count; i ++) {
                if ([str isEqualToString:valuearray[i]]) {
                    NSArray * arr = [str componentsSeparatedByString:@"-"];
                    for (int i = 0; i < collectarray.count; i ++) {
                        if ([arr[0] isEqualToString:collectarray[i][@"bankName"]]) {
                            if ([arr[1] isEqualToString:collectarray[i][@"bankcardNumber"]]) {
                                NSLog(@"%@",collectarray[i][@"code"]);
                                [collectCardCodeList addObject:collectarray[i][@"code"]];
                            }
                        }
                    }
                }
            }
        }
        self.tableView.inarray = selectArr;
        [self.tableView reloadData];
    } cancleBlock:^{
        NSLog(@"取消");
    }];
}
@end
