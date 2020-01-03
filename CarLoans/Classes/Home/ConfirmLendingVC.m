//
//  ConfirmLendingVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ConfirmLendingVC.h"
#import "ConfirmLendingTableView.h"
#import "TextFieldCell.h"
@interface ConfirmLendingVC ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectRow;
    
    NSInteger selectNumber;
    //    银行编号
    NSString *loanBankCode;
    
    NSString *loanBanlNum;
    
    NSString *secondCarReport;
    NSArray *_phostsArr;
}
@property (nonatomic,strong) ConfirmLendingTableView * tableView;
//银行卡
@property (nonatomic , strong)NSArray *bankArray;

@property (nonatomic , strong)TLImagePicker *imagePicker;

@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic,strong) NSMutableArray * picarray;
@property (nonatomic , assign)NSInteger count;
@end

@implementation ConfirmLendingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picarray = [NSMutableArray array];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.showView = self.view;
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else{
        http.parameters[@"code"] = self.model.code;
    }
    [http postWithSuccess:^(id responseObject) {
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
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
    NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
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
//    if (self.selectInt == 0) {
        [self.picarray addObject:data];
        self.tableView.bankpic = self.picarray;
//        secondCarReport = data;
//        self.tableView.secondCarReport = secondCarReport;
//    }
    
    [self.tableView reloadData];
}
- (void)initTableView {
    self.tableView = [[ConfirmLendingTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        selectNumber = indexPath.row;
        if (indexPath.row == 0) {
            //银行
            if (_bankArray.count > 0) {
                [self BankLoadData];
            }else
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"632007";
                http.parameters[@"type"] = @"1";
                [http postWithSuccess:^(id responseObject) {
                    self.bankArray = responseObject[@"data"];
                    [self BankLoadData];
                } failure:^(NSError *error) {
                    
                }];
            }
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
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"]) {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    if ([state isEqualToString:@"delete"]) {
        NSLog(@"%ld",sender.tag);
        [self.picarray removeObjectAtIndex:sender.tag - 1000];
        self.tableView.bankpic = self.picarray;
        [self.tableView reloadData];
    }
    
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    TextFieldCell * cell = [self.view viewWithTag:100];
    TextFieldCell * cell1 = [self.view viewWithTag:200];
    
    if ([loanBankCode isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择收款银行"];
        return;
    }
    if (![cell.nameTextField.text isBankCardNo]) {
        [TLAlert alertWithInfo:@"请填入正确的银行卡号"];
        return;
    }
    if ([secondCarReport isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择收款凭证"];
        return;
    }
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632130";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"receiptBankCode"] = loanBankCode;
//    http.parameters[@"receiptBankcardNumber"] = cell.nameTextField.text;
    http.parameters[@"receiptBankcardNumber"] = loanBanlNum;
    http.parameters[@"receiptPdf"] = [self.picarray componentsJoinedByString:@"||"];
    http.parameters[@"receiptRemark"] = cell1.nameTextField.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    WGLog(@"%@",dic);
    if (selectNumber == 0)
    {
        _tableView.bankStr = Str;
        _tableView.bankNo = self.bankArray[sid][@"bankcardNumber"];
        loanBankCode = self.bankArray[sid][@"code"];
        loanBanlNum = self.bankArray[sid][@"bankcardNumber"];
    }
    [self.tableView reloadData];
}


@end
