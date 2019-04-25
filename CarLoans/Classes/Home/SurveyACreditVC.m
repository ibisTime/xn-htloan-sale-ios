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

@property (nonatomic , strong)SurveyDetailsModel *DetailsModel;

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
    secondCarReport = data;
    self.tableView.secondCarReport = secondCarReport;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发起征信";

    peopleArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    [self initTableView];
    secondCarReport = @"";
    self.tableView.secondCarReport = @"";
    if ([_state isEqualToString:@"1"]) {
        [self loadData];
    }
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
//        [peopleArray addObject:dic];
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
    CarLoansWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"632117";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    [http postWithSuccess:^(id responseObject) {
        weakSelf.DetailsModel = [SurveyDetailsModel mj_objectWithKeyValues:responseObject[@"data"]];
//        weakSelf.tableView.DetailsModel = self.DetailsModel;
        weakSelf.tableView.peopleAray = weakSelf.DetailsModel.creditUserList;
        NSLog(@"%@",self.tableView.peopleAray);
        [peopleArray addObjectsFromArray:weakSelf.DetailsModel.creditUserList];
        UITextField *textField1 = [self.view viewWithTag:300];
        textField1.text = [NSString stringWithFormat:@"%.2f",[_DetailsModel.loanAmount floatValue]/1000];
        UITextField *textField2 = [self.view viewWithTag:301];
        textField2.text = _DetailsModel.note;
        loanBankCode = _DetailsModel.loanBankCode;
        if ([_model.bizType isEqualToString:@"0"]) {
            _tableView.speciesStr = @"新车";

        }else
        {
            _tableView.speciesStr = @"二手车";
        }
        _tableView.secondCarReport = _DetailsModel.secondCarReport;
        bizType = [_model.bizType integerValue];
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632037";
        [http postWithSuccess:^(id responseObject) {
            self.bankArray = responseObject[@"data"];
            for (int i = 0; i < _bankArray.count; i ++) {
                if ([_DetailsModel.loanBank isEqualToString:_bankArray[i][@"code"]]) {
                    _tableView.bankStr = _bankArray[i][@"bankName"];
                }
            }
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {

        }];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
    
    
    
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
    [self.imagePicker picker];
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
    http.parameters[@"bizType"] = @(bizType);
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    if (![textField1.text isEqualToString:@""]) {
        http.parameters[@"loanAmount"] = @([textField1.text integerValue] * 1000);

    }
    http.parameters[@"creditUserList"] = peopleArray;
    http.parameters[@"note"] = textField2.text;
    if (bizType == 1) {
//        二手车
        http.parameters[@"secondCarReport"] = secondCarReport;
    }

    WGLog(@" =========== %@",textField2.text);

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
