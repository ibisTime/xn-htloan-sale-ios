//
//  ReferenceInputDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ReferenceInputDetailsVC.h"
#import "ReferenceInputDetailsTableView.h"
#import "BankResultVC.h"
#import "TongDunVC.h"
@interface ReferenceInputDetailsVC ()<RefreshDelegate,BaseModelDelegate,SelectButtonDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSString *secondCarReport;
    NSArray *_phostsArr;
}
@property (nonatomic , strong)ReferenceInputDetailsTableView *tableView;
//@property (nonatomic , strong)SurveyDetailsModel *surveyDetailsModel;

@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;

@property (nonatomic , copy)NSString *bankResult;
@property (nonatomic , assign)NSInteger count;
@end

@implementation ReferenceInputDetailsVC


- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            
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

-(void)addButClick
{
    
    UIImagePickerController *pickCtrl = [[UIImagePickerController alloc] init];
    pickCtrl.delegate = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        pickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickCtrl animated:YES completion:nil];
        
    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        pickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
        //选择图片的最大数
        WphotoVC.selectPhotoOfMax = 9;
        [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
            _phostsArr = phostsArr;
            self.count = phostsArr.count - 1;
            [self updataphoto];
        }];
        [self presentViewController:WphotoVC animated:YES completion:nil];
        
    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    [self presentViewController:alertController animated:YES completion:nil];
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    CarLoansWeakSelf;
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
    
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    
    manager.imgData = imgData;
    manager.image = image;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
        WGLog(@"%@",key);
        [weakSelf setImage:image setData:key];
        [picker dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"上传失败"];
    }];
}
-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (self.selectInt == 100)
    {
        //        征信授权书
        [self.bankCreditReport addObject:data];
        self.tableView.bankCreditReport = self.bankCreditReport;
        self.tableView.secondCarReport = data;
        
    }
    else if (self.selectInt == 101)
    {
        //        面签照片
        [self.dataCreditReport addObject:data];
        self.tableView.dataCreditReport = self.dataCreditReport;
        
    }
    if (self.selectInt == 0) {
        secondCarReport = data;
        [self.bankCreditReport addObject:data];
        self.tableView.secondCarReport = secondCarReport;
         self.tableView.bankCreditReport = self.bankCreditReport;
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"录入征信结果";
    [self initTableView];
    //    [self loadData];
    _bankCreditReport = [NSMutableArray array];
    _dataCreditReport = [NSMutableArray array];

    if ([BaseModel isBlankDictionary:self.creditListDic] == NO) {
        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self TheAssignment];
            [SVProgressHUD dismiss];
        });
        
    }
}

-(void)TheAssignment
{
    
    
    if ([self.creditListDic[@"bankResult"] isEqualToString:@"1"])
    {
        _bankResult = @"通过";
    }
    else if([self.creditListDic[@"bankResult"] isEqualToString:@"0"])
    {
        _bankResult = @"不通过";
    }
    else{
        _bankResult = @"";
    }
    self.tableView.bankResult = _bankResult;
    self.tableView.creditNote = self.creditListDic[@"creditNote"];
    self.bankCreditReport = [NSMutableArray arrayWithArray:[self.creditListDic[@"bankCreditReport"] componentsSeparatedByString:@"||"]];
//    self.tableView.bankCreditReport = self.bankCreditReport;
    if (self.bankCreditReport.count > 0) {
        self.tableView.secondCarReport = self.bankCreditReport[0];
    }
    self.dataCreditReport = [NSMutableArray arrayWithArray:[self.creditListDic[@"dataCreditReport"] componentsSeparatedByString:@"||"]];
    self.tableView.dataCreditReport = self.dataCreditReport;
    UITextField *textField1 = [self.view viewWithTag:3000];
    textField1.text = [NSString stringWithFormat:@"%.2f",[self.creditListDic[@"creditCardOccupation"] floatValue]*100];
    self.tableView.creditCardOccupation = self.creditListDic[@"creditCardOccupation"];
    [self.tableView reloadData];
}

- (void)initTableView {
    self.tableView = [[ReferenceInputDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.ButtonDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataDic = self.dataDic;
    [self.view addSubview:self.tableView];
    
    if ([_dataDic[@"status"] isEqualToString:@"0"]) {
        self.tableView.titlestr = @"工行征信";
                }
    if ([_dataDic[@"status"] isEqualToString:@"1"]) {
        self.tableView.titlestr = @"待工行回调";
    }
    if ([_dataDic[@"status"] isEqualToString:@"2"]) {
        self.tableView.titlestr = @"工行回调完成";
    }
    [self.tableView reloadData];
}
-(void)selectButtonClick:(UIButton *)sender{
    secondCarReport = @"";
    self.tableView.secondCarReport = secondCarReport;
    [self.tableView reloadData];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:@[@"通过",@"不通过"]];
        [model CustomBouncedView:array setState:@"100"];
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    _bankResult = Str;
    self.tableView.bankResult = _bankResult;
    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        if (index == 101) {
            [self addButClick];
        }else{
            if (index == 100) {
                if (_bankCreditReport.count > 0) {
                    return;
                }
            }
             [self.imagePicker picker];
        }
        
    }
    else if([state isEqualToString:@"DeletePhotos1"])
    {
        [_bankCreditReport removeObjectAtIndex:index - 1000];
        _tableView.bankCreditReport = _bankCreditReport;
        
    }
    else if([state isEqualToString:@"DeletePhotos2"])
    {
        [_dataCreditReport removeObjectAtIndex:index - 1000];
        _tableView.dataCreditReport = _dataCreditReport;
    }else if ([state isEqualToString:@"confirm"])
    {
        
        if (_bankResult.length == 0) {
            [TLAlert alertWithInfo:@"请选择征信结果"];
            return;
        }
        
//        if (self.bankCreditReport.count == 0) {
//                [TLAlert alertWithInfo:@"请上传银行征信报告"];
//                return;
//        }
//        else{
        if (self.bankCreditReport.count > 0) {
            secondCarReport = self.bankCreditReport[0];
        }
        
//        }
        
        if (self.dataCreditReport.count == 0) {
            [TLAlert alertWithInfo:@"请上传大数据征信报告"];
            return;
        }
        
        UITextField *textField1 = [self.view viewWithTag:3000];
        UITextField *textField2 = [self.view viewWithTag:3001];
//        if ([textField1.text isEqualToString:@""]) {
//            [TLAlert alertWithInfo:@"请输入信用卡使用占比"];
//            return;
//        }
        if ([textField2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入说明"];
            return;
        }
        
        NSString *bankResult;
        if ([_bankResult isEqualToString:@"通过"]) {
            bankResult = @"1";
        }else
        {
            bankResult = @"0";
        }
        
        NSDictionary *dic = @{@"bankCreditReport":[BaseModel convertNull: secondCarReport],
                              @"creditCardOccupation":[BaseModel convertNullWithOutMoney: [NSString stringWithFormat:@"%.2f",[textField1.text floatValue]/100]],
                              @"creditNote":[BaseModel convertNull: textField2.text],
                              @"bankResult":[BaseModel convertNull: bankResult],
                              @"creditUserCode":[BaseModel convertNull: _dataDic[@"code"]],
                              @"dataCreditReport":[BaseModel convertNull: [_dataCreditReport componentsJoinedByString:@"||"]]
                              };
        
        _creditListBlock(dic, _row);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if ([state isEqualToString:@"sender"]){
        if (index == 2) {
            if ([sender.titleLabel.text isEqualToString:@"待工行回调"]) {
                return;
            }
            else if ([sender.titleLabel.text isEqualToString:@"工行征信"]){
                
                TLNetworking * http = [TLNetworking new];
                http.code = @"632114";
                http.showView = self.view;
                http.parameters[@"code"] = _dataDic[@"code"];
                [http postWithSuccess:^(id responseObject) {
                    [TLAlert alertWithSucces:@"征信成功"];
                    self.tableView.titlestr = @"待工行回调";
                    [self.tableView reloadData];
                } failure:^(NSError *error) {
                    
                }];
            }
            else{
                BankResultVC * vc = [BankResultVC new];
                vc.dataDic = self.dataDic;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        if (index == 3) {
            TLNetworking * http = [TLNetworking new];
            http.code = @"632117";
            http.showView = self.view;
            http.parameters[@"creditUserCode"] = _dataDic[@"code"];
            [http postWithSuccess:^(id responseObject) {
                TongDunVC * vc = [TongDunVC new];
                vc.result = responseObject[@"data"];
                [self.navigationController pushViewController:vc animated:YES];
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
    
    [self.tableView reloadData];
}



@end
