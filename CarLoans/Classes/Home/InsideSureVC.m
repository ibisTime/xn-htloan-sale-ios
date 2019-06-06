//
//  InsideSureVC.m
//  CarLoans
//
//  Created by shaojianfei on 2018/11/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InsideSureVC.h"
#import "InputInformationMortgageTableView.h"
#import "WSDatePickerView.h"
#import "InsideSureTB.h"
@interface InsideSureVC ()<RefreshDelegate>{
    NSInteger isSelect;
    NSString *date;
}
@property (nonatomic , assign)NSInteger selectInt;

@property (nonatomic , strong)NSMutableArray *GreenBigBenArray;

@property (nonatomic , strong)TLImagePicker *imagePicker;

@property (nonatomic , strong)InsideSureTB *tableView;
@end

@implementation InsideSureVC

- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.7);
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
    
    [self.GreenBigBenArray addObject:data];
    self.tableView.GreenBigBenArray = self.GreenBigBenArray;
    self.model.pledgeUserIdCardCopy = data;
    self.tableView.model = self.model;
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内勤确认";
    date = @"";
    //    _invoiceArray = [NSMutableArray array];
    //    _CertificateArray  = [NSMutableArray array];
    //    _insuranceArray  = [NSMutableArray array];
    //    _BusinessRisksArray  = [NSMutableArray array];
    //    _otherArray = [NSMutableArray array];
    _GreenBigBenArray = [NSMutableArray array];
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[InsideSureTB alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
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
}

-(void)confirmButtonClick
{
    
//    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];
//    UITextField *textField3 = [self.view viewWithTag:102];

   
    
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入审核说明"];
        return;
    }
    NSString *putUrl = [self.GreenBigBenArray componentsJoinedByString:@"||"];
    TLNetworking *http = [TLNetworking new];
    http.code = @"632124";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = textField2.text;
    http.parameters[@"pledgeUser"] = self.model.pledgeUser;
    if (![self.model.pledgeUserIdCardCopy isEqualToString:@""]) {
        http.parameters[@"pledgeUserIdCardCopy"] = self.model.pledgeUserIdCardCopy;

    }else{
        http.parameters[@"pledgeUserIdCardCopy"] = putUrl;

    }

    
    
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"录入成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
}

@end
