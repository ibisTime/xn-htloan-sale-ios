#import "SurveyACreditVC.h"
#import "SurveyACreditTableView.h"
//征信人
#import "ADPeopleVC.h"
#import "SurveyDetailsModel.h"
#import "SelectedListView.h"
#import "SecondReportVC.h"
@interface SurveyACreditVC ()<RefreshDelegate,BaseModelDelegate,SelectButtonDelegate>
{

    NSInteger selectRow;

    NSInteger selectNumber;
//    银行编号
    NSString *loanBankCode;
//    业务种类
    NSInteger bizType;

    NSMutableArray *peopleArray;
    NSString * speciesStr;
    UILabel * label;
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
    UITextField * label4;
    UILabel * label5;
    
    NSString * carModel;
    NSString * modelId;
    NSString * zone;
    NSString  *Date;
    
}

@property (nonatomic , strong)NSArray *brandAry;
@property (nonatomic , strong)NSArray *carsAry;
@property (nonatomic , strong)NSArray *modelsAry;
@property (nonatomic , strong)NSDictionary *brandDic;
@property (nonatomic , strong)NSDictionary *carsDic;
@property (nonatomic , strong)NSDictionary *modelsDic;
@property (nonatomic , strong)SurveyACreditTableView *tableView;
@property (nonatomic,strong) NSString * secondCarReport;;

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
@property (nonatomic,strong) NSArray * carinfo;
@property (nonatomic,strong) NSArray * carcode;
@property (nonatomic,strong) BaseModel * basemodel;
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
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            [SVProgressHUD showWithStatus:@"上传中"];
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
    }
    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (self.selectInt == 0) {
        self.secondCarReport = data;
        self.tableView.secondCarReport = self.secondCarReport;
    }
    else if (self.selectInt == 50){
        self.idNoFront = data;
        self.tableView.xszFront = self.idNoFront;
        [SVProgressHUD dismiss];
    }
    else if (self.selectInt == 51){
        self.idNoReverse = data;
        self.tableView.xszReverse = self.idNoReverse;
        [SVProgressHUD dismiss];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.basemodel = [BaseModel new];
    self.title = @"发起征信";
    if (self.model.code.length > 0) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632516";
        http.parameters[@"code"] = self.model.code;
        [http postWithSuccess:^(id responseObject) {
            self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self initTableView];
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self initTableView];
    }
    peopleArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    
    self.secondCarReport = @"";
    self.tableView.secondCarReport = @"";
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
        [SVProgressHUD dismiss];
    });
    
    bizType = 100;
    
    
 
    NSLog(@"1");
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
    NSDictionary * idCardInfo;
    int DBR = 0;
    for (int j = 0; j < self.model.creditUserList.count; j ++) {
        NSDictionary *dataDic;
        NSDictionary *creditUser = self.model.creditUserList[j];
        if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"1"]) {
            
            idCardInfo = @{@"userName":creditUser[@"userName"],
                           @"nation":creditUser[@"nation"],
                           @"gender":creditUser[@"gender"],
                           @"customerBirth":creditUser[@"customerBirth"],
                           @"idNo":creditUser[@"idNo"],
                           @"birthAddress":creditUser[@"birthAddress"],
                           @"authref":creditUser[@"authref"],
                           @"statdate":creditUser[@"statdate"]
                           };

            
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
                         @"secondCarReport":[BaseModel convertNull:secondCarReport],
                         @"idCardInfo":idCardInfo
                         };
            [array addObject:dataDic];
        }
        if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"2"]) {
            
            idCardInfo = @{@"userName":creditUser[@"userName"],
                           @"nation":creditUser[@"nation"],
                           @"gender":creditUser[@"gender"],
                           @"customerBirth":creditUser[@"customerBirth"],
                           @"idNo":creditUser[@"idNo"],
                           @"birthAddress":creditUser[@"birthAddress"],
                           @"authref":creditUser[@"authref"],
                           @"statdate":creditUser[@"statdate"]
                           };
            
            
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
                         @"secondCarReport":[BaseModel convertNull:secondCarReport],
                         @"idCardInfo":idCardInfo
                         };
            [array addObject:dataDic];
        }
        
        if ([self.model.creditUserList[j][@"loanRole"] isEqualToString:@"3"]) {
            idCardInfo = @{@"userName":creditUser[@"userName"],
                           @"nation":creditUser[@"nation"],
                           @"gender":creditUser[@"gender"],
                           @"customerBirth":creditUser[@"customerBirth"],
                           @"idNo":creditUser[@"idNo"],
                           @"birthAddress":creditUser[@"birthAddress"],
                           @"authref":creditUser[@"authref"],
                           @"statdate":creditUser[@"statdate"]
                           };
            for (int k = 0; k < self.model.attachments.count; k ++) {
                NSDictionary *attachments = self.model.attachments[k];
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"id_no_front_gua%d",DBR]]) {
                    idNoFront = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"id_no_reverse_gua%d",DBR]]) {
                    idNoReverse = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"auth_pdf_gua%d",DBR]]) {
                    authPdf = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"interview_pic_gua%d",DBR]]) {
                    interviewPic = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"drive_license_front%d",DBR]]) {
                    xszFront = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"drive_license_reverse%d",DBR]]) {
                    xszReverse = attachments[@"url"];
                }
                if ([attachments[@"kname"] isEqualToString:[NSString stringWithFormat:@"second_car_report%d",DBR]]) {
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
                         @"idCardInfo":idCardInfo
                         };
            [array addObject:dataDic];
            DBR ++;
        }
        
        self.tableView.xszFront = array[0][@"xszFront"];
        self.tableView.xszReverse = array[0][@"xszReverse"];
        self.tableView.secondCarReport = array[0][@"secondCarReport"];
        
        
        
        self.secondCarReport = array[0][@"secondCarReport"];
        self.idNoFront = array[0][@"xszFront"];
        self.idNoReverse =  array[0][@"xszReverse"];
    }

    self.tableView.peopleAray = array;
    
    peopleArray = array;

    UITextField *textField1 = [self.view viewWithTag:300];
    if (![[NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000] isEqualToString:@"0.00"]) {
        textField1.text = [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000];
    }
    
    UITextField *textField2 = [self.view viewWithTag:301];
    textField2.text = self.model.creditNote;
    loanBankCode = self.model.loanBank;
    if ([_model.bizType isEqualToString:@"0"]) {
        _tableView.speciesStr = @"新车";
        speciesStr = @"新车";

    }else if([_model.bizType isEqualToString:@"1"])
    {
        
        _tableView.speciesStr = @"二手车";
        speciesStr = @"二手车";
    }else
    {
        _tableView.speciesStr = @"";
        speciesStr = @"";
    }
    
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
    if (self.model) {
        self.carcode = @[[BaseModel convertNull:self.model.carInfoRes[@"carBrand"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"carSeries"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"carModel"]]];
        
        self.carinfo = @[[BaseModel convertNull:self.model.carInfoRes[@"carBrandName"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"carSeriesName"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"carModelName"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"regDate"]],
                         [BaseModel convertNull:self.model.carInfoRes[@"mile"]],
                         [BaseModel convertNull:[_basemodel setid:self.model.carInfoRes[@"region"]]]
                         ];
        self.tableView.carinfo = self.carinfo;
    }
    
    NSLog(@"2");
    [self addcar];
}
-(void)addcar{
//    label = [self.view viewWithTag:3000];
//    label1 = [self.view viewWithTag:3001];
//    label2 = [self.view viewWithTag:3002];
//    label3 = [self.view viewWithTag:3003];
//    label4 = [self.view viewWithTag:3004];
//    label5 = [self.view viewWithTag:3005];
//
//
//    self.tableView.carinfo = @[self.model.carInfoRes[@"carBrandName"],
//                               self.model.carInfoRes[@"carSeriesName"],
//                               self.model.carInfoRes[@"carModelName"],
//                               @"2019-01",
//                               @"8",
//                               [[BaseModel user] setParentKey:@"region_belong" setDkey:self.model.carInfoRes[@"region"]]
//                               ];
    
//    label.text = self.model.carInfoRes[@"carBrandName"];
//    label1.text = self.model.carInfoRes[@"carSeriesName"];
//    label2.text = self.model.carInfoRes[@"carModelName"];
//
//    label5.text = [[BaseModel user] setParentKey:@"region_belong" setDkey:self.model.carInfoRes[@"region"]];
//
//    [self.tableView reloadData];
}

- (void)initTableView {
    self.tableView = [[SurveyACreditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.ButtonDelegate = self;
    _tableView.bankStr = @"";
    _tableView.speciesStr = @"";
    [self.view addSubview:self.tableView];
    
//    label = [self.view viewWithTag:3000];
//    label1 = [self.view viewWithTag:3001];
//    label2 = [self.view viewWithTag:3002];
//    label3 = [self.view viewWithTag:3003];
//    label4 = [self.view viewWithTag:3004];
//    label5 = [self.view viewWithTag:3005];

    NSLog(@"3");
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
    else if ([state isEqualToString:@"delete"]){
        if (sender.tag == 5000) {
            if (self.tableView.peopleAray.count > 0) {
//                self.tableView.peopleAray[0][@"xszFront"] = @"";
                NSMutableDictionary * dic = self.tableView.peopleAray[0];
                [dic removeObjectForKey:@"xszFront"];
                [self.tableView.peopleAray replaceObjectAtIndex:0 withObject:dic];
            }else{
                self.tableView.xszFront = nil;
            }
            [self.tableView reloadData];
        }else if (sender.tag == 5001){
            if (self.tableView.peopleAray.count > 0) {
                NSMutableDictionary * dic = self.tableView.peopleAray[0];
                [dic removeObjectForKey:@"xszReverse"];
                [self.tableView.peopleAray replaceObjectAtIndex:0 withObject:dic];
            }
            else
                self.tableView.xszReverse = nil;
            [self.tableView reloadData];
        }
        
    }
    NSLog(@"4");
}

//删除身份证图片
-(void)selectButtonClick:(UIButton *)sender
{
    if (sender.tag == 5000) {
        _idNoFront = @"";
        self.tableView.xszFront = _idNoFront;
    }
    else if (sender.tag == 5001) {
        _idNoReverse = @"";
        self.tableView.xszReverse = _idNoReverse;
    }
    else if(sender.tag == 50002){
        self.secondCarReport = @"";
        self.tableView.secondCarReport = self.secondCarReport;
    }
    else if (sender.tag >= 900000 ){
        [peopleArray removeObjectAtIndex:sender.tag - 900000];
        self.tableView.peopleAray = peopleArray;
    }
    
    [self.tableView reloadData];
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
        http.parameters[@"creditLoanAmount"] = @([textField1.text integerValue] * 1000);

    }
    http.parameters[@"creditUserList"] = peopleArray;
    http.parameters[@"creditNote"] = textField2.text;
    if (bizType == 1) {
        NSString * carBrand;
        NSString * carSeries;
        NSString * region;
        NSString * regDate;
        if (_brandDic) {
            carBrand = _brandDic[@"code"];
        }else{
            carBrand = _carcode[0];
        }
        
        if (_carsDic) {
            carSeries  = _carsDic[@"code"];
        }else{
            carSeries  = _carcode[1];
        }
        
        if (zone) {
            region = [NSString stringWithFormat:@"%@",zone];
        }else{
            region = [NSString stringWithFormat:@"%@",[_basemodel setvalue: _carinfo[5]]];
        }
        
        if (Date) {
            regDate = Date;
        }else{
            regDate = _carinfo[3];
        }
        
        if (!carModel) {
            carModel = _carcode[2];
        }
        
        NSString * mile = label4.text;
        if (!mile) {
            mile = _carinfo[4];
        }
        
        if (self.secondCarReport.length < 1) {
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
        if (carBrand.length < 1) {
            [TLAlert alertWithInfo:@"请选择品牌"];
            return;
        }
        if (carSeries.length < 1) {
            [TLAlert alertWithInfo:@"请选择车系"];
            return;
        }
        if (carModel.length < 1) {
            [TLAlert alertWithInfo:@"请选择车型"];
            return;
        }
        if (regDate.length < 1) {
            [TLAlert alertWithInfo:@"请选择日期"];
            return;
        }
        if (mile.length < 1) {
            [TLAlert alertWithInfo:@"请输入公里数"];
            return;
        }
        if (region.length < 1) {
            [TLAlert alertWithInfo:@"请选择城市"];
            return;
        }
        http.parameters[@"secondCarReport"] = self.secondCarReport;
        http.parameters[@"xszFront"] = self.idNoFront;
        http.parameters[@"xszReverse"] = self.idNoReverse;
        http.parameters[@"carBrand"] = carBrand;
        http.parameters[@"carSeries"] = carSeries;
        http.parameters[@"carModel"] = carModel;
        http.parameters[@"regDate"] = regDate;
        http.parameters[@"mile"] = mile;
        http.parameters[@"region"] = region;
        
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
//    [self addcar];
    label = [self.view viewWithTag:3000];
    label1 = [self.view viewWithTag:3001];
    label2 = [self.view viewWithTag:3002];
    label3 = [self.view viewWithTag:3003];
    label4 = [self.view viewWithTag:3004];
    label5 = [self.view viewWithTag:3005];
    
    
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
    if ([speciesStr isEqualToString:@"新车"] || [speciesStr isEqualToString:@""]) {
        if (indexPath.section == 2) {
            selectRow =  1234 + indexPath.row;
            ADPeopleVC *vc = [[ADPeopleVC alloc]init];
            vc.dataDic = self.tableView.peopleAray[indexPath.row];
            vc.selectRow = indexPath.row;
            vc.state = self.state;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                [self choosecar];
            }
            if (indexPath.row == 3) {
                {
                    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
                        
                        NSString *date = [selectDate stringWithFormat:@"yyyy-MM"];
                        Date = date;
                        label3.text = date;
                    }];
                    
                    datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
                    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                    datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
                    [datepicker show];
                    [self.tableView reloadData];
                }
            }
            if (indexPath.row == 5) {
                [self chooseaddress];
            }
        }
        if (indexPath.section == 3) {
            if (self.secondCarReport.length == 0) {
                [TLAlert alertWithInfo:@"暂无二手车评估报告"];
                return;
            }
            SecondReportVC * vc = [SecondReportVC new];
            vc.web = self.secondCarReport;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.section == 5) {
            selectRow = 1234 + indexPath.row;
            ADPeopleVC *vc = [[ADPeopleVC alloc]init];
            vc.dataDic = self.tableView.peopleAray[indexPath.row];
            vc.selectRow = indexPath.row;
            vc.state = self.state;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
-(void)chooseaddress {
    if (label.text.length == 0) {
        [TLAlert alertWithInfo:@"请选择品牌"];
        return;
    }
    if (label1.text.length == 0) {
        [TLAlert alertWithInfo:@"请选择车系"];
        return;
    }
    if (label2.text.length == 0) {
        [TLAlert alertWithInfo:@"请选择车型"];
        return;
    }
    
    if (label3.text.length == 0) {
        [TLAlert alertWithInfo:@"请选择上牌时间"];
        return;
    }
    if (label4.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入公里数"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"630477";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        
        _brandAry = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < _brandAry.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_brandAry[i][@"cityName"]]]];
        }
        
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                SelectedListModel *model = array[0];
                label5.text = model.title;
                zone = _brandAry[model.sid][@"id"];
                [self getreport];
            }];
            
        };
        [LEEAlert alert].config
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    }failure:^(NSError *error) { }];
}

-(void)choosecar{
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"630406";
    http.showView = self.view;
    http.parameters[@"status"] = @"1";
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        
        _brandAry = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < _brandAry.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_brandAry[i][@"name"]]]];
        }
        
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                SelectedListModel *model = array[0];
                label.text = model.title;
                NSLog(@"%@",label);
                _brandDic = _brandAry[model.sid];
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = NO;
                http.showView = self.view;
                http.code = @"630416";
                http.parameters[@"brandCode"] = _brandDic[@"code"];
                http.parameters[@"status"] = @"1";
                http.parameters[@"type"] = @"1";
                [http postWithSuccess:^(id responseObject) {
                    _carsAry = responseObject[@"data"];
                    
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0 ; i < _carsAry.count; i ++) {
                        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_carsAry[i][@"name"]]]];
                    }
                    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
                    view.isSingle = YES;
                    view.array = array;
                    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                        [LEEAlert closeWithCompletionBlock:^{
                            NSLog(@"选中的%@" , array);
                            SelectedListModel *model = array[0];
                            label1.text = model.title;
                            _carsDic = _carsAry[model.sid];
                            
                            _modelsAry = _carsDic[@"cars"];
                            
                            NSMutableArray *array = [NSMutableArray array];
                            for (int i = 0 ; i < _modelsAry.count; i ++) {
                                [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_modelsAry[i][@"name"]]]];
                            }
                            SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
                            view.isSingle = YES;
                            view.array = array;
                            view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                                [LEEAlert closeWithCompletionBlock:^{
                                    NSLog(@"选中的%@" , array);
                                    SelectedListModel *model = array[0];
                                    label2.text = model.title;
                                    modelId = _modelsAry[model.sid][@"modelId"];
                                    carModel =_modelsAry[model.sid][@"code"];
                                }];
                            };
                            [LEEAlert alert].config
                            .LeeTitle(@"选择")
                            .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
                            .LeeCustomView(view)
                            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                            .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
                            .LeeClickBackgroundClose(YES)
                            .LeeShow();
                            
                        }];
                    };
                    [LEEAlert alert].config
                    .LeeTitle(@"选择")
                    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
                    .LeeCustomView(view)
                    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
                    .LeeClickBackgroundClose(YES)
                    .LeeShow();
                    
                } failure:^(NSError *error) {
                    
                }];
                
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    } failure:^(NSError *error) {
        
    }];
    
    [self.tableView reloadData];
}
-(void)getreport{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630479";
    http.parameters[@"zone"] = zone;
    http.parameters[@"modelId"] = modelId;
    http.parameters[@"mile"] = label4.text;
    http.parameters[@"regDate"] = label3.text;
    [http postWithSuccess:^(id responseObject) {
        NSString * str = responseObject[@"data"][@"url"];
        self.secondCarReport = str;
        self.tableView.secondCarReport = str;
        [self.tableView reloadData];
        NSLog(@"urlqweqwe = %@",str);
    } failure:^(NSError *error) {
        
    }];
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
        speciesStr = Str;
        bizType = [dic[@"dkey"] integerValue];
        NSLog(@"%ld",bizType);
    }
    
    [self.tableView reloadData];
 
}



@end
