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
@interface ReFinancialVC ()<RefreshDelegate>
@property (nonatomic,strong) ReFinancialTableView * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) NSString * policyDatetime;//保单开始日期
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic,strong) NSString * carInvoicestr;//发票
@end

@implementation ReFinancialVC


- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    _carInvoice = [NSMutableArray array];
    self.passBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1000;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20), 50);
    [self.passBtn addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    // Do any additional setup after loading the view.
}

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
}

-(void)initTableView{
    self.tableView = [[ReFinancialTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model= self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
-(void)confirm:(UIButton *)sender{
    InputBoxCell * cell = [self.view viewWithTag:1012];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = self.code;
    http.parameters[@"advanceFundAmount"] = [NSString stringWithFormat:@"%.f", [cell.nameTextField.text floatValue] * 1000];
    http.parameters[@"advanceFundDatetime"] = self.policyDatetime;
    http.parameters[@"billPdf"] = self.carInvoicestr;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end