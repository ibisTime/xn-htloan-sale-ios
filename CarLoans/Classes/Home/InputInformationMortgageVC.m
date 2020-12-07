//
//  InputInformationMortgageVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InputInformationMortgageVC.h"
#import "InputInformationMortgageTableView.h"
#import "WSDatePickerView.h"
@interface InputInformationMortgageVC ()
<RefreshDelegate,SelectButtonDelegate>
{
    NSInteger isSelect;
    NSString *date;
}


@property (nonatomic , assign)NSInteger selectInt;

@property (nonatomic , strong)NSMutableArray *GreenBigBenArray;

@property (nonatomic , strong)TLImagePicker *imagePicker;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

@property (nonatomic , strong)InputInformationMortgageTableView *tableView;

@property (nonatomic,strong) IdCardFrontModel * idcardfrontmodel;
@property (nonatomic,strong) IdCradReverseModel * idcardreversemodel;
@end

@implementation InputInformationMortgageVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        
        _imagePicker.pickFinish = ^(NSDictionary *info){

            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
            [SVProgressHUD showWithStatus:@"上传中"];
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];

            manager.imgData = imgData;
            manager.image = image;
            manager.isdissmiss = YES;
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
    if (self.selectInt == 1) {
        [self.GreenBigBenArray addObject:data];
        self.tableView.GreenBigBenArray = self.GreenBigBenArray;
        [SVProgressHUD dismiss];
    }
    
    
    if (self.selectInt == 50)
    {
        self.idNoFront = data;
        [self getDataFromPicWithUrl:data WithCode:@"630092"];
    }else if (self.selectInt == 51)
    {
        self.idNoReverse = data;
        [self getDataFromPicWithUrl:data WithCode:@"630093"];
    }
    [self.tableView reloadData];
}

-(void)selectButtonClick:(UIButton *)sender{
    if (sender.tag == 5000) {
        
        
        _idNoFront = @"";
        self.tableView.idNoFront = _idNoFront;
        self.idcardfrontmodel = nil;
        self.tableView.idcardfrontmodel = self.idcardfrontmodel;
    }else
    {
        _idNoReverse = @"";
        self.tableView.idNoReverse = _idNoReverse;
        self.idcardreversemodel = nil;
        self.tableView.idcardreversemodel = self.idcardreversemodel;
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
    // Do any additional setup after loading the view.
    self.title = @"抵押提交银行";
    date = @"";
    _GreenBigBenArray = [NSMutableArray array];
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
        [self initTableView];
        for (int i = 0; i < self.model.attachments.count; i ++) {
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_front"]) {
                self.idNoFront = self.model.attachments[i][@"url"];
                self.tableView.idNoFront = self.model.attachments[i][@"url"];
            }
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_reverse"]) {
                self.idNoReverse = self.model.attachments[i][@"url"];
                self.tableView.idNoReverse = self.model.attachments[i][@"url"];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)initTableView {
    self.tableView = [[InputInformationMortgageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.AgentDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

//
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }else if([state isEqualToString:@"DeletePhotos1"])
    {
        [_GreenBigBenArray removeObjectAtIndex:index - 1000];
        //        [_invoiceArray removeObjectAtIndex:index - 1000];
        _tableView.GreenBigBenArray = _GreenBigBenArray;

        [self.tableView reloadData];
    }
    else if([state isEqualToString:@"confirm"])
    {
        [self confirmButtonClick];
    }
    if ([state isEqualToString:@"IDCard"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
        [self.tableView reloadData];
    }
}

-(void)confirmButtonClick
{
    UITextField *textField2 = [self.view viewWithTag:1000];
    UITextField * t = [self.view viewWithTag:20000];
    UITextField * t1 = [self.view viewWithTag:20001];
    UITextField * t2 = [self.view viewWithTag:20002];
    if (t.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人姓名"];
        return;
    }
    if (t1.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人身份证号码"];
        return;
    }
    if (t2.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入抵押地点"];
        return;
    }
    if (self.idNoFront.length == 0) {
        [TLAlert alertWithInfo:@"请选择代理人身份证正面"];
        return;
    }
    if (self.idNoReverse.length == 0) {
        [TLAlert alertWithInfo:@"请选择代理人身份证反面"];
        return;
    }
    
    if (textField2.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入车辆抵押补充说明"];
        return;
    }else{
        TLNetworking *http = [TLNetworking new];
        http.code = @"632144";
        http.showView = self.view;
        http.parameters[@"code"] = _model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"supplementNote"] = textField2.text;
        http.parameters[@"pledgeUserIdCardFront"] = self.idNoFront;
        http.parameters[@"pledgeUserIdCardReverse"] = self.idNoReverse;
        http.parameters[@"pledgeUser"] = t.text;
        http.parameters[@"pledgeUserIdCard"] = t1.text;
        http.parameters[@"pledgeAddress"] = t2.text;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"提交成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }

   

}

//-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1) {
//        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
//            date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
//            self.tableView.date = date;
//            [self.tableView reloadData];
//
//        }];
//        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
//        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
//        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
//        [datepicker show];
//    }
//}

@end
