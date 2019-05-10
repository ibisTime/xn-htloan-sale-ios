//
//  BankMortgatee.m
//  CarLoans
//
//  Created by shaojianfei on 2018/11/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankMortgatee.h"
#import "InputInformationMortgageTableView.h"
#import "WSDatePickerView.h"
#import "InsideMortgageTB.h"
#import <AVFoundation/AVFoundation.h>
#import "ChooseCell.h"
@interface BankMortgatee ()
<RefreshDelegate,SelectButtonDelegate>
{
    NSInteger isSelect;
    NSString *date;
}

@property (nonatomic , strong)InsideMortgageTB *tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , copy)NSString* roomId;
@property (nonatomic , copy) NSString *strid ;
@property (nonatomic, strong) UIAlertController *alertCtrl;

@property (nonatomic , copy) NSString *stremid ;

@property (nonatomic , copy) NSString *signPlayUrl ;


//银行视频
@property (nonatomic , strong)NSMutableArray *BankVideoArray;
//公司视频
@property (nonatomic , strong)NSMutableArray *CompanyVideoArray;
//其他视频
@property (nonatomic , strong)NSMutableArray *OtherVideoArray;

//银行视频
@property (nonatomic , strong)NSMutableArray *BankVideoDataArray;
//公司视频
@property (nonatomic , strong)NSMutableArray *CompanyVideoDataArray;
//其他视频
@property (nonatomic , strong)NSMutableArray *OtherVideoDataArray;

//银行面签照片
@property (nonatomic , strong)NSMutableArray *BankSignArray;
//银行合同照片
@property (nonatomic , strong)NSMutableArray *BankContractArray;
//公司合同照片
@property (nonatomic , strong)NSMutableArray *CompanyContractArray;
//资金划转授权书
@property (nonatomic , strong)NSMutableArray *MoneyArray;
//其他资料
@property (nonatomic , strong)NSMutableArray *otherArray;


@property (nonatomic , strong)NSMutableArray *GreenBigBenArray;

@property (nonatomic,strong) NSString * policyDatetime;//落户日期
@property (nonatomic,strong) NSString * policyDueDate;//抵押日期

//    身份证正面
@property (nonatomic , copy)NSString *AgentidNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *AgentidNoReverse;

@end

@implementation BankMortgatee
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

-(void)setVideoStr:(NSString *)video setData:(NSString *)data
{
    //    NSRange range = [video rangeOfString:@"tmp/"];
    //   video = [video substringFromIndex:range.location+4];
    if ([data containsString:@"tmp/"]) {
        [TLAlert alertWithMsg:@"请重新上传视频"];
        return;
    }
    switch (self.selectInt) {
        case 0:
        {
            if (self.BankVideoArray.count == 0) {
                self.BankVideoArray = [NSMutableArray array];
            }
            if (self.BankVideoDataArray.count == 0) {
                self.BankVideoDataArray = [NSMutableArray array];
            }
            [self.BankVideoArray addObject:data];
            [self.BankVideoDataArray addObject:data];
            self.tableView.BankVideoArray = self.BankVideoArray;
        }
            break;
        case 1:
        {
            if (self.CompanyVideoArray.count ==0) {
                self.CompanyVideoArray = [NSMutableArray array];
            }
            if (self.CompanyVideoDataArray.count ==0) {
                self.CompanyVideoDataArray = [NSMutableArray array];
            }
            [self.CompanyVideoArray addObject:data];
            [self.CompanyVideoDataArray addObject:data];
            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        }
            break;
        case 2:
        {
            if (self.OtherVideoArray.count ==0) {
                self.OtherVideoArray = [NSMutableArray array];
            }
            if (self.OtherVideoDataArray.count ==0) {
                self.OtherVideoDataArray = [NSMutableArray array];
            }
            [self.OtherVideoArray addObject:data];
            self.tableView.OtherVideoArray = self.OtherVideoArray;
            [self.OtherVideoDataArray addObject:data];
            
        }
            break;
            
        default:
            break;
            
    }
    [self.tableView reloadData];
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    
 
    switch (_selectInt) {
        case 1:
        {
            if (self.BankVideoArray.count == 0) {
                self.BankVideoArray = [NSMutableArray array];
            }
            [self.BankVideoArray addObject:data];
            self.tableView.BankVideoArray = self.BankVideoArray;
        }
            break;
        case 2:
        {
            if (self.CompanyVideoArray.count == 0) {
                self.CompanyVideoArray = [NSMutableArray array];
            }
            [self.CompanyVideoArray addObject:data];
            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        }
            break;
        case 3:
        {
            if (self.OtherVideoArray.count == 0) {
                self.OtherVideoArray = [NSMutableArray array];
            }
            [self.OtherVideoArray addObject:data];
            self.tableView.OtherVideoArray = self.OtherVideoArray;
        }
            break;
        case 4:
        {
            if (self.BankSignArray.count == 0) {
                self.BankSignArray = [NSMutableArray array];
            }
            [self.BankSignArray addObject:data];
            self.tableView.BankSignArray = self.BankSignArray;
        }
            break;
        case 5:
        {
            if (self.BankContractArray.count == 0) {
                self.BankContractArray = [NSMutableArray array];
            }
            [self.BankContractArray addObject:data];
            self.tableView.BankContractArray = self.BankContractArray;
            
        }
            break;
        case 6:
        {
            if (self.CompanyContractArray.count == 0) {
                self.CompanyContractArray = [NSMutableArray array];
            }
            [self.CompanyContractArray addObject:data];
            self.tableView.CompanyContractArray = self.CompanyContractArray;
            
        }
            break;
        case 50:{
            self.AgentidNoFront = data;
            self.tableView.idNoFront = self.AgentidNoFront;
        }
            break;
        case 51:{
            self.AgentidNoReverse = data;
            self.tableView.idNoReverse = self.AgentidNoReverse;
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录入抵押信息";
    // Do any additional setup after loading the view.
    _BankVideoArray = [NSMutableArray array];
    _CompanyVideoArray = [NSMutableArray array];
    _OtherVideoArray = [NSMutableArray array];
    _BankVideoDataArray = [NSMutableArray array];
    _CompanyVideoDataArray = [NSMutableArray array];
    _OtherVideoDataArray = [NSMutableArray array];
    _BankSignArray = [NSMutableArray array];
    _BankContractArray = [NSMutableArray array];
    _CompanyContractArray = [NSMutableArray array];
    _MoneyArray = [NSMutableArray array];
    _otherArray = [NSMutableArray array];
    
    [self initTableView];
 
}

//- (void)loadHistoryList
//{
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"632146";
//    http.parameters[@"code"] = _model.code;
//
//    http.showView = self.view;
//    //    [_interviewPicArray componentsJoinedByString:@"||"]
//    [http postWithSuccess:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        http.parameters[@"bankVideo"] = [_BankVideoDataArray componentsJoinedByString:@"||"];
//        http.parameters[@"companyVideo"] = [_CompanyVideoDataArray componentsJoinedByString:@"||"];
//
//        http.parameters[@"otherVideo"] = [_OtherVideoDataArray componentsJoinedByString:@"||"];
//        http.parameters[@"bankPhoto"] = Str1;
//        http.parameters[@"bankContract"] = Str2;
//        http.parameters[@"companyContract"] = Str3;
//        http.parameters[@"advanceFundAmountPdf"] = Str4;
//        http.parameters[@"interviewOtherPdf"] = Str5;
//        self.BankVideoDataArray = [responseObject[@"data"][@"bankVideo"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.CompanyVideoDataArray = [responseObject[@"data"][@"companyVideo"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.OtherVideoDataArray = [responseObject[@"data"][@"otherVideo"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.BankSignArray = [responseObject[@"data"][@"bankPhoto"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.BankContractArray = [responseObject[@"data"][@"bankContract"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.CompanyContractArray = [responseObject[@"data"][@"companyContract"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.MoneyArray = [responseObject[@"data"][@"advanceFundAmountPdf"] componentsSeparatedByString:@"||"].mutableCopy;
//        self.otherArray = [responseObject[@"data"][@"interviewOtherPdf"] componentsSeparatedByString:@"||"].mutableCopy;
//        NSString *str = self.BankSignArray[0];
//        if ([str isEqualToString:@""]) {
//            self.BankSignArray = [NSMutableArray array];
//        }
//        NSString *str1 = self.BankContractArray[0];
//        if ([str1 isEqualToString:@""]) {
//            self.BankContractArray = [NSMutableArray array];
//        }
//        NSString *str2 = self.CompanyContractArray[0];
//        if ([str2 isEqualToString:@""]) {
//            self.CompanyContractArray = [NSMutableArray array];
//        }
//        NSString *str3 = self.otherArray[0];
//        if ([str3 isEqualToString:@""]) {
//            self.otherArray = [NSMutableArray array];
//        }
//        NSString *str4 = self.MoneyArray[0];
//        if ([str4 isEqualToString:@""]) {
//            self.MoneyArray = [NSMutableArray array];
//        }
//
//        NSString *str5 = self.BankVideoDataArray[0];
//        if ([str5 isEqualToString:@""]) {
//            self.BankVideoDataArray = [NSMutableArray array];
//        }
//        NSString *str6 = self.CompanyVideoDataArray[0];
//        if ([str6 isEqualToString:@""]) {
//            self.CompanyVideoDataArray = [NSMutableArray array];
//        }
//        NSString *str7 = self.OtherVideoDataArray[0];
//        if ([str7 isEqualToString:@""]) {
//            self.OtherVideoDataArray = [NSMutableArray array];
//        }
//        self.BankVideoArray = self.BankVideoDataArray.mutableCopy;
//        self.CompanyVideoArray = self.CompanyVideoDataArray.mutableCopy;
//        self.OtherVideoArray = self.OtherVideoDataArray.mutableCopy;
//
//        self.tableView.BankVideoArray = self.BankVideoDataArray;
//        self.tableView.CompanyVideoArray = self.CompanyVideoDataArray;
//        self.tableView.OtherVideoArray = self.OtherVideoDataArray;
//        self.tableView.BankSignArray = self.BankSignArray;
//        self.tableView.BankContractArray = self.BankContractArray;
//        self.tableView.CompanyContractArray = self.CompanyContractArray;
//        self.tableView.MoneyArray = self.MoneyArray;
//        self.tableView.otherArray = self.otherArray;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//
//    }];
//
//}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    self.selectInt = index;
    if ([state isEqualToString:@"add"]) {
       
            [self.imagePicker picker];
     
    }else
    {
        NSLog(@"删除 %ld",index);
        if (index == 1)
        {
            [self.BankVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.BankVideoDataArray.count > 0) {
                [self.BankVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 2)
        {
            [self.CompanyVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.CompanyVideoDataArray.count > 0) {
                [self.CompanyVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 3)
        {
            
            [self.OtherVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.OtherVideoDataArray.count > 0) {
                [self.OtherVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 4)
        {
            
            if (self.BankSignArray.count > 0) {
                [self.BankSignArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 5)
        {
            
            if (self.BankContractArray.count > 0) {
                [self.BankContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 6)
        {
            
            if (self.CompanyContractArray.count > 0) {
                [self.CompanyContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        if ([state isEqualToString:@"IDCard"]) {
            self.selectInt = index;
            [self.imagePicker picker];
        }
       
        
        self.tableView.BankVideoArray = self.BankVideoArray;
        self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        self.tableView.OtherVideoArray = self.OtherVideoArray;
        self.tableView.BankSignArray = self.BankSignArray;
        self.tableView.BankContractArray = self.BankContractArray;
        self.tableView.CompanyContractArray = self.CompanyContractArray;
        self.tableView.otherArray = self.otherArray;
        [self.tableView reloadData];
    }
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (sender.tag == 10001) {
        return;
    }else{
        [self confirmButtonClick];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632123";
    http.showView = self.view;
    //    [_interviewPicArray componentsJoinedByString:@"||"]
    http.parameters[@"code"] = _model.code;
    // http.parameters[@"code"] = _model.code; 车牌号

    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"bankVideo"] = [_BankVideoDataArray componentsJoinedByString:@"||"];
    http.parameters[@"companyVideo"] = [_CompanyVideoDataArray componentsJoinedByString:@"||"];
    if (sender.tag == 10001) {
        http.parameters[@"isSend"] = @"0";
        
    }else{
        http.parameters[@"isSend"] = @"1";
        
    }
    
    http.parameters[@"otherVideo"] = [_OtherVideoDataArray componentsJoinedByString:@"||"];
    http.parameters[@"bankPhoto"] = [self.BankSignArray componentsJoinedByString:@"||"];
    http.parameters[@"bankContract"] = [self.BankContractArray componentsJoinedByString:@"||"];;
    http.parameters[@"companyContract"] = [self.CompanyContractArray componentsJoinedByString:@"||"];;
    http.parameters[@"advanceFundAmountPdf"] = [self.MoneyArray componentsJoinedByString:@"||"];;
    http.parameters[@"interviewOtherPdf"] = [self.otherArray componentsJoinedByString:@"||"];;
    
    [http postWithSuccess:^(id responseObject) {
        if (sender.tag == 10001) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        }else{
            [TLAlert alertWithSucces:@"面签成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


- (void)initTableView {
    self.tableView = [[InsideMortgageTB alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}


#pragma mark - Accessor
- (UIAlertController *)alertCtrl {
    if (!_alertCtrl) {
        _alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;
        [_alertCtrl addAction:action];
    }
    return _alertCtrl;
}



-(void)confirmButtonClick
{
    
    UITextField *textField1 = [self.view viewWithTag:106];
    UITextField *textField2 = [self.view viewWithTag:107];
    UITextField *textField3 = [self.view viewWithTag:108];

   
    if (self.BankVideoArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传绿大本扫描件图片"];
        return;
    }
    if (self.CompanyVideoArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传车钥匙图片"];
        return;
    }
    if (self.OtherVideoArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传车辆批单图片"];

        return;
    }
    if (self.BankSignArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传登记证书"];

        return;
    }
    if (self.BankContractArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传车辆行驶证扫描件"];

        return;
    }
    if (self.CompanyContractArray.count == 0) {
          [TLAlert alertWithInfo:@"请上传完税证明扫描件"];
        return;
    }
    
   
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入抵押地点"];
        return;
    }
    
    //
    NSString *GreenBigBen = [_GreenBigBenArray componentsJoinedByString:@"||"];
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632133";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"carBigSmj"] = [self.BankVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carKey"] = [self.CompanyVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carNumber"] = textField2.text;
    http.parameters[@"carPd"] = [self.OtherVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carRegcerti"] = [self.BankSignArray componentsJoinedByString:@"||"];
    http.parameters[@"carXszSmj"] = [self.BankContractArray componentsJoinedByString:@"||"];
    http.parameters[@"dutyPaidProveSmj"] = [self.CompanyContractArray componentsJoinedByString:@"||"];


    
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"内勤录入成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
    
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
        if (indexPath.row == 3) {
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
}
-(void)selectButtonClick:(UIButton *)sender{
    if (sender.tag == 5000) {
        _AgentidNoFront = @"";
        self.tableView.idNoFront = _AgentidNoFront;
    }else
    {
        _AgentidNoReverse = @"";
        self.tableView.idNoReverse = _AgentidNoReverse;
    }
    [self.tableView reloadData];
}

@end
