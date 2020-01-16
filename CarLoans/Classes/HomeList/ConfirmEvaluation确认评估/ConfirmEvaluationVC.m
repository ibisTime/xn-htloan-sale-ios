//
//  ConfirmEvaluationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "ConfirmEvaluationVC.h"

#import "ConfirmEvaluationTableView.h"

@interface ConfirmEvaluationVC ()<RefreshDelegate>

@property (nonatomic , strong)ConfirmEvaluationTableView *tableView;
@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
@property (nonatomic , strong)NSArray *policy;
@property (nonatomic , strong)NSArray *carInvoice;
@property (nonatomic , strong)NSArray *driveLicense;
@end

@implementation ConfirmEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    
    
    self.tableView = [[ConfirmEvaluationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    CarLoansWeakSelf;
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        self.carRegisterCertificateFirst = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_register_certificate_first"] componentsSeparatedByString:@"||"];
        self.tableView.carRegisterCertificateFirst = self.carRegisterCertificateFirst;
        
        self.carInvoice = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_invoice"] componentsSeparatedByString:@"||"];
        self.tableView.carInvoice = self.carInvoice;
        
        self.policy = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"policy"] componentsSeparatedByString:@"||"];
        self.tableView.policy = self.policy;
        
        self.driveLicense = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_license"] componentsSeparatedByString:@"||"];
        self.tableView.driveLicense = self.driveLicense;
        
        
        self.tableView.idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_apply"];
        self.tableView.idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_apply"];
        self.tableView.holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_apply"];
        
        
        self.tableView.model = self.model;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    

    self.tableView.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
//        @[@"车辆登记证书（多选）",@"保单图片（多选）",@"发票图片",@"行驶证"]
        //        @property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
//        @property (nonatomic , strong)NSArray *policy;
//        @property (nonatomic , strong)NSArray *carInvoice;
//        @property (nonatomic , strong)NSArray *driveLicense;
        if ([name isEqualToString:@"车辆登记证书（多选）"]) {
            weakSelf.carRegisterCertificateFirst = imgAry;
            weakSelf.tableView.carRegisterCertificateFirst = weakSelf.carRegisterCertificateFirst;
        }
        if ([name isEqualToString:@"保单图片（多选）"]) {
            weakSelf.policy = imgAry;
            weakSelf.tableView.policy = weakSelf.policy;
        }
        if ([name isEqualToString:@"发票图片"]) {
            weakSelf.carInvoice = imgAry;
            weakSelf.tableView.carInvoice = weakSelf.carInvoice;
        }
        
        if ([name isEqualToString:@"行驶证"]) {
            weakSelf.driveLicense = imgAry;
            weakSelf.tableView.driveLicense = weakSelf.driveLicense;
        }
        [weakSelf.tableView reloadData];
        
    };
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"保存" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"提交" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)throughBtnClick
{
    [self LoadData:@"0"];
}


-(void)noThroughBtnClick
{
    [self LoadData:@"1"];
}

-(void)LoadData:(NSString *)isSend
{
//    @[@"车辆登记证书（多选）",@"保单图片（多选）",@"发票图片",@"行驶证"]
    if (self.carRegisterCertificateFirst.count == 0) {
        [TLAlert alertWithInfo:@"请上传车辆登记证书"];
        return;
    }
    if (self.policy.count == 0) {
        [TLAlert alertWithInfo:@"请上传保单图片"];
        return;
    }
    if (self.carInvoice.count == 0) {
        [TLAlert alertWithInfo:@"请上传发票图片"];
        return;
    }
    if (self.driveLicense.count == 0) {
        [TLAlert alertWithInfo:@"请上传行驶证"];
        return;
    }
    
//    @property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
//    @property (nonatomic , strong)NSArray *policy;
//    @property (nonatomic , strong)NSArray *carInvoice;
//    @property (nonatomic , strong)NSArray *driveLicense;
    TLNetworking *http = [TLNetworking new];
    http.code = @"632543";
    http.showView = self.view;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.model.code;
    
    if (self.carRegisterCertificateFirst.count > 0) {
        http.parameters[@"carRegisterCertificateFirst"] = [self.carRegisterCertificateFirst componentsJoinedByString:@"||"];
    }
    if (self.policy.count > 0) {
        http.parameters[@"policy"] = [self.policy componentsJoinedByString:@"||"];
    }
    if (self.carInvoice.count > 0) {
        http.parameters[@"carInvoice"] = [self.carInvoice componentsJoinedByString:@"||"];
    }
    if (self.driveLicense.count > 0) {
        http.parameters[@"driveLicense"] = [self.driveLicense componentsJoinedByString:@"||"];
    }
    http.parameters[@"isSend"] = isSend;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        if ([isSend isEqualToString:@"0"]) {
            [TLAlert alertWithSucces:@"保存成功"];
        }else
        {
            [TLAlert alertWithSucces:@"提交成功"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });

        
    } failure:^(NSError *error) {
    }];
    
    
//    TLNetworking *http = [TLNetworking new];
//    http.isShowMsg = YES;
//    if ([self.title isEqualToString:@"发送抵押"]) {
//        http.code = @"632581";
//    }
//    else
//    {
//        http.code = @"632580";
//    }
//
//    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
//    http.parameters[@"code"] = self.model.code;
//    http.showView = self.view;
//    [http postWithSuccess:^(id responseObject) {
//        if ([self.title isEqualToString:@"发送抵押"]) {
//            [TLAlert alertWithSucces:@"发送抵押成功"];
//        }else{
//            [TLAlert alertWithSucces:@"确认抵押成功"];
//        }
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.navigationController popViewControllerAnimated:YES];
//        });
//
//    } failure:^(NSError *error) {
//
//    }];
//
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
