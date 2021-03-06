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
    NSArray *_phostsArr;
}

@property (nonatomic , strong)InsideMortgageTB *tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , copy)NSString* roomId;
@property (nonatomic , copy) NSString *strid ;
@property (nonatomic, strong) UIAlertController *alertCtrl;

@property (nonatomic , copy) NSString *stremid ;

@property (nonatomic , copy) NSString *signPlayUrl ;

@property (nonatomic , assign)NSInteger count;
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

@property (nonatomic,strong) IdCardFrontModel * idcardfrontmodel;
@property (nonatomic,strong) IdCradReverseModel * idcardreversemodel;

@end

@implementation BankMortgatee
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.type = @"many";
        _imagePicker.count = 9;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);

            @autoreleasepool {
                UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
                NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
//                [SVProgressHUD showWithStatus:@"上传中"];
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                //进行上传
                TLUploadManager *manager = [TLUploadManager manager];
                manager.isdissmiss = NO;
                manager.imgData = imgData;
                manager.image = image;
                [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                    WGLog(@"%@",key);
                    [weakSelf setImage:image setData:key];
                    
                } failure:^(NSError *error) {
                    [TLAlert alertWithInfo:@"上传失败"];
                }];
            }
            
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
        case 3:
        {
            if (self.BankVideoArray.count == 0) {
                self.BankVideoArray = [NSMutableArray array];
            }
            [self.BankVideoArray addObject:data];
            self.tableView.BankVideoArray = self.BankVideoArray;
        }
            break;
        case 4:
        {
            if (self.CompanyVideoArray.count == 0) {
                self.CompanyVideoArray = [NSMutableArray array];
            }
            [self.CompanyVideoArray addObject:data];
            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        }
            break;
        case 5:
        {
            if (self.OtherVideoArray.count == 0) {
                self.OtherVideoArray = [NSMutableArray array];
            }
            [self.OtherVideoArray addObject:data];
            self.tableView.OtherVideoArray = self.OtherVideoArray;
        }
            break;
        case 6:
        {
            if (self.BankSignArray.count == 0) {
                self.BankSignArray = [NSMutableArray array];
            }
            [self.BankSignArray addObject:data];
            self.tableView.BankSignArray = self.BankSignArray;
        }
            break;
        case 7:
        {
            if (self.BankContractArray.count == 0) {
                self.BankContractArray = [NSMutableArray array];
            }
            [self.BankContractArray addObject:data];
            self.tableView.BankContractArray = self.BankContractArray;
            
        }
            break;
        case 8:
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
            [self getDataFromPicWithUrl:data WithCode:@"630092"];
        }
            break;
        case 51:{
            self.AgentidNoReverse = data;
            [self getDataFromPicWithUrl:data WithCode:@"630093"];
        }
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}

-(void)getDataFromPicWithUrl:(NSString *)picurl WithCode :(NSString *)code{
    [SVProgressHUD show];
    NSString * url = [picurl convertImageUrl];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = code;
    http.parameters[@"picUrl"] = url;
    [http postWithSuccess:^(id responseObject) {
        if ([code isEqualToString:@"630092"]) {
            self.idcardfrontmodel = [IdCardFrontModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.tableView.idNoFront = picurl;
            self.tableView.idcardfrontmodel = self.idcardfrontmodel;
        }
        else if ([code isEqualToString:@"630093"]) {
            self.idcardreversemodel = [IdCradReverseModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.tableView.idNoReverse = picurl;
            self.tableView.idcardreversemodel = self.idcardreversemodel;
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录入抵押信息";
    @autoreleasepool {
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
    }
    
    
    [self initTableView];
    [self loaddetails];
 
}
-(void)loaddetails{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else
        http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",[AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]]);
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView.model = self.model;
        for (int i = 0; i < self.model.attachments.count; i ++) {
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_front"]) {
                self.AgentidNoFront = self.model.attachments[i][@"url"];
                self.tableView.idNoFront = self.model.attachments[i][@"url"];
            }
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_reverse"]) {
                self.AgentidNoReverse = self.model.attachments[i][@"url"];
                self.tableView.idNoReverse = self.model.attachments[i][@"url"];
            }
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"green_big_smj"]) {
                
                [self.BankVideoArray addObjectsFromArray:[self.model.attachments[i][@"url"] componentsSeparatedByString:@"||"]];
                self.tableView.BankVideoArray = self.BankVideoArray;
            }
        }
        [self.view addSubview:self.tableView];
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    self.selectInt = index;
    if ([state isEqualToString:@"add"]) {
       
            [self.imagePicker picker];
     
    }else
    {
        NSLog(@"删除 %ld",index);
        NSLog(@"删除了 %ld",sender.tag);
        if (index == 3)
        {
            [self.BankVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.BankVideoDataArray.count > 0) {
                [self.BankVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 4)
        {
            [self.CompanyVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.CompanyVideoDataArray.count > 0) {
                [self.CompanyVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 5)
        {
            
            [self.OtherVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.OtherVideoDataArray.count > 0) {
                [self.OtherVideoDataArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 6)
        {
            
            if (self.BankSignArray.count > 0) {
                [self.BankSignArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 7)
        {
            
            if (self.BankContractArray.count > 0) {
                [self.BankContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 8)
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

}


- (void)initTableView {
    self.tableView = [[InsideMortgageTB alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.AgentDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
//    [self.view addSubview:self.tableView];
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
    
    UITextField *textField1 = [self.view viewWithTag:10001];//落户地点
    UITextField *textField2 = [self.view viewWithTag:10002];//车牌号
    UITextField *textField3 = [self.view viewWithTag:10004];//抵押地点
    UITextField *textField4 = [self.view viewWithTag:10005];//代理人
    UITextField *textField5 = [self.view viewWithTag:10006];//代理身份证号
    
    if (self.policyDatetime.length == 0) {
        [TLAlert alertWithInfo:@"请输入落户日期"];
        return;
    }
    
    if (textField1.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入落户地点"];
        return;
    }
    if (textField2.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入车牌号"];
        return;
    }
    if (self.policyDueDate.length == 0) {
        [TLAlert alertWithInfo:@"请输入抵押日期"];
        return;
    }
    if (textField3.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入抵押地点"];
        return;
    }
    if (textField4.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人姓名"];
        return;
    }
    if (textField5.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人身份证号"];
        return;
    }
    if (self.AgentidNoFront.length == 0) {
        [TLAlert alertWithInfo:@"请上传代理人身份证正面"];
        return;
    }
    if (self.AgentidNoReverse.length == 0) {
        [TLAlert alertWithInfo:@"请上传代理人身份证反面"];
        return;
    }
   
    if (self.BankVideoArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传绿大本"];
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
        [TLAlert alertWithInfo:@"请上传车辆行驶证"];

        return;
    }
    if (self.CompanyContractArray.count == 0) {
          [TLAlert alertWithInfo:@"请上传完税证明"];
        return;
    }
    
   
    
    
    //
//    NSString *GreenBigBen = [_GreenBigBenArray componentsJoinedByString:@"||"];
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632133";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"carNumber"] = [BaseModel convertNull:textField2.text];
    http.parameters[@"carRegcerti"] = [self.BankSignArray componentsJoinedByString:@"||"];
    http.parameters[@"carPd"] = [self.OtherVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carKey"] = [self.CompanyVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carBigSmj"] = [self.BankVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"carXszSmj"] = [self.BankContractArray componentsJoinedByString:@"||"];
    http.parameters[@"dutyPaidProveSmj"] = [self.CompanyContractArray componentsJoinedByString:@"||"];
    http.parameters[@"pledgeDatetime"] = self.policyDueDate;
    http.parameters[@"carSettleDatetime"] = self.policyDatetime;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"settleAddress"] = [BaseModel convertNull:textField1.text];
    http.parameters[@"pledgeAddress"] = [BaseModel convertNull:textField3.text];
    http.parameters[@"pledgeUser"] = [BaseModel convertNull:textField4.text];
    http.parameters[@"pledgeUserIdCard"] = [BaseModel convertNull:textField5.text];
    http.parameters[@"pledgeUserIdCardFront"] = self.AgentidNoFront;
    http.parameters[@"pledgeUserIdCardReverse"] = self.AgentidNoReverse;

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
                ChooseCell * cell = [self.view viewWithTag:10000 + indexPath.row];
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
                ChooseCell * cell = [self.view viewWithTag:10000 + indexPath.row];
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
-(void)selectButtonClick:(UIButton *)sender{
    NSLog(@"点击%ld",sender.tag);
    if (sender.tag == 5000) {
        _AgentidNoFront = @"";
        self.tableView.idNoFront = _AgentidNoFront;
        _idcardfrontmodel = nil;
        self.tableView.idcardfrontmodel = _idcardfrontmodel;
    }else
    {
        _AgentidNoReverse = @"";
        self.tableView.idNoReverse = _AgentidNoReverse;
        _idcardreversemodel = nil;
        self.tableView.idcardreversemodel = _idcardreversemodel;
    }
    [self.tableView reloadData];
}

@end
