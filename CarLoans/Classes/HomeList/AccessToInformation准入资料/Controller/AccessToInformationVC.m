//
//  AccessToInformationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AccessToInformationVC.h"
#import "MenuToSelectView.h"
#import "MenuTableView1.h"
#import "MenuTableView2.h"
#import "MenuTableView3.h"
#import "MenuTableView4.h"
#import "MenuTableView5.h"
#import "MenuTableView6.h"
#import "MenuTableView7.h"
#import "MenuTableView8.h"
#import "MenuTableView9.h"
#import "NewLenderVC.h"
#import "ChooseCarVC.h"
#import "WebVC.h"
#import "DealerSearchVC.h"
#import "GPSSearchVC.h"
@interface AccessToInformationVC ()<MenuDelegate,RefreshDelegate,BaseModelDelegate>
{
//    选择那个菜单
    NSInteger selectTag;
    
    NSArray *saleUserIdAry;
    NSArray *loanBankCodeAry;
    NSArray *regionAry;
    NSArray *shopCarGarageAry;
    
    UIButton *submitBtn;
    NSArray *selectGpsAry;
}

@property (nonatomic , strong)MenuToSelectView *menuView;
@property (nonatomic , strong)MenuTableView1 *tableView1;
@property (nonatomic , strong)MenuTableView2 *tableView2;
@property (nonatomic , strong)MenuTableView3 *tableView3;
@property (nonatomic , strong)MenuTableView4 *tableView4;
@property (nonatomic , strong)MenuTableView5 *tableView5;
@property (nonatomic , strong)MenuTableView6 *tableView6;
@property (nonatomic , strong)MenuTableView7 *tableView7;
@property (nonatomic , strong)MenuTableView8 *tableView8;
@property (nonatomic , strong)MenuTableView9 *tableView9;
@property (nonatomic , strong)BaseModel *baseModel;
@property (nonatomic , strong)NSArray *credit_user_loan_roleArray;

@property (nonatomic , assign)NSInteger SelectTag;

@property (nonatomic , strong)UIButton *bottomBtn;

@property (nonatomic , copy)NSString *cardPostAddress;
@property (nonatomic , copy)NSString *loanBankCode;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *region;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , copy)NSString *regDate;
@property (nonatomic , copy)NSString *mile;
@property (nonatomic , copy)NSString *secondCarReport;
@property (nonatomic , copy)NSString *carBrand;
@property (nonatomic , copy)NSString *carSeries;
@property (nonatomic , copy)NSString *ascription;
@property (nonatomic , strong)NSArray *ascriptionAry;
@property (nonatomic , copy)NSString *carModel;
@property (nonatomic , copy)NSString *shopCarGarage;
@property (nonatomic , copy)NSString *saleUserId;
@property (nonatomic , copy)NSString *zone;


//联系人
@property (nonatomic , copy)NSString *emergencyName1;
@property (nonatomic , copy)NSString *emergencyRelation1;
@property (nonatomic , copy)NSString *emergencyMobile1;
@property (nonatomic , copy)NSString *emergencyName2;
@property (nonatomic , copy)NSString *emergencyRelation2;
@property (nonatomic , copy)NSString *emergencyMobile2;


//联系信息
@property (nonatomic , strong)NSString *loanAmount;
@property (nonatomic , strong)NSString *periods;
@property (nonatomic , strong)NSString *bankRate;
@property (nonatomic , strong)NSString *totalRate;
@property (nonatomic , strong)NSString *rebateRate;
@property (nonatomic , strong)NSString *fee;
@property (nonatomic , strong)NSString *rateType;
@property (nonatomic , strong)NSString *isAdvanceFund;
@property (nonatomic , strong)NSString *isDiscount;
@property (nonatomic , strong)NSString *discountRate;
@property (nonatomic , strong)NSString *discountAmount;
@property (nonatomic , strong)NSString *loanRatio;
@property (nonatomic , strong)NSString *wanFactor;
@property (nonatomic , strong)NSString *monthAmount;
@property (nonatomic , strong)NSString *repayFirstMonthAmount;
@property (nonatomic , strong)NSString *highCashAmount;
@property (nonatomic , strong)NSString *totalFee;
@property (nonatomic , strong)NSString *customerBearRate;
@property (nonatomic , strong)NSString *surchargeRate;
@property (nonatomic , strong)NSString *surchargeAmount;
@property (nonatomic , strong)NSString *openCardAmount;
@property (nonatomic , strong)NSString *notes;
@property (nonatomic , strong)NSString *evalPrice;

@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *carNumber;
@property (nonatomic , copy)NSString *carFrameNo;
@property (nonatomic , copy)NSString *carEngineNo;

@property (nonatomic , strong)NSArray *driveCard;
@property (nonatomic , strong)NSString *marryPdf;
@property (nonatomic , strong)NSString *divorcePdf;
@property (nonatomic , strong)NSString *singleProve;
@property (nonatomic , strong)NSString *incomeProve;
@property (nonatomic , strong)NSString *liveProvePdf;
@property (nonatomic , strong)NSString *housePropertyCardPdf;
@property (nonatomic , strong)NSArray *hkBookFirstPage;
@property (nonatomic , strong)NSArray *bankJourFirstPage;
@property (nonatomic , strong)NSArray *zfbJour;
@property (nonatomic , strong)NSArray *wxJour;
@property (nonatomic , strong)NSArray *otherPdf;
@property (nonatomic , strong)NSArray *contractAwardVideo;

@property (nonatomic , strong)NSArray *doorPdf;
@property (nonatomic , strong)NSArray *groupPhoto;
@property (nonatomic , strong)NSArray *houseVideo;
@property (nonatomic , strong)NSArray *companyVideo;

@property (nonatomic , strong)NSArray *driveLicense;

//车辆图
@property (nonatomic , strong)NSArray *carHead;
@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
@property (nonatomic , strong)NSArray *policy;
@property (nonatomic , strong)NSArray *carInvoice;

@property (nonatomic , strong)NSMutableArray *gpsAry;
//@property (nonatomic , strong)NSString *regDate;
@property (nonatomic , strong)NSString *isAzGps;
//@property (nonatomic , strong)NSString *regAddress;
@property (nonatomic , strong)NSString *isPublicCard;

//@property (nonatomic , strong)SurveyModel *model;

@end

@implementation AccessToInformationVC

-(MenuToSelectView *)menuView
{
    if (!_menuView) {
        _menuView = [[MenuToSelectView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _menuView.delegate = self;
    }
    return _menuView;
}

-(void)initTableView
{
    
    _baseModel = [BaseModel new];
    _baseModel.ModelDelegate = self;
    
    
    self.tableView1 = [[MenuTableView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView1.refreshDelegate = self;
    self.tableView1.backgroundColor = kWhiteColor;
    self.tableView1.tag = 20100;
    [self.view addSubview:self.tableView1];
    
    self.tableView2 = [[MenuTableView2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView2.refreshDelegate = self;
    self.tableView2.backgroundColor = kWhiteColor;
    self.tableView2.tag = 20101;
    [self.view addSubview:self.tableView2];
    
    self.tableView3 = [[MenuTableView3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView3.refreshDelegate = self;
    self.tableView3.backgroundColor = kWhiteColor;
    self.tableView3.tag = 20102;
    [self.view addSubview:self.tableView3];
    
    
    self.tableView4 = [[MenuTableView4 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView4.refreshDelegate = self;
    self.tableView4.backgroundColor = kWhiteColor;
    self.tableView4.tag = 20103;
    [self.view addSubview:self.tableView4];
    
    
    self.tableView5 = [[MenuTableView5 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView5.refreshDelegate = self;
    self.tableView5.backgroundColor = kWhiteColor;
    self.tableView5.tag = 20104;
    [self.view addSubview:self.tableView5];
    
    MJWeakSelf;
    self.tableView6 = [[MenuTableView6 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView6.refreshDelegate = self;
    self.tableView6.backgroundColor = kWhiteColor;
    self.tableView6.tag = 20105;
    self.tableView6.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        
        
        
        weakSelf.tableView6.driveLicense = @[];
        weakSelf.driveLicense = @[];
        [weakSelf.tableView6 reloadData];
        
//        if ([BaseModel isBlankString:self.regDate] == YES) {
//            [TLAlert alertWithInfo:@"请输入上牌时间"];
//            return;
//        }
//        if ([BaseModel isBlankString:self.region] == YES) {
//            [TLAlert alertWithInfo:@"请输入城市编号"];
//            return;
//        }
        UITextField *text = [weakSelf.view viewWithTag:6001];
//        if ([text.text isEqualToString:@""]) {
//            [TLAlert alertWithInfo:@"请输入公里数"];
//            return;
//        }
        
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632980";
        http.parameters[@"zone"] = weakSelf.region;
        http.parameters[@"regDate"] = weakSelf.regDate;
        http.parameters[@"mile"] = text.text;
        http.parameters[@"url"] = [[imgAry componentsJoinedByString:@"||"] convertImageUrl];
        http.showView = weakSelf.view;
        [http postWithSuccess:^(id responseObject) {
            
            
            weakSelf.secondCarReport = responseObject[@"data"][@"secondCarReport"];
            weakSelf.tableView6.secondCarReport = responseObject[@"data"][@"secondCarReport"];
            
            weakSelf.carBrand = responseObject[@"data"][@"carBrand"];
            weakSelf.tableView6.carBrand = responseObject[@"data"][@"brandName"];
            
            weakSelf.carSeries = responseObject[@"data"][@"carSeries"];
            weakSelf.tableView6.carSeries = responseObject[@"data"][@"seriesName"];
            
            weakSelf.carModel = responseObject[@"data"][@"carModel"];
            weakSelf.tableView6.carModel = responseObject[@"data"][@"modelName"];
            
           
            weakSelf.carModel = responseObject[@"data"][@"carModel"];
            weakSelf.tableView6.carModel = responseObject[@"data"][@"modelName"];
            
            weakSelf.tableView6.modelNumber = responseObject[@"data"][@"modelNumber"];
            
            weakSelf.evalPrice = responseObject[@"data"][@"evalPrice"];
            weakSelf.tableView6.evalPrice = responseObject[@"data"][@"evalPrice"];
            
            weakSelf.originalPrice = responseObject[@"data"][@"originalPrice"];
            weakSelf.tableView6.originalPrice = responseObject[@"data"][@"originalPrice"];
            
            weakSelf.carNumber = responseObject[@"data"][@"carNumber"];
            weakSelf.tableView6.carNumber = responseObject[@"data"][@"carNumber"];
            
            weakSelf.carFrameNo = responseObject[@"data"][@"carFrameNo"];
            weakSelf.tableView6.carFrameNo = responseObject[@"data"][@"carFrameNo"];
            
            weakSelf.carEngineNo = responseObject[@"data"][@"carEngineNo"];
            weakSelf.tableView6.carEngineNo = responseObject[@"data"][@"carEngineNo"];
            
            weakSelf.tableView6.driveLicense = imgAry;
            weakSelf.driveLicense = imgAry;
            [weakSelf.tableView6 reloadData];
            
        } failure:^(NSError *error) {
            
        }];
    };
    [self.view addSubview:self.tableView6];
    
    
    self.tableView7 = [[MenuTableView7 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView7.refreshDelegate = self;
    self.tableView7.backgroundColor = kWhiteColor;
    self.tableView7.tag = 20106;
    
    self.tableView7.dataUploadBlock = ^(NSString * _Nonnull driveCard, NSString * _Nonnull marryPdf, NSString * _Nonnull divorcePdf, NSString * _Nonnull singleProve, NSString * _Nonnull incomeProve, NSString * _Nonnull liveProvePdf, NSString * _Nonnull housePropertyCardPdf) {
//        weakSelf.driveCard = driveCard;
        weakSelf.marryPdf = marryPdf;
        weakSelf.divorcePdf = divorcePdf;
        weakSelf.singleProve = singleProve;
        weakSelf.incomeProve = incomeProve;
        weakSelf.liveProvePdf = liveProvePdf;
        weakSelf.housePropertyCardPdf = housePropertyCardPdf;
//        weakSelf.tableView7.driveCard = driveCard;
        weakSelf.tableView7.marryPdf = marryPdf;
        weakSelf.tableView7.divorcePdf = divorcePdf;
        weakSelf.tableView7.singleProve = singleProve;
        weakSelf.tableView7.incomeProve = incomeProve;
        weakSelf.tableView7.liveProvePdf = liveProvePdf;
        weakSelf.tableView7.housePropertyCardPdf = housePropertyCardPdf;
        [weakSelf.tableView7 reloadData];
    };
    
    self.tableView7.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
//        @[@"户口本（多选）",@"银行流水（多选）",@"支付宝流水（多选）",@"微信流水（多选）",@"其他（多选）"]
        if ([name isEqualToString:@"驾驶证（多选）"]) {
            weakSelf.driveCard = imgAry;
            weakSelf.tableView7.driveCard = imgAry;
        }
        if ([name isEqualToString:@"户口本（多选）"]) {
            weakSelf.hkBookFirstPage = imgAry;
            weakSelf.tableView7.hkBookFirstPage = imgAry;
        }
        if ([name isEqualToString:@"银行流水（多选）"]) {
            weakSelf.bankJourFirstPage = imgAry;
            weakSelf.tableView7.bankJourFirstPage = imgAry;
        }
        if ([name isEqualToString:@"支付宝流水（多选）"]) {
            weakSelf.zfbJour = imgAry;
            weakSelf.tableView7.zfbJour = imgAry;
        }
        if ([name isEqualToString:@"微信流水（多选）"]) {
            weakSelf.wxJour = imgAry;
            weakSelf.tableView7.wxJour = imgAry;
        }
        if ([name isEqualToString:@"其他（多选）"]) {
            weakSelf.otherPdf = imgAry;
            weakSelf.tableView7.otherPdf = imgAry;
        }
        if ([name isEqualToString:@"合同签约视频"]) {
            weakSelf.contractAwardVideo = imgAry;
            weakSelf.tableView7.contractAwardVideo = imgAry;
        }
        [weakSelf.tableView7 reloadData];
    };
    [self.view addSubview:self.tableView7];
    
    self.tableView8 = [[MenuTableView8 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView8.refreshDelegate = self;
    self.tableView8.backgroundColor = kWhiteColor;
    self.tableView8.tag = 20107;
    self.tableView8.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        if ([name isEqualToString:@"上门照片（多选）"]) {
            weakSelf.doorPdf = imgAry;
            weakSelf.tableView8.doorPdf = imgAry;
        }
        if ([name isEqualToString:@"合照（多选）"]) {
            weakSelf.groupPhoto = imgAry;
            weakSelf.tableView8.groupPhoto = imgAry;
        }
        if ([name isEqualToString:@"家访视频"]) {
            weakSelf.houseVideo = imgAry;
            weakSelf.tableView8.houseVideo = imgAry;
        }
        if ([name isEqualToString:@"公司视频"]) {
            weakSelf.companyVideo = imgAry;
            weakSelf.tableView8.companyVideo = imgAry;
        }
        [weakSelf.tableView8 reloadData];
    };
    [self.view addSubview:self.tableView8];
    
    
    self.tableView9 = [[MenuTableView9 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView9.refreshDelegate = self;
    self.tableView9.backgroundColor = kWhiteColor;
    self.tableView9.tag = 20108;
    self.tableView9.returnAryBlock = ^(NSArray *imgAry, NSString *name, NSInteger section) {
//        @[@"车辆图（多选）",@"车辆登记证书（多选）"]
        if ([name isEqualToString:@"车辆图（多选）"]) {
            weakSelf.carHead = imgAry;
        }
        if ([name isEqualToString:@"车辆登记证书（多选）"]) {
            weakSelf.carRegisterCertificateFirst = imgAry;
        }
        if ([name isEqualToString:@"保单图片（多选）"]) {
            weakSelf.policy = imgAry;
        }
        if ([name isEqualToString:@"发票图片"]) {
            weakSelf.carInvoice = imgAry;
        }
        
        weakSelf.tableView9.carHead = weakSelf.carHead;
        weakSelf.tableView9.carRegisterCertificateFirst = weakSelf.carRegisterCertificateFirst;
        weakSelf.tableView9.policy = weakSelf.policy;
        weakSelf.tableView9.carInvoice = weakSelf.carInvoice;
        [weakSelf.tableView9 reloadData];
    };
    [self.view addSubview:self.tableView9];
    [self.view bringSubviewToFront:self.tableView1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.tableView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView3.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView4.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView5.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView6.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView7.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView8.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        self.tableView9.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
        
    });
}

-(void)shopCarGarageLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630477";
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        if ([BaseModel isBlankString:self.model.region] == YES) {
            regionAry = responseObject[@"data"];
            if (regionAry.count > 0) {
                _tableView1.region = [NSString stringWithFormat:@"%@-%@",regionAry[0][@"provName"],regionAry[0][@"cityName"]];
                _tableView6.regAddress = [NSString stringWithFormat:@"%@-%@",regionAry[0][@"provName"],regionAry[0][@"cityName"]];
//                _tableView6.regAddress = [NSString stringWithFormat:@"%@-%@",regionAry[0][@"provName"],regionAry[0][@"cityName"]];
                _region = regionAry[0][@"id"];
                [self.tableView6 reloadData];
                [self.tableView1 reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (refreshTableview.tag == 20100) {
        _SelectTag = indexPath.row + 10000;
        switch (indexPath.row) {
            case 0:
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"630066";
                http.parameters[@"roleCode"] = @"SR201800000000000000YWY";
                http.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
                http.showView = self.view;
                [http postWithSuccess:^(id responseObject) {
                    saleUserIdAry = responseObject[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < saleUserIdAry.count; i ++) {
                        [array addObject:saleUserIdAry[i][@"realName"]];
                    }
                    [_baseModel CustomBouncedView:array setState:@"100"];
                } failure:^(NSError *error) {
                    
                }];
            }
                break;
            case 1:
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"632037";
                http.parameters[@"ststus"] = @"1";
                http.showView = self.view;
                [http postWithSuccess:^(id responseObject) {
                    loanBankCodeAry = responseObject[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < loanBankCodeAry.count; i ++) {
                        [array addObject:[NSString stringWithFormat:@"%@-%@",loanBankCodeAry[i][@"bankName"],loanBankCodeAry[i][@"subbranch"]]];
                    }
                    [_baseModel CustomBouncedView:array setState:@"100"];
                    
                } failure:^(NSError *error) {
                    
                }];
            }
                break;
            case 2:
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"630477";
                http.showView = self.view;
                [http postWithSuccess:^(id responseObject) {
                    regionAry = responseObject[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < regionAry.count; i ++) {
                        [array addObject:[NSString stringWithFormat:@"%@-%@",regionAry[i][@"provName"],regionAry[i][@"cityName"]]];
                    }
                    [_baseModel CustomBouncedView:array setState:@"100"];
                } failure:^(NSError *error) {
                    
                }];
            }
                break;
            case 3:
            {
                DealerSearchVC *vc = [DealerSearchVC new];
                CarLoansWeakSelf;
                vc.returnAryBlock = ^(SurveyModel * _Nonnull model) {
                    weakSelf.tableView1.shopCarGarage = model.fullName;
                    weakSelf.shopCarGarage = model.code;
                    [weakSelf.tableView1 reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
            case 4:
            {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"632907";
                http.showView = self.view;
                [http postWithSuccess:^(id responseObject) {
                    _ascriptionAry = responseObject[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < _ascriptionAry.count; i ++) {
                        
                        [array addObject:[BaseModel convertNull:_ascriptionAry[i][@"fullName"]]];
                    }
                    [_baseModel CustomBouncedView:array setState:@"100"];
                } failure:^(NSError *error) {
                    
                }];
            }
                break;
            case 5:
            {
                [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"新车",@"二手车"]] setState:@"100"];
            }
                break;

            default:
                break;
        }
    }
    if (refreshTableview.tag == 20101) {
        NewLenderVC *vc = [NewLenderVC new];
        vc.dataDic = _credit_user_loan_roleArray[indexPath.row];
        vc.code = self.model.code;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (refreshTableview.tag == 20102) {
        _SelectTag = indexPath.section + 30000;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                [_baseModel ReturnsParentKeyAnArray:@"credit_user_relation"];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 1) {
                [_baseModel ReturnsParentKeyAnArray:@"credit_user_relation"];
            }
        }
    }
    if (refreshTableview.tag == 20103) {
        _SelectTag = indexPath.row + 40000;
        if (indexPath.row == 1) {
            [_baseModel ReturnsParentKeyAnArray:@"loan_period"];
        }
        if (indexPath.row == 4) {
            
        }
        if (indexPath.row == 5) {
            [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"是",@"否"]] setState:@"100"];
        }
        if (indexPath.row == 13) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.wanFactor = date;
                self.tableView4.wanFactor = date;
                [self.tableView4 reloadData];
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
        if (indexPath.row == 14) {
            [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"传统",@"直客"]] setState:@"100"];
        }
        if (indexPath.row == 16) {
            [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"是",@"否"]] setState:@"100"];
        }
    }
    if (refreshTableview.tag == 20105) {
        
        
        
        if (indexPath.section == 0) {
            
            
            
            NSInteger row;
            if ([self.bizType isEqualToString:@"1"]) {
                row = 4;
                
                
                if (indexPath.row == 0) {
                    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
                        
                        NSString *date = [selectDate stringWithFormat:@"yyyy-MM"];
                        self.regDate = date;
                        self.tableView6.regDate = date;
                        [self.tableView6 reloadData];
                    }];
                    datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
                    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                    datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
                    [datepicker show];
                }
                
                
                if (indexPath.row == 3) {
                    if ([BaseModel isBlankString:self.secondCarReport] == YES) {
                        UITextField *text = [self.view viewWithTag:6001];
                        
                        if ([BaseModel isBlankString:self.region] == YES) {
                            [TLAlert alertWithInfo:@"请选择业务发生地"];
                            return;
                        }
                        if ([BaseModel isBlankString:self.carModel] == YES) {
                            [TLAlert alertWithInfo:@"请选择车型"];
                            return;
                        }
                        if ([BaseModel isBlankString:self.regDate] == YES) {
                            [TLAlert alertWithInfo:@"请输入上牌时间"];
                            return;
                        }
                        if ([text.text isEqualToString:@""]) {
                            [TLAlert alertWithInfo:@"请输入公里数"];
                            return;
                        }
                        TLNetworking *http = [TLNetworking new];
                        http.isShowMsg = YES;
                        http.code = @"630479";
                        http.parameters[@"zone"] = self.region;
                        http.parameters[@"regDate"] = self.regDate;
                        http.parameters[@"mile"] = text.text;
                        http.parameters[@"modelId"] = self.carModel;
                        http.showView = self.view;
                        [http postWithSuccess:^(id responseObject) {
                            
                            self.secondCarReport = responseObject[@"data"][@"url"];
                            self.tableView6.secondCarReport = responseObject[@"data"][@"url"];
                            [self.tableView6 reloadData];
                        } failure:^(NSError *error) {
                            
                        }];
                    }else
                    {
                        if ([self.secondCarReport isEqualToString:@""]) {
                            {
                                UITextField *text = [self.view viewWithTag:6001];
                                
                                if ([BaseModel isBlankString:self.region] == YES) {
                                    [TLAlert alertWithInfo:@"请选择业务发生地"];
                                    return;
                                }
                                if ([BaseModel isBlankString:self.carModel] == YES) {
                                    [TLAlert alertWithInfo:@"请选择车型"];
                                    return;
                                }
                                if ([BaseModel isBlankString:self.regDate] == YES) {
                                    [TLAlert alertWithInfo:@"请输入上牌时间"];
                                    return;
                                }
                                if ([text.text isEqualToString:@""]) {
                                    [TLAlert alertWithInfo:@"请输入公里数"];
                                    return;
                                }
                                TLNetworking *http = [TLNetworking new];
                                http.isShowMsg = YES;
                                http.code = @"630479";
                                http.parameters[@"zone"] = self.region;
                                http.parameters[@"regDate"] = self.regDate;
                                http.parameters[@"mile"] = text.text;
                                http.parameters[@"modelId"] = self.carModel;
                                http.showView = self.view;
                                [http postWithSuccess:^(id responseObject) {
                                    
                                    self.secondCarReport = responseObject[@"data"][@"url"];
                                    self.tableView6.secondCarReport = responseObject[@"data"][@"url"];
                                    [self.tableView6 reloadData];
                                } failure:^(NSError *error) {
                                    
                                }];
                            }
                        }else
                        {
                            WebVC *vc = [WebVC new];
                            vc.url = self.secondCarReport;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                    }
                }
                
                
            }else
            {
                row = 0;
            }
            _SelectTag = indexPath.row + 60000;

            if (indexPath.row == 6 + row) {
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = YES;
                http.code = @"630477";
                http.showView = self.view;
                [http postWithSuccess:^(id responseObject) {
                    regionAry = responseObject[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0; i < regionAry.count; i ++) {
                        [array addObject:[NSString stringWithFormat:@"%@-%@",regionAry[i][@"provName"],regionAry[i][@"cityName"]]];
                    }
                    [_baseModel CustomBouncedView:array setState:@"100"];
                } failure:^(NSError *error) {
                    
                }];
            }
            if (indexPath.row == 7 + row) {
                [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"是",@"否"]] setState:@"100"];
            }
            if (indexPath.row == 8 + row) {
                ChooseCarVC *vc = [ChooseCarVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        if (indexPath.section == 1) {
            _SelectTag = 60100;
            [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"是",@"否"]] setState:@"100"];
        }
        if (indexPath.section >= 2) {
            _SelectTag = 900 + indexPath.section - 2;
            
            GPSSearchVC *vc = [GPSSearchVC new];
            vc.saleUserId = self.saleUserId;
            CarLoansWeakSelf;
            vc.returnAryBlock = ^(SurveyModel * _Nonnull model) {
             
                [weakSelf.tableView6.gpsAry replaceObjectAtIndex:_SelectTag - 900 withObject:model];
                [weakSelf.tableView6 reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}





//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    
    if (_SelectTag == 10000) {
        _tableView1.saleUserId = Str;
        _saleUserId = saleUserIdAry[sid][@"userId"];
    }
    if (_SelectTag == 10001) {
        _tableView1.loanBankCode = loanBankCodeAry[sid][@"bankName"];
        _loanBankCode = loanBankCodeAry[sid][@"code"];
    }
    if (_SelectTag == 10002) {
        _tableView1.region = Str;
        _tableView6.regAddress = Str;
        _region = regionAry[sid][@"id"];
        [self.tableView1 reloadData];
        [self.tableView6 reloadData];
    }
    if (_SelectTag == 10003) {
        _tableView1.shopCarGarage = Str;
        _shopCarGarage = shopCarGarageAry[sid][@"code"];
    }
    if (_SelectTag == 10004) {
        _tableView1.ascription = Str;
        _ascription = _ascriptionAry[sid][@"id"];
    }
    if (_SelectTag == 10005) {
        _tableView1.bizType = Str;
        _bizType = [NSString stringWithFormat:@"%ld",sid];
        _tableView6.bizType = _bizType;
    }
    
    if (_SelectTag < 20000) {
        [self.tableView1 reloadData];
    }
    
    if (_SelectTag == 30000) {
        _emergencyRelation1 = dic[@"dkey"];
        _tableView3.emergencyRelation1 = _emergencyRelation1;
        [self.tableView3 reloadData];
    }
    if (_SelectTag == 30001) {
        _emergencyRelation2 = dic[@"dkey"];
        _tableView3.emergencyRelation2 = _emergencyRelation2;
        [self.tableView3 reloadData];
    }
    
    
//    贷款信息
    if (_SelectTag == 40001) {
        _periods = dic[@"dkey"];
        _tableView4.periods = _periods;
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632037";
//        http.parameters[@"status"] = @"1";
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            loanBankCodeAry = responseObject[@"data"];
//            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < loanBankCodeAry.count; i ++) {
//
                if ([self.loanBankCode isEqualToString:loanBankCodeAry[i][@"code"]]) {
                    NSDictionary *dict = loanBankCodeAry[i];
                    if([[dict allKeys] containsObject:[NSString stringWithFormat:@"rate%@",dic[@"dkey"]]])
                    {
                        self.bankRate = [dict valueForKey:[NSString stringWithFormat:@"rate%@",dic[@"dkey"]]];
                        self.tableView4.bankRate = [dict valueForKey:[NSString stringWithFormat:@"rate%@",dic[@"dkey"]]];
                        [self.tableView4 reloadData];
                        
                        UITextField *textField = [self.view viewWithTag:40002];
                        textField.text = [BaseModel Cheng100:self.bankRate];
                        
                        self.tableView4.isLoadData = YES;
                        
                    }
                }
            }
        } failure:^(NSError *error) {
            
        }];
         [self.tableView4 reloadData];
    }
    if (_SelectTag == 40005) {
        if ([Str isEqualToString:@"是"]) {
            self.isAdvanceFund = @"1";
        }else
        {
            self.isAdvanceFund = @"0";
        }
        self.tableView4.isAdvanceFund = self.isAdvanceFund;
        [self.tableView4 reloadData];
    }
    if (_SelectTag == 40014) {
        if ([Str isEqualToString:@"传统"]) {
            self.rateType = @"1";
        }else
        {
            self.rateType = @"2";
        }
        self.tableView4.rateType = self.rateType;
        [self.tableView4 reloadData];
    }
    if (_SelectTag == 40016) {
        if ([Str isEqualToString:@"是"]) {
            self.isDiscount = @"1";
        }else
        {
            self.isDiscount = @"0";
        }
        self.tableView4.isDiscount = self.isDiscount;
        [self.tableView4 reloadData];
    }
    
    
    NSInteger row;
    if ([self.bizType isEqualToString:@"1"]) {
        row = 4;
    }else
    {
        row = 0;
    }
    
    
    if (_SelectTag == 60006 + row) {
        _tableView1.region = Str;
        _tableView6.regAddress = Str;
        _region = regionAry[sid][@"id"];
        [self.tableView6 reloadData];
        [self.tableView1 reloadData];
    }
    if (_SelectTag == 60007 + row) {
        if ([Str isEqualToString:@"是"]) {
            self.isPublicCard = @"1";
        }else
        {
            self.isPublicCard = @"0";
        }
        self.tableView6.isPublicCard = self.isPublicCard;
        [self.tableView6 reloadData];
    }
    if (_SelectTag == 60100 ) {
        if ([Str isEqualToString:@"是"]) {
            self.isAzGps = @"1";
        }else
        {
            self.isAzGps = @"0";
            self.tableView6.gpsAry = [NSMutableArray array];
        }
        
        self.tableView6.isAzGps = self.isAzGps;
        [self.tableView6 reloadData];
    }
    if (_SelectTag >= 900 && _SelectTag < 1000) {
        [self.tableView6.gpsAry replaceObjectAtIndex:_SelectTag - 900 withObject:selectGpsAry[sid]];
        [self.tableView6 reloadData];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SurveyModel *dic = [SurveyModel mj_objectWithKeyValues:@{}];
    [self.tableView6.gpsAry addObject:dic];
    [self.tableView6.gpsPhotoAry addObject:@[]];
    [self.tableView6 reloadData];
}


-(void)viewWillAppear:(BOOL)animated
{
//    车型 车系 品牌
    if (self.carcode) {
        [self getcarname:self.carcode];
    }
    
    if ([BaseModel isBlankString:self.model.code] == YES) {
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
//    http.showView = self.view;
    http.isShowMsg = NO;
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        SurveyModel *model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView2.creditUserList = model.creditUserList;
        [self.tableView2 reloadData];
    } failure:^(NSError *error) {
   
    }];
}

-(void)getcarname:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    //    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.tableView6.carBrand = responseObject[@"data"][@"brandName"];
        self.carBrand = responseObject[@"data"][@"brandCode"];
        self.tableView6.carSeries = responseObject[@"data"][@"seriesName"];
        self.carSeries = responseObject[@"data"][@"seriesCode"];
        self.carModel = responseObject[@"data"][@"code"];
        self.tableView6.carModel = responseObject[@"data"][@"name"];
        [self.tableView6 reloadData];
    } failure:^(NSError *error) {

    }];
}



-(void)MenuSelectTag:(NSInteger)tag
{
    if (tag == 100) {
        _menuView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }else
    {
        submitBtn.hidden = YES;
        [_bottomBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        _menuView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
        
        UITableView *tableView = [self.view viewWithTag:tag + 20100];
        [self.view bringSubviewToFront:tableView];
        [tableView reloadData];
        selectTag = tag;
        if (tag == 1) {
            _bottomBtn.hidden = YES;
        }
        else if(tag == 8)
        {
            submitBtn.hidden = NO;
            _bottomBtn.hidden = NO;
            _bottomBtn.frame = CGRectMake((SCREEN_WIDTH - 45)/2 + 30, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
            [_bottomBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        }
        else
        {
            _bottomBtn.hidden = NO;
        }
        self.title = [MenuModel new].menuArray[tag];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本信息";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"目录" forState:(UIControlStateNormal)];
    [self.RightButton SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"目录") forState:(UIControlStateNormal)];
    }];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self initTableView];
    [self.view addSubview:self.menuView];
    [self credit_user_loan_roleLoadData];
    
    
    submitBtn = [UIButton buttonWithTitle:@"保存" titleColor:kAppCustomMainColor backgroundColor:RGB(190, 209, 229) titleFont:16 cornerRadius:2];
    submitBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [submitBtn addTarget:self action:@selector(bottomBtnClick1) forControlEvents:(UIControlEventTouchUpInside)];
    submitBtn.hidden = YES;
    [self.view addSubview:submitBtn];
    
    _bottomBtn = [UIButton buttonWithTitle:@"保存" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottomBtn];
    
    [self detailsLoadData:self.model.code];
    
    if ([BaseModel isBlankString:self.model.code] == YES) {
        [self shopCarGarageLoadData];
    }
    
    
}

-(void)bottomBtnClick1
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632537";
    http.showView = self.view;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.model.code;
    if (self.carHead.count > 0) {
        http.parameters[@"carHead"] = [self.carHead componentsJoinedByString:@"||"];
    }
    if (self.carRegisterCertificateFirst.count > 0) {
        http.parameters[@"carRegisterCertificateFirst"] = [self.carRegisterCertificateFirst componentsJoinedByString:@"||"];
    }
    if (self.policy.count > 0) {
        http.parameters[@"policy"] = [self.policy componentsJoinedByString:@"||"];
    }
    if (self.carInvoice.count > 0) {
        http.parameters[@"carInvoice"] = [self.carInvoice componentsJoinedByString:@"||"];
    }
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"保存成功"];
    } failure:^(NSError *error) {
    }];
}

-(void)rightButtonClick
{
    if ([BaseModel isBlankString:self.model.code] == YES) {
        [TLAlert alertWithInfo:@"请先完善基本信息并保存"];
        return;
    }
    _menuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view bringSubviewToFront:_menuView];
}

//详情接口
-(void)detailsLoadData:(NSString *)code;
{
    if ([BaseModel isBlankString:code] == YES) {
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = code;
    [http postWithSuccess:^(id responseObject) {
        
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView2.creditUserList = self.model.creditUserList;
        [self.tableView2 reloadData];
        
        self.saleUserId = [BaseModel convertNull:self.model.saleUserId];
        self.tableView1.saleUserId = [BaseModel convertNull:self.model.saleUserName];
        self.loanBankCode = [BaseModel convertNull:self.model.loanBank];
        self.tableView1.ascription = [BaseModel convertNull:self.model.ascriptionName];
        self.ascription = [BaseModel convertNull:self.model.ascription];
        self.tableView1.loanBankCode = [BaseModel convertNull:self.model.loanBankName];
        
        self.region = [BaseModel convertNull:self.model.region];
        self.tableView1.region = [BaseModel convertNull:self.model.regionName];
        self.shopCarGarage = [BaseModel convertNull:self.model.carInfo[@"shopCarGarage"]];
        self.tableView1.shopCarGarage = [BaseModel convertNull:self.model.carInfo[@"shopCarGarageName"]];
        
        self.bizType = [BaseModel convertNull:self.model.bizType];
        
        self.tableView1.bizType = self.bizType;
        if ([self.model.bizType isEqualToString:@"0"]) {
            self.tableView1.bizType = @"新车";
        }else if([self.model.bizType isEqualToString:@"1"])
        {
            self.tableView1.bizType = @"二手车";
        }
        
        self.tableView1.cardPostAddress = self.model.creditUser[@"cardPostAddress"];
        _cardPostAddress = self.model.creditUser[@"cardPostAddress"];
        
        [self.tableView1 reloadData];
        
        self.tableView2.creditUserList = self.model.creditUserList;
        [self.tableView2 reloadData];
        
        
        
        for (int i = 0; i < self.model.creditUserList.count; i ++) {
            if ([@"1" isEqualToString:self.model.creditUserList[i][@"loanRole"]]) {
                NSDictionary *creditUser = self.model.creditUserList[i];
                self.emergencyName1 = creditUser[@"emergencyName1"];
                self.emergencyRelation1 = creditUser[@"emergencyRelation1"];
                self.emergencyMobile1 = creditUser[@"emergencyMobile1"];
                self.emergencyName2 = creditUser[@"emergencyName2"];
                self.emergencyRelation2 = creditUser[@"emergencyRelation2"];
                self.emergencyMobile2 = creditUser[@"emergencyMobile2"];
                self.tableView3.emergencyName1 = creditUser[@"emergencyName1"];
                self.tableView3.emergencyRelation1 = creditUser[@"emergencyRelation1"];
                self.tableView3.emergencyMobile1 = creditUser[@"emergencyMobile1"];
                self.tableView3.emergencyName2 = creditUser[@"emergencyName2"];
                self.tableView3.emergencyRelation2 = creditUser[@"emergencyRelation2"];
                self.tableView3.emergencyMobile2 = creditUser[@"emergencyMobile2"];
                [self.tableView3 reloadData];
            }
        }
        self.tableView4.model = self.model;
        
        NSDictionary *bankLoan = self.model.bankLoan;
        self.periods = bankLoan[@"periods"];
        self.tableView4.periods = self.periods;
        self.bankRate = bankLoan[@"bankRate"];
        self.tableView4.bankRate = self.bankRate;
        self.rateType = bankLoan[@"rateType"];
        self.tableView4.rateType = self.rateType;
        self.isAdvanceFund = bankLoan[@"isAdvanceFund"];
        self.tableView4.isAdvanceFund = self.isAdvanceFund;
        self.isDiscount = bankLoan[@"isDiscount"];
        self.tableView4.isDiscount = self.isDiscount;
        self.wanFactor = bankLoan[@"wanFactor"];
        self.tableView4.wanFactor = bankLoan[@"wanFactor"];
        [self.tableView4 reloadData];
        
        self.tableView5.model = self.model;
        [self.tableView5 reloadData];
        
        self.region = [BaseModel convertNull:self.model.carInfo[@"regAddress"]];
        
        self.tableView6.regAddress = self.model.carInfo[@"regAddressName"];
        self.tableView6.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
        
        
        
        self.driveLicense = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_license"] componentsSeparatedByString:@"||"];
        self.tableView6.driveLicense = self.driveLicense;
        
        self.region = [BaseModel convertNull:self.model.region];
        self.tableView6.regAddress = [BaseModel convertNull:self.model.regionName];
        
        self.isAzGps = [BaseModel convertNull:self.model.carInfo[@"isAzGps"]];
        self.tableView6.isAzGps = self.isAzGps;
        
        if ([BaseModel isBlankString:self.model.carInfo[@"isPublicCard"]] == YES) {
            self.isPublicCard = @"0";
            self.tableView6.isPublicCard = self.isPublicCard;
        }else
        {
            self.isPublicCard = [BaseModel convertNull:self.model.carInfo[@"isPublicCard"]];
            self.tableView6.isPublicCard = self.isPublicCard;
        }
        
        
        self.tableView6.model = self.model;
        
        self.carBrand = [BaseModel convertNull:self.model.carInfo[@"carBrand"]];
        self.tableView6.carBrand = [BaseModel convertNull:self.model.carInfo[@"carBrandName"]];
        self.carSeries = [BaseModel convertNull:self.model.carInfo[@"carSeries"]];
        self.tableView6.carSeries = [BaseModel convertNull:self.model.carInfo[@"carSeriesName"]];
        self.carModel = [BaseModel convertNull:self.model.carInfo[@"carModel"]];
        self.tableView6.carModel = [BaseModel convertNull:self.model.carInfo[@"carModelName"]];
        self.tableView6.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
        self.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
        self.tableView6.mile = [BaseModel convertNull:self.model.carInfo[@"mile"]];
        self.mile = [BaseModel convertNull:self.model.carInfo[@"mile"]];
        
        self.tableView6.bizType = self.bizType;
        
        self.tableView6.secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
        self.secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
        
        [self.tableView6 reloadData];
        
        
        
        self.marryPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"marry_pdf"];
        self.divorcePdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"divorce_pdf"];
        self.singleProve = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"single_prove"];
        self.incomeProve = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"income_prove"];
        self.liveProvePdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"live_prove_pdf"];
        
        
        
        self.housePropertyCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"single_prove"];
        
        self.driveCard = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_card"] componentsSeparatedByString:@"||"];
        
        self.hkBookFirstPage = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hk_book_first_page"] componentsSeparatedByString:@"||"];
        self.bankJourFirstPage = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"bank_jour_first_page"] componentsSeparatedByString:@"||"];
        self.zfbJour = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"zfb_jour"] componentsSeparatedByString:@"||"];
        self.wxJour = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"wx_jour"] componentsSeparatedByString:@"||"];
        self.otherPdf = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"other_pdf"] componentsSeparatedByString:@"||"];
        self.contractAwardVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"contract_award_video"] componentsSeparatedByString:@"||"];
        
        if (self.model.gpsAzList.count > 0) {
            for (int i = 0; i < self.model.gpsAzList.count; i ++) {
                
                SurveyModel *model = [SurveyModel mj_objectWithKeyValues:self.model.gpsAzList[i]];
                
                [self.tableView6.gpsAry addObject:model];
                [self.tableView6.gpsPhotoAry addObject:[self.model.gpsAzList[i][@"azPhotos"] componentsSeparatedByString:@"||"]];
            }
        }
        
        
        
        [self.tableView6 reloadData];
        self.tableView7.driveCard = _driveCard;
        self.tableView7.marryPdf = _marryPdf;
        self.tableView7.divorcePdf = _divorcePdf;
        self.tableView7.singleProve = _singleProve;
        self.tableView7.incomeProve = _incomeProve;
        self.tableView7.liveProvePdf = _liveProvePdf;
        self.tableView7.housePropertyCardPdf = _housePropertyCardPdf;
        self.tableView7.hkBookFirstPage = _hkBookFirstPage;
        self.tableView7.bankJourFirstPage = _bankJourFirstPage;
        self.tableView7.zfbJour = self.zfbJour;
        self.tableView7.wxJour = self.wxJour;
        self.tableView7.otherPdf = self.otherPdf;
        self.tableView7.contractAwardVideo = self.contractAwardVideo;
        [self.tableView7 reloadData];
        
        self.doorPdf = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"door_photo"] componentsSeparatedByString:@"||"];
        self.tableView8.doorPdf = self.doorPdf;
        self.groupPhoto = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"group_photo"] componentsSeparatedByString:@"||"];
        self.tableView8.groupPhoto = self.groupPhoto;
        self.houseVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"house_video"] componentsSeparatedByString:@"||"];
        self.tableView8.houseVideo = self.houseVideo;
        self.companyVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"company_video"] componentsSeparatedByString:@"||"];
        self.tableView8.companyVideo = self.companyVideo;
        [self.tableView8 reloadData];
        
        self.carHead = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_head"] componentsSeparatedByString:@"||"];
        self.tableView9.carHead = self.carHead;
        self.carRegisterCertificateFirst = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_register_certificate_first"] componentsSeparatedByString:@"||"];
        self.tableView9.carRegisterCertificateFirst = self.carRegisterCertificateFirst;
        
        self.carInvoice = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_invoice"] componentsSeparatedByString:@"||"];
        self.tableView9.carInvoice = self.carInvoice;
        
        self.policy = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"policy"] componentsSeparatedByString:@"||"];
        self.tableView9.policy = self.policy;
        
        [self.tableView9 reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)credit_user_loan_roleLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.showView = self.view;
    http.parameters[@"parentKey"] = @"credit_user_loan_role";
    [http postWithSuccess:^(id responseObject) {
        _credit_user_loan_roleArray = responseObject[@"data"];
        self.tableView2.credit_user_loan_roleArray = _credit_user_loan_roleArray;
        [self.tableView2 reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"评估报告"]) {
        UITextField *text = [self.view viewWithTag:6001];
        
        if ([BaseModel isBlankString:self.region] == YES) {
            [TLAlert alertWithInfo:@"请选择业务发生地"];
            return;
        }
        if ([BaseModel isBlankString:self.carModel] == YES) {
            [TLAlert alertWithInfo:@"请选择车型"];
            return;
        }
        if ([BaseModel isBlankString:self.regDate] == YES) {
            [TLAlert alertWithInfo:@"请输入上牌时间"];
            return;
        }
        if ([text.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入公里数"];
            return;
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"630479";
        http.parameters[@"zone"] = self.region;
        http.parameters[@"regDate"] = self.regDate;
        http.parameters[@"mile"] = text.text;
        http.parameters[@"modelId"] = self.carModel;
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            
            self.secondCarReport = responseObject[@"data"][@"url"];
            self.tableView6.secondCarReport = responseObject[@"data"][@"url"];
            [self.tableView6 reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
    if ([state isEqualToString:@"clear"]) {
        
        
        [TLAlert alertWithTitle:@"提示" msg:[NSString stringWithFormat:@"是否清除%@信息",self.credit_user_loan_roleArray[index][@"dvalue"]] confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            
            NSMutableArray *creditUserList = [NSMutableArray array];
            for (int i = 0; i < self.model.creditUserList.count; i ++) {
                if (![self.model.creditUserList[i][@"loanRole"] isEqualToString:self.credit_user_loan_roleArray[index][@"dkey"]]) {
                    [creditUserList addObject:self.model.creditUserList[i]];
                }
            }
            
            TLNetworking * http1 = [[TLNetworking alloc]init];
            http1.code = @"632530";
            http1.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
            http1.parameters[@"code"] = self.model.code;
            http1.parameters[@"type"] = @"ios";
            http1.showView = self.view;
            
            
            http1.parameters[@"creditUserList"] = creditUserList;
            [http1 postWithSuccess:^(id responseObject) {
                
                [self detailsLoadData:self.model.code];
                
            } failure:^(NSError *error) {
                
            }];
            
        }];
        
        
    }
}

- (BOOL) isValidPhone:(NSString*)str{
    
    //新匹配166，199，198开头手机号码
    
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(((13[0-9])|(14[579])|(15([0-3]|[5-9]))|(16[6])|(17[0135678])|(18[0-9])|(19[89]))\\d{8})$" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    
    
    
    
    if (result) {
        
        return YES;
        
    }
    
    return NO;
    
}

-(void)bottomBtnClick
{
    NSString *name;
    if (selectTag == 0) {
        if ([self.bizType isEqualToString:@"1"]) {
            for (int i = 0; i < [MenuModel new].menuSecondgHandArray1.count; i ++) {
                name = [self WarningContent:[MenuModel new].menuSecondgHandArray1[i] CurrentTag:10000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }else
        {
            for (int i = 0; i < [MenuModel new].menuArray1.count; i ++) {
                name = [self WarningContent:[MenuModel new].menuArray1[i] CurrentTag:10000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632538";
        if ([BaseModel isBlankString:_model.code] == NO) {
            http.parameters[@"code"] = _model.code;
        }
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"loanBankCode"] = self.loanBankCode;
        http.parameters[@"region"] = self.region;
        http.parameters[@"bizType"] = self.bizType;
        http.parameters[@"regDate"] = self.regDate;
        http.parameters[@"ascription"] = self.ascription;
        
        http.parameters[@"shopCarGarage"] = self.shopCarGarage;
        http.parameters[@"saleUserId"] = self.saleUserId;
        http.parameters[@"cardPostAddress"] = self.cardPostAddress;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self detailsLoadData:responseObject[@"data"]];
            });
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (selectTag == 2) {
        UITextField *tf1 = [self.view viewWithTag:3000];
        UITextField *tf2 = [self.view viewWithTag:3001];
        UITextField *tf3 = [self.view viewWithTag:3002];
        UITextField *tf4 = [self.view viewWithTag:3003];
        if ([tf1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入紧急联系人1的姓名"];
            return;
        }
        if ([BaseModel isBlankString:_emergencyRelation1] == YES) {
            [TLAlert alertWithInfo:@"请选择与紧急联系人1的关系"];
            return;
        }
        if ([tf2.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入紧急联系人1的手机号"];
            return;
        }
        if ([self isValidPhone:tf2.text] == NO) {
            [TLAlert alertWithInfo:@"紧急联系人1手机号格式错误"];
            return;
        }
        if ([tf3.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入紧急联系人2的姓名"];
            return;
        }
        if ([BaseModel isBlankString:_emergencyRelation2] == YES) {
            [TLAlert alertWithInfo:@"请选择与紧急联系人2的关系"];
            return;
        }
        if ([tf4.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入紧急联系人2的手机号"];
            return;
        }
        if ([self isValidPhone:tf4.text] == NO) {
            [TLAlert alertWithInfo:@"紧急联系人2手机号格式错误"];
            return;
        }
        TLNetworking *http = [TLNetworking new];
        http.code = @"632531";
        http.showView = self.view;
        NSDictionary *creditUserList = @{@"loanRole":@"1",
                                         @"emergencyName1":tf1.text,
                                         @"emergencyRelation1":[BaseModel convertNull:_emergencyRelation1],
                                         @"emergencyMobile1":tf2.text,
                                         @"emergencyName2":tf3.text,
                                         @"emergencyRelation2":[BaseModel convertNull:_emergencyRelation2],
                                         @"emergencyMobile2":tf4.text
                                         };
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"creditUserList"] = @[creditUserList];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
        } failure:^(NSError *error) {
            
        }];
    }
    
    if (selectTag == 3) {
        
        for (int i = 0; i < [MenuModel new].menuArray4.count; i ++) {
            name = [self WarningContent:[MenuModel new].menuArray4[i] CurrentTag:4000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        UITextField *tf0 = [self.view viewWithTag:4000];
        UITextField *tf2 = [self.view viewWithTag:4002];
        UITextField *tf3 = [self.view viewWithTag:4003];
        UITextField *tf4 = [self.view viewWithTag:4004];
        UITextField *tf6 = [self.view viewWithTag:4006];
        UITextField *tf7 = [self.view viewWithTag:4007];
        UITextField *tf8 = [self.view viewWithTag:4008];
        UITextField *tf9 = [self.view viewWithTag:4009];
        UITextField *tf10 = [self.view viewWithTag:4010];
        UITextField *tf11 = [self.view viewWithTag:4011];
        UITextField *tf12 = [self.view viewWithTag:4012];
        UITextField *tf13 = [self.view viewWithTag:4013];
        UITextField *tf15 = [self.view viewWithTag:4015];
        UITextField *tf17 = [self.view viewWithTag:4017];
        UITextField *tf18 = [self.view viewWithTag:4018];
        UITextField *tf19 = [self.view viewWithTag:4019];
        UITextField *tf20 = [self.view viewWithTag:4020];
        UITextField *tf21 = [self.view viewWithTag:4021];
        UITextField *tf22 = [self.view viewWithTag:4022];
        
        UITextField *tf23 = [self.view viewWithTag:4023];
        UITextField *tf24 = [self.view viewWithTag:4024];
        UITextField *tf25 = [self.view viewWithTag:4025];
        UITextField *tf26 = [self.view viewWithTag:4026];
        UITextField *tf28 = [self.view viewWithTag:4028];
        UITextField *tf29 = [self.view viewWithTag:4029];
        UITextField *tf30 = [self.view viewWithTag:4030];
        UITextField *tf31 = [self.view viewWithTag:4031];
        TLNetworking *http = [TLNetworking new];
        http.code = @"632532";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"loanAmount"] = [BaseModel Cheng1000:tf0.text];
        if ([self.periods integerValue] > 0) {
            http.parameters[@"periods"] = self.periods;
        }
        http.parameters[@"bankRate"] = [BaseModel Chu100:tf2.text];
        http.parameters[@"totalRate"] = [BaseModel Chu100:tf3.text];
        http.parameters[@"rebateRate"] = [BaseModel Chu100:tf4.text];
        http.parameters[@"isAdvanceFund"] = [BaseModel convertNull:self.isAdvanceFund];
        http.parameters[@"monthAmount"] = [BaseModel Cheng1000:tf6.text];
        http.parameters[@"repayFirstMonthAmount"] = [BaseModel Cheng1000:tf7.text];
        http.parameters[@"openCardAmount"] = [BaseModel Cheng1000:tf8.text];
//        贴息利率
        http.parameters[@"discountRate"] = [BaseModel Chu100:tf9.text];
//        贴息金额
        http.parameters[@"discountAmount"] = [BaseModel Cheng1000:tf10.text];
        http.parameters[@"invoicePrice"] = [BaseModel Cheng1000:tf11.text];
        http.parameters[@"loanRatio"] = tf12.text;
        http.parameters[@"wanFactor"] = [BaseModel convertNull:tf13.text];
        http.parameters[@"rateType"] = [BaseModel convertNull:self.rateType];
        http.parameters[@"fee"] = [BaseModel Cheng1000:tf15.text];
        http.parameters[@"isDiscount"] = [BaseModel convertNull:self.isDiscount];
        http.parameters[@"highCashAmount"] = [BaseModel Cheng1000:tf17.text];
        http.parameters[@"totalFee"] = [BaseModel Cheng1000:tf18.text];
        http.parameters[@"customerBearRate"] = [BaseModel Chu100:tf19.text];
        http.parameters[@"surchargeRate"] = [BaseModel Chu100:tf20.text];
        http.parameters[@"surchargeAmount"] = [BaseModel Cheng1000:tf21.text];
        http.parameters[@"notes"] = tf22.text;
        
        http.parameters[@"gpsFee"] = [BaseModel Cheng1000:tf23.text];
        http.parameters[@"fxAmount"] = [BaseModel Cheng1000:tf24.text];
        http.parameters[@"lyDeposit"] = [BaseModel Cheng1000:tf25.text];
        http.parameters[@"otherFee"] = [BaseModel Cheng1000:tf26.text];
        
        http.parameters[@"repointAmount"] = [BaseModel Cheng1000:tf28.text];
        http.parameters[@"carFunds3"] = [BaseModel Cheng1000:tf29.text];
        http.parameters[@"carFunds4"] = [BaseModel Cheng1000:tf30.text];
        http.parameters[@"carFunds5"] = [BaseModel Cheng1000:tf31.text];
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self detailsLoadData:self.model.code];
            });
        } failure:^(NSError *error) {
            
        }];
        
    }
    
    if (selectTag == 4) {
        UITextField *tf0 = [self.view viewWithTag:5000];
        UITextField *tf1 = [self.view viewWithTag:5001];
        UITextField *tf2 = [self.view viewWithTag:5002];
        UITextField *tf3 = [self.view viewWithTag:5003];
        UITextField *tf4 = [self.view viewWithTag:5004];
        UITextField *tf5 = [self.view viewWithTag:5005];
        UITextField *tf6 = [self.view viewWithTag:5006];
        UITextField *tf7 = [self.view viewWithTag:5007];
        UITextField *tf8 = [self.view viewWithTag:5008];
        if ([tf0.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入GPS费"];
            return;
        }
        TLNetworking *http = [TLNetworking new];
        http.code = @"632533";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"gpsFee"] = [BaseModel Cheng1000:tf0.text];
        http.parameters[@"fxAmount"] = [BaseModel Cheng1000:tf1.text];
        http.parameters[@"lyDeposit"] = [BaseModel Cheng1000:tf2.text];
        http.parameters[@"otherFee"] = [BaseModel Cheng1000:tf3.text];
        
        http.parameters[@"repointAmount"] = [BaseModel Cheng1000:tf5.text];
        http.parameters[@"carFunds3"] = [BaseModel Cheng1000:tf6.text];
        http.parameters[@"carFunds4"] = [BaseModel Cheng1000:tf7.text];
        http.parameters[@"carFunds5"] = [BaseModel Cheng1000:tf8.text];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
        } failure:^(NSError *error) {
            
        }];
    }
    if (selectTag == 5) {
        
        
        if ([self.bizType isEqualToString:@"1"]) {
            for (int i = 0; i < [MenuModel new].usedCarMenuArray6.count; i ++) {
                name = [self WarningContent:[MenuModel new].usedCarMenuArray6[i] CurrentTag:6000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }else
        {
            for (int i = 0; i < [MenuModel new].menuArray6.count; i ++) {
                name = [self WarningContent:[MenuModel new].menuArray6[i] CurrentTag:6000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }
        
        
        
        UITextField *tf0 = [self.view viewWithTag:6000];
        UITextField *tf1 = [self.view viewWithTag:6001];
        UITextField *tf2 = [self.view viewWithTag:6002];
        UITextField *tf3 = [self.view viewWithTag:6003];
        UITextField *tf4 = [self.view viewWithTag:6004];
        UITextField *tf5 = [self.view viewWithTag:6005];
        UITextField *tf6 = [self.view viewWithTag:6006];
        UITextField *tf7 = [self.view viewWithTag:6007];
        UITextField *tf8 = [self.view viewWithTag:6008];
        UITextField *tf9 = [self.view viewWithTag:6009];
        UITextField *tf10 = [self.view viewWithTag:6010];
        
        TLNetworking *http = [TLNetworking new];
        http.code = @"632534";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        
        if ([self.model.bizType isEqualToString:@"1"]) {
            
            http.parameters[@"regDate"] = tf0.text;
            http.parameters[@"mile"] = tf1.text;
            http.parameters[@"driveLicense"] = [self.driveLicense componentsJoinedByString:@"||"];
            http.parameters[@"secondCarReport"] = self.secondCarReport;
            
            
            http.parameters[@"model"] = tf4.text;
            http.parameters[@"carPrice"] = [BaseModel Cheng1000:tf5.text];
            http.parameters[@"carFrameNo"] = tf6.text;
            http.parameters[@"carEngineNo"] = tf7.text;
            http.parameters[@"carNumber"] = tf8.text;
            http.parameters[@"evalPrice"] = [BaseModel Cheng1000:tf9.text];
            http.parameters[@"isAzGps"] = self.isAzGps;
            http.parameters[@"isPublicCard"] = self.isPublicCard;
            http.parameters[@"region"] = self.region;
        }
        else
        {
            http.parameters[@"model"] = tf0.text;
            http.parameters[@"carPrice"] = [BaseModel Cheng1000:tf1.text];
            http.parameters[@"carFrameNo"] = tf2.text;
            http.parameters[@"carEngineNo"] = tf3.text;
            http.parameters[@"carNumber"] = tf4.text;
            http.parameters[@"evalPrice"] = [BaseModel Cheng1000:tf5.text];
            http.parameters[@"isAzGps"] = self.isAzGps;
            http.parameters[@"isPublicCard"] = self.isPublicCard;
            http.parameters[@"region"] = self.region;
        }
        
        
        
        
        
        http.parameters[@"carBrand"] = self.carBrand;
        http.parameters[@"carSeries"] = self.carSeries;
        http.parameters[@"carModel"] = self.carModel;
        
        
        [http postWithSuccess:^(id responseObject) {
            
            
            if ([self.isAzGps isEqualToString:@"1"]) {
                NSMutableArray *ary = [NSMutableArray array];
                for (int i = 0 ; i < self.tableView6.gpsAry.count; i ++) {
                    NSDictionary *dic;
                    if ([BaseModel isBlankString:self.tableView6.gpsAry[i].code] == YES) {
                        [TLAlert alertWithInfo:@"请输入GPS号"];
                        return;
                    }else
                    {
                        NSArray *array = self.tableView6.gpsPhotoAry[i];
                        if (array.count == 0) {
                            [TLAlert alertWithInfo:@"请上传GPS图片"];
                            return;
                        }else
                        {
                            dic = @{@"code":self.tableView6.gpsAry[i].code,
                                    @"azPhotos":[array componentsJoinedByString:@"||"]
                                    };
                            [ary addObject:dic];
                        }
                    }
                }
                TLNetworking *http1 = [TLNetworking new];
                http1.code = @"632126";
                http1.showView = self.view;
                http1.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
                http1.parameters[@"code"] = self.model.code;
                http1.parameters[@"gpsAzList"] = ary;
                [http1 postWithSuccess:^(id responseObject) {
                    [TLAlert alertWithSucces:@"保存成功"];
                } failure:^(NSError *error) {
                    
                }];
                
            }else
            {
                [TLAlert alertWithSucces:@"保存成功"];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    if (selectTag == 6) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632535";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        
        http.parameters[@"marryPdf"] = self.marryPdf;
        http.parameters[@"divorcePdf"] = self.divorcePdf;
        http.parameters[@"singleProve"] = self.singleProve;
        http.parameters[@"incomeProve"] = self.incomeProve;
        http.parameters[@"housePropertyCardPdf"] = self.housePropertyCardPdf;
        http.parameters[@"liveProvePdf"] = self.liveProvePdf;
        if (self.driveCard.count > 0) {
            http.parameters[@"driveCard"] = [self.driveCard componentsJoinedByString:@"||"];
        }
        if (self.hkBookFirstPage.count > 0) {
            http.parameters[@"hkBookFirstPage"] = [self.hkBookFirstPage componentsJoinedByString:@"||"];
        }
        if (self.bankJourFirstPage.count > 0) {
            http.parameters[@"bankJourFirstPage"] = [self.bankJourFirstPage componentsJoinedByString:@"||"];
        }
        if (self.zfbJour.count > 0) {
            http.parameters[@"zfbJour"] = [self.zfbJour componentsJoinedByString:@"||"];
        }
        if (self.wxJour.count > 0) {
            http.parameters[@"wxJour"] = [self.wxJour componentsJoinedByString:@"||"];
        }
        if (self.otherPdf.count > 0) {
            http.parameters[@"otherPdf"] = [self.otherPdf componentsJoinedByString:@"||"];
        }
        if (self.contractAwardVideo.count > 0) {
            http.parameters[@"contractAwardVideo"] = [self.contractAwardVideo componentsJoinedByString:@"||"];
        }
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
        } failure:^(NSError *error) {
            
        }];
    }
    if (selectTag == 7) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632536";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        if (self.doorPdf.count > 0) {
            http.parameters[@"doorPdf"] = [self.doorPdf componentsJoinedByString:@"||"];
        }
        if (self.groupPhoto.count > 0) {
            http.parameters[@"groupPhoto"] = [self.groupPhoto componentsJoinedByString:@"||"];
        }
        if (self.houseVideo.count) {
            http.parameters[@"houseVideo"] = [self.houseVideo componentsJoinedByString:@"||"];
        }
        if (self.companyVideo.count) {
            http.parameters[@"companyVideo"] = [self.companyVideo componentsJoinedByString:@"||"];
        }
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
        } failure:^(NSError *error) {
            
        }];
    }
    
    if (selectTag == 8) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632539";
        http.showView = self.view;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"code"] = self.model.code;
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            
        }];
    }
}


-(NSString *)WarningContent:(NSString *)name CurrentTag:(NSInteger)tag
{
    UILabel *label = [self.view viewWithTag:tag];
    NSString *str = [name stringByReplacingOccurrencesOfString:@"*" withString:@""];
    if (![name hasPrefix:@"*"]) {
        return @"";
    }else if([label.text isEqualToString:@""]) {
        return [NSString stringWithFormat:@"请录入%@",str];
    }else{
        return @"";
    }
}


@end
