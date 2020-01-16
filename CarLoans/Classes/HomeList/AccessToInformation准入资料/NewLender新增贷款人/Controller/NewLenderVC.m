//
//  NewLenderVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewLenderVC.h"
#import "NewLenderTableView.h"
#import "ImproveInformationVC.h"
#import "IdInformationVC.h"
#import "MasterLenderInformationVC.h"
@interface NewLenderVC ()<RefreshDelegate,BaseModelDelegate>

@property (nonatomic , strong)NewLenderTableView *tableView;
@property (nonatomic , strong)NSString *idFront;
@property (nonatomic , strong)NSString *idReverse;
@property (nonatomic , strong)NSDictionary *idFrontDic;
@property (nonatomic , strong)NSDictionary *idReverseDic;
@property (nonatomic , strong)NSString *holdIdCardPdf;

@property (nonatomic , strong)NSString *userName;
@property (nonatomic , strong)NSString *nation;
@property (nonatomic , strong)NSString *gender;
@property (nonatomic , strong)NSString *customerBirth;
@property (nonatomic , strong)NSString *idNo;
@property (nonatomic , strong)NSString *birthAddress;
@property (nonatomic , strong)NSString *authref;
@property (nonatomic , strong)NSString *statdate;
@property (nonatomic , strong)NSString *startDate;

@property (nonatomic , strong)NSString *bankCreditResult;

@property (nonatomic , strong)SurveyModel *model;

@end

@implementation NewLenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新增贷款人信息";
    [self initTableView];
    [self loadData];
}

-(void)initTableView
{
    self.tableView = [[NewLenderTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.dataDic = self.dataDic;
    self.tableView.isDetails = self.isDetails;
    CarLoansWeakSelf;
    self.tableView.returnAryBlock = ^(NSString * _Nonnull idFront, NSDictionary * _Nonnull idFrontDic, NSString * _Nonnull idReverse, NSDictionary * _Nonnull idReverseDic, NSString * _Nonnull holdIdCardPdf) {
        weakSelf.idFront = idFront;
        weakSelf.idFrontDic = idFrontDic;
        weakSelf.idReverse = idReverse;
        weakSelf.idReverseDic = idReverseDic;
        weakSelf.holdIdCardPdf = holdIdCardPdf;
        
        if ([BaseModel isBlankString:idFrontDic[@"userName"]] == NO) {
            weakSelf.userName = [BaseModel convertNull:idFrontDic[@"userName"]];
            weakSelf.nation = [BaseModel convertNull:idFrontDic[@"nation"]];
            weakSelf.gender = [BaseModel convertNull:idFrontDic[@"gender"]];
            weakSelf.customerBirth = [BaseModel convertNull:idFrontDic[@"customerBirth"]];
            weakSelf.idNo = [BaseModel convertNull:idFrontDic[@"idNo"]];
            weakSelf.birthAddress = [BaseModel convertNull:idFrontDic[@"birthAddress"]];
        }
        
        
        if ([BaseModel isBlankString:idReverseDic[@"authref"]] == NO) {
        
            weakSelf.authref = [BaseModel convertNull:idReverseDic[@"authref"]];
            weakSelf.startDate = [BaseModel convertNull:idReverseDic[@"startDate"]];
            weakSelf.statdate = [BaseModel convertNull:idReverseDic[@"statdate"]];
            
        }
        
    };
    [self.view addSubview:self.tableView];
    if (self.isDetails == NO) {
        UIButton *_bottomBtn = [UIButton buttonWithTitle:@"保存" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
        _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_bottomBtn];
    }
    
}

-(void)bottomBtnClick
{
    UITextField *textField3 = [self.view viewWithTag:203];
    UITextField *textField5 = [self.view viewWithTag:205];
    
    
    
    if ([BaseModel isBlankString:self.idReverse] == YES || [BaseModel isBlankString:self.idFront] == YES) {
        [TLAlert alertWithInfo:@"请先上传身份证信息"];
        return;
    }
    if ([textField3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([BaseModel isBlankString:_bankCreditResult] == YES)
    {
        [TLAlert alertWithInfo:@"请选择征信结果"];
        return;
    }
    
    
    if ([[BaseModel convertNull:self.userName] isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入客户姓名"];
        return;
    }

    if ([textField5.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入征信说明"];
        return;
    }
    
    
    if (![self.dataDic[@"dkey"] isEqualToString:@"1"]) {
        TLNetworking * http1 = [[TLNetworking alloc]init];
        http1.code = @"632530";
        http1.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http1.parameters[@"code"] = self.code;
        http1.showView = self.view;
        NSArray *creditUserList = @[@{@"loanRole":[BaseModel convertNull:_dataDic[@"dkey"]],
                                      @"idFront":[BaseModel convertNull:self.idFront],
                                      @"idReverse":[BaseModel convertNull:self.idReverse],
                                      @"holdIdCardPdf":[BaseModel convertNull:self.holdIdCardPdf],
                                      @"userName":[BaseModel convertNull:self.userName],
                                      @"startDate":[BaseModel convertNull:self.startDate],
                                      @"nation":[BaseModel convertNull:self.nation],
                                      @"gender":[BaseModel convertNull:self.gender],
                                      @"customerBirth":[BaseModel convertNull:self.customerBirth],
                                      @"idNo":[BaseModel convertNull:self.idNo],
                                      @"birthAddress":[BaseModel convertNull:self.birthAddress],
                                      @"authref":[BaseModel convertNull:self.authref],
                                      @"statdate":[BaseModel convertNull:self.statdate],
                                      @"bankCreditResult":[BaseModel convertNull:_bankCreditResult],
                                      @"mobile":textField3.text,
                                      @"bankCreditResultRemark":textField5.text,
                                      }];
        
        http1.parameters[@"creditUserList"] = creditUserList;
        [http1 postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632516";
        http.showView = self.view;
        http.parameters[@"code"] = self.code;
        [http postWithSuccess:^(id responseObject) {
            self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            if (self.model.creditUserList.count == 0) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"请完善%@信息",_dataDic[@"dvalue"]]];
                return;
            }
            
            for (int i = 0; i < self.model.creditUserList.count; i ++) {
                if ([self.dataDic[@"dkey"] isEqualToString:self.model.creditUserList[i][@"loanRole"]]) {
                    NSDictionary *creditUser = self.model.creditUserList[i];
                    
                    NSString *education = creditUser[@"education"];
                    
                    
                    if ([BaseModel isBlankString:education] == YES) {
                        [TLAlert alertWithInfo:[NSString stringWithFormat:@"请完善%@信息",_dataDic[@"dvalue"]]];
                        return;
                    }
                    
                    TLNetworking * http1 = [[TLNetworking alloc]init];
                    http1.code = @"632530";
                    http1.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
                    http1.parameters[@"code"] = self.code;
                    http1.showView = self.view;
                    NSArray *creditUserList = @[@{@"loanRole":[BaseModel convertNull:_dataDic[@"dkey"]],
                                                  @"idFront":[BaseModel convertNull:self.idFront],
                                                  @"idReverse":[BaseModel convertNull:self.idReverse],
                                                  @"holdIdCardPdf":[BaseModel convertNull:self.holdIdCardPdf],
                                                  @"userName":[BaseModel convertNull:self.userName],
                                                  @"startDate":[BaseModel convertNull:self.startDate],
                                                  @"nation":[BaseModel convertNull:self.nation],
                                                  @"gender":[BaseModel convertNull:self.gender],
                                                  @"customerBirth":[BaseModel convertNull:self.customerBirth],
                                                  @"idNo":[BaseModel convertNull:self.idNo],
                                                  @"birthAddress":[BaseModel convertNull:self.birthAddress],
                                                  @"authref":[BaseModel convertNull:self.authref],
                                                  @"statdate":[BaseModel convertNull:self.statdate],
                                                  @"bankCreditResult":[BaseModel convertNull:_bankCreditResult],
                                                  @"mobile":textField3.text,
                                                  @"bankCreditResultRemark":textField5.text,
                                                  }];
                    
                    http1.parameters[@"creditUserList"] = creditUserList;
                    [http1 postWithSuccess:^(id responseObject) {
                        
                        [TLAlert alertWithSucces:@"保存成功"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                        
                    } failure:^(NSError *error) {
                        
                    }];
                    
                    
                }
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
        
    
    
    
    
    
    
}

-(void)loadData
{
    
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        _bankCreditResult = @"1";
        _tableView.bankCreditResult = _bankCreditResult;
        for (int i = 0; i < self.model.creditUserList.count; i ++) {
        
            if ([self.dataDic[@"dkey"] isEqualToString:self.model.creditUserList[i][@"loanRole"]]) {
                NSDictionary *creditUser = self.model.creditUserList[i];
                
                if ([self.dataDic[@"dkey"] isEqualToString:@"1"]) {
                    _idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_apply"];
                    _tableView.idFront = _idFront;
                    _idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_apply"];
                    _tableView.idReverse = _idReverse;
                    _holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_apply"];
                    _tableView.holdIdCardPdf = _holdIdCardPdf;
                }
                if ([self.dataDic[@"dkey"] isEqualToString:@"2"]) {
                    _idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_gh"];
                    _tableView.idFront = _idFront;
                    _idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_gh"];
                    _tableView.idReverse = _idReverse;
                    _holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_gh"];
                    _tableView.holdIdCardPdf = _holdIdCardPdf;
                }
                if ([self.dataDic[@"dkey"] isEqualToString:@"3"]) {
                    _idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_gua"];
                    _tableView.idFront = _idFront;
                    _idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_gua"];
                    _tableView.idReverse = _idReverse;
                    _holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_gua"];
                    _tableView.holdIdCardPdf = _holdIdCardPdf;
                }
                if ([self.dataDic[@"dkey"] isEqualToString:@"4"]) {
                    _idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_gua1"];
                    _tableView.idFront = _idFront;
                    _idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_gua1"];
                    _tableView.idReverse = _idReverse;
                    _holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_gua1"];
                    _tableView.holdIdCardPdf = _holdIdCardPdf;
                }
                if ([self.dataDic[@"dkey"] isEqualToString:@"5"]) {
                    _idFront = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_front_gh1"];
                    _tableView.idFront = _idFront;
                    _idReverse = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"id_no_reverse_gh1"];
                    _tableView.idReverse = _idReverse;
                    _holdIdCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hold_id_card_gh1"];
                    _tableView.holdIdCardPdf = _holdIdCardPdf;
                }
                
                
                _userName = [BaseModel convertNull:creditUser[@"userName"]];
                _nation = [BaseModel convertNull:creditUser[@"nation"]];
                _gender = [BaseModel convertNull:creditUser[@"gender"]];
                _customerBirth = [BaseModel convertNull:creditUser[@"customerBirth"]];
                _idNo = [BaseModel convertNull:creditUser[@"idNo"]];
                _birthAddress = [BaseModel convertNull:creditUser[@"birthAddress"]];
                _authref = [BaseModel convertNull:creditUser[@"authref"]];
                _statdate = [BaseModel convertNull:creditUser[@"statdate"]];
                if ([BaseModel isBlankString:creditUser[@"bankCreditResult"]] == YES) {
                    _bankCreditResult = @"1";
                }else
                {
                    _bankCreditResult = creditUser[@"bankCreditResult"];
                }
                
                _startDate = [BaseModel convertNull:creditUser[@"startDate"]];
                
                _tableView.bankCreditResult = _bankCreditResult;
                
                UITextField *textField3 = [self.view viewWithTag:203];
                UITextField *textField5 = [self.view viewWithTag:205];
                textField3.text = [BaseModel convertNull:creditUser[@"mobile"]];
                textField5.text = [BaseModel convertNull:creditUser[@"bankCreditResultRemark"]];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     
    if (indexPath.row == 2) {
        
        if ([BaseModel isBlankString:self.idReverse] == YES || [BaseModel isBlankString:self.idFront] == YES) {
            [TLAlert alertWithInfo:@"请先上传身份证正反面"];
            return;
        }
        IdInformationVC *vc = [IdInformationVC new];
        vc.userName = self.userName;
        vc.nation = self.nation;
        vc.gender = self.gender;
        vc.customerBirth = self.customerBirth;
        vc.idNo = self.idNo;
        vc.birthAddress = self.birthAddress;
        vc.authref = self.authref;
        vc.statdate = self.statdate;
        vc.isDetails = self.isDetails;
        vc.startDate = self.startDate;
        CarLoansWeakSelf;
        vc.returnAryBlock = ^(NSDictionary * _Nonnull creditUserDic) {
            weakSelf.userName = [BaseModel convertNull:creditUserDic[@"userName"]];
            weakSelf.nation = [BaseModel convertNull:creditUserDic[@"nation"]];
            weakSelf.gender = [BaseModel convertNull:creditUserDic[@"gender"]];
            weakSelf.customerBirth = [BaseModel convertNull:creditUserDic[@"customerBirth"]];
            weakSelf.idNo = [BaseModel convertNull:creditUserDic[@"idNo"]];
            weakSelf.birthAddress = [BaseModel convertNull:creditUserDic[@"birthAddress"]];
            weakSelf.authref = [BaseModel convertNull:creditUserDic[@"authref"]];
            weakSelf.statdate = [BaseModel convertNull:creditUserDic[@"statdate"]];
            weakSelf.startDate = [BaseModel convertNull:creditUserDic[@"startDate"]];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 4) {
        if (self.isDetails == YES) {
            return;
        }
        BaseModel *baseModel = [BaseModel new];
        baseModel.ModelDelegate = self;
        [baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"通过",@"不通过"]] setState:@"100"];
    }
    if (indexPath.row == 6) {
        if ([self.dataDic[@"dkey"] isEqualToString:@"1"]) {
            ImproveInformationVC *vc = [ImproveInformationVC new];
            vc.code = self.code;
            vc.dataDic = self.dataDic;
            vc.isDetails = self.isDetails;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            
            MasterLenderInformationVC *vc = [MasterLenderInformationVC new];
            vc.code = self.code;
            vc.dataDic = self.dataDic;
            vc.isDetails = self.isDetails;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if (sid == 0) {
        self.bankCreditResult = @"1";
    }else
    {
        self.bankCreditResult = @"0";
    }
    self.tableView.bankCreditResult = self.bankCreditResult;
    [self.tableView reloadData];
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
