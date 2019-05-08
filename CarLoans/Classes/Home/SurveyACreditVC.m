#import "SurveyACreditVC.h"
#import "SurveyACreditTableView.h"
//征信人
#import "ADPeopleVC.h"
#import "SurveyDetailsModel.h"
@interface SurveyACreditVC ()<RefreshDelegate,BaseModelDelegate>
{

    NSInteger selectRow;

    NSInteger selectNumber;
//    银行编号
    NSString *loanBankCode;
//    业务种类
    NSInteger bizType;

    NSMutableArray *peopleArray;

    NSString *secondCarReport;
}

@property (nonatomic , strong)SurveyACreditTableView *tableView;

@property (nonatomic , strong)TLImagePicker *imagePicker;
//银行卡
@property (nonatomic , strong)NSArray *bankArray;
//业务种类
@property (nonatomic , strong)NSArray *speciesArray;

//@property (nonatomic , strong)SurveyDetailsModel *DetailsModel;
@property (nonatomic , assign)NSInteger selectInt;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;
@end

@implementation SurveyACreditVC



- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            [SVProgressHUD showWithStatus:@"上传中"];
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
    if (self.selectInt == 0) {
        secondCarReport = data;
        self.tableView.secondCarReport = secondCarReport;
    }
    else if (self.selectInt == 50){
        self.idNoFront = data;
        self.tableView.idNoFront = self.idNoFront;
    }
    else if (self.selectInt == 51){
        self.idNoReverse = data;
        self.tableView.idNoReverse = self.idNoReverse;
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起征信";

    peopleArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    [self initTableView];
    secondCarReport = @"";
    self.tableView.secondCarReport = @"";
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
        [SVProgressHUD dismiss];
    });
    
    bizType = 100;
//    [self ModifyTheInformation];

}


#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification
{

    NSDictionary *dic = notification.userInfo;

    if (selectRow > 1000) {
         [peopleArray replaceObjectAtIndex:selectRow - 1234 withObject:dic];
    }else
    {
        [peopleArray addObject:dic];
    }
    self.tableView.peopleAray = peopleArray;
    [self.tableView reloadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADDADPEOPLENOTICE object:nil];
}

-(void)loadData
{
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
                         @"secondCarReport":[BaseModel convertNull:secondCarReport]
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
                         @"secondCarReport":[BaseModel convertNull:secondCarReport]
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
                         @"secondCarReport":[BaseModel convertNull:secondCarReport]
                         };
            [array addObject:dataDic];
        }
    }

    self.tableView.peopleAray = array;
    peopleArray = array;
    if (self.model) {
        self.tableView.idNoReverse = self.model.xszReverse;
        self.tableView.idNoFront = self.model.xszFront;
        if (peopleArray.count != 0) {
            self.tableView.secondCarReport = peopleArray[0][@"secondCarReport"];
        }
        
        self.tableView.speciesStr = @"二手车";
    }
    
    UITextField *textField1 = [self.view viewWithTag:300];
    textField1.text = [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000];
    UITextField *textField2 = [self.view viewWithTag:301];
    textField2.text = self.model.creditNote;
    loanBankCode = self.model.loanBankCode;
    if ([_model.bizType isEqualToString:@"0"]) {
        _tableView.speciesStr = @"新车";
        
    }else
    {
        _tableView.speciesStr = @"二手车";
    }
    _tableView.secondCarReport = self.model.secondCarReport;
//    _tableView.idNoFront = self.model.car
    bizType = [_model.bizType integerValue];
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632037";
    [http postWithSuccess:^(id responseObject) {
        self.bankArray = responseObject[@"data"];
        for (int i = 0; i < _bankArray.count; i ++) {
            if ([self.model.loanBank isEqualToString:_bankArray[i][@"code"]]) {
                _tableView.bankStr = _bankArray[i][@"bankName"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    [self.tableView reloadData];
    
    
    
}

- (void)initTableView {
    self.tableView = [[SurveyACreditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    _tableView.bankStr = @"";
    _tableView.speciesStr = @"";
    
    
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"]) {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    else if ([state isEqualToString:@"IDCard"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    if (index == 100) {
//        发起
        [self ACreditLoadDatabuttonCode:@"1"];

    }else if (index == 101)
    {
//        保存
        [self ACreditLoadDatabuttonCode:@"0"];
    }else if (index == 102)
    {
//        添加征信人
        ADPeopleVC *vc = [ADPeopleVC new];
        if (peopleArray.count > 0) {
            vc.isFirstEntry = NO;
        }else
        {
            vc.isFirstEntry = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
        selectRow = 0;
    }
    else
    {
        selectRow = index;
        ADPeopleVC *vc = [[ADPeopleVC alloc]init];
        vc.dataDic = self.tableView.peopleAray[index - 1234];
        vc.selectRow = index;
        if (index == 1234) {
            vc.isFirstEntry = YES;
        }
        vc.state = self.state;
        [self.navigationController pushViewController:vc animated:YES];

    }

}

-(void)ACreditLoadDatabuttonCode:(NSString *)buttonCode
{
    UITextField *textField1 = [self.view viewWithTag:300];
    UITextField *textField2 = [self.view viewWithTag:301];
    
    if ([loanBankCode isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择银行"];
        return;
    }
    if (bizType == 100) {
        [TLAlert alertWithInfo:@"请选择业务种类"];
        return;
    }
    if (peopleArray.count == 0) {
        [TLAlert alertWithInfo:@"请添加征信人"];
        return;
    }
    if (textField1.text.length < 1) {
        [TLAlert alertWithInfo:@"请输入贷款金额"];
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    if ([_state isEqualToString:@"1"]) {

//        修改
        http.code = @"632112";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"bizCode"] = self.model.code;
    }else
    {
//        发起
        http.code = @"632110";
    }
    
    http.showView = self.view;
    http.parameters[@"buttonCode"] = buttonCode;
    http.parameters[@"loanBankCode"] = loanBankCode;
    http.parameters[@"bizType"] = [NSString stringWithFormat:@"%ld",bizType];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    if (![textField1.text isEqualToString:@""]) {
        http.parameters[@"loanAmount"] = @([textField1.text integerValue] * 1000);

    }
    http.parameters[@"creditUserList"] = peopleArray;
    http.parameters[@"creditNote"] = textField2.text;
//    if ([buttonCode isEqualToString:@"1"]) {
        if (bizType == 1) {
            //        二手车
            if (peopleArray.count > 0) {
                if (secondCarReport.length < 1) {
                    secondCarReport = peopleArray[0][@"secondCarReport"];
                    self.idNoFront = peopleArray[0][@"xszFront"];
                    self.idNoReverse = peopleArray[0][@"xszReverse"];
                }
            }
            if (secondCarReport.length < 1) {
                [TLAlert alertWithInfo:@"请上传评估报告"];
                return;
            }
            if (self.idNoFront.length < 1) {
                [TLAlert alertWithInfo:@"请上传行驶证正面照片"];
                return;
            }
            if (self.idNoReverse.length < 1) {
                [TLAlert alertWithInfo:@"请上传行驶证反面照片"];
                return;
            }
            http.parameters[@"secondCarReport"] = secondCarReport;
            http.parameters[@"xszFront"] = self.idNoFront;
            http.parameters[@"xszReverse"] = self.idNoReverse;
        }
        
//    }
    else{
        
    }
    
    [http postWithSuccess:^(id responseObject) {
        if ([buttonCode isEqualToString:@"1"]) {
            [TLAlert alertWithSucces:@"征信成功"];
        }else
        {
            [TLAlert alertWithSucces:@"保存成功"];
        }

        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        selectNumber = indexPath.row;
        if (indexPath.row == 0) {
            //银行
            if (_bankArray.count > 0) {
                [self BankLoadData];
            }else
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"632037";
                [http postWithSuccess:^(id responseObject) {
                    self.bankArray = responseObject[@"data"];
                    [self BankLoadData];
                } failure:^(NSError *error) {

                }];
            }
        }else
        {
            //业务种类
            BaseModel *model = [BaseModel new];
            [model ReturnsParentKeyAnArray:@"budget_orde_biz_typer"];
            model.ModelDelegate = self;
        }
    }
}

//银行卡弹框
-(void)BankLoadData
{
    BaseModel *model = [BaseModel new];
    model.ModelDelegate = self;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.bankArray.count; i ++) {
        [array addObject:[NSString stringWithFormat:@"%@-%@",self.bankArray[i][@"bankName"],self.bankArray[i][@"subbranch"]]];
    }
    [model CustomBouncedView:array setState:@"100"];
}


-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    WGLog(@"%@",dic);
    if (selectNumber == 0)
    {
        _tableView.bankStr = Str;
        loanBankCode = self.bankArray[sid][@"code"];
    }else
    {

        _tableView.speciesStr = Str;
        bizType = [dic[@"dkey"] integerValue];
        NSLog(@"%ld",bizType);
    }
    [self.tableView reloadData];
}



@end
