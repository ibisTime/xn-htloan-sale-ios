//
//  ReceiveEvaluationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "ReceiveEvaluationVC.h"

#import "ReceiveEvaluationTableView.h"
@interface ReceiveEvaluationVC ()<RefreshDelegate>

@property (nonatomic , strong)ReceiveEvaluationTableView *tableView;
@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
@property (nonatomic , strong)NSArray *policy;
@property (nonatomic , strong)NSArray *carInvoice;
@property (nonatomic , strong)NSArray *driveLicense;
@end

@implementation ReceiveEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[ReceiveEvaluationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
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
    
    
    
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"退回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)throughBtnClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退回上一节点" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
        
    } confirm:^(UIAlertAction *action) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632544";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"approveResult"] = @"0";
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:@"退回成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }];
}

-(void)noThroughBtnClick
{
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632544";
    
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        http.showView = self.view;
    http.parameters[@"approveResult"] = @"1";
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"接收评估成功"];
    
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
    
        } failure:^(NSError *error) {
    
        }];
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
