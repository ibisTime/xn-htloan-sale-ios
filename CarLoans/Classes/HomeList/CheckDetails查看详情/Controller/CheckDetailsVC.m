//
//  CheckDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckDetailsVC.h"
#import "DetailsMenuView.h"
#import "DetailsMenuTableView1.h"
#import "DetailsMenuTableView2.h"
#import "MenuTableView3.h"
#import "MenuTableView4.h"
#import "MenuTableView5.h"
#import "MenuTableView6.h"
#import "MenuTableView7.h"
#import "MenuTableView8.h"
#import "MenuTableView9.h"
#import "WebVC.h"
#import "DetailsMenuTableView10.h"
#import "DetailsMenuTableView11.h"
#import "DetailsMenuTableView12.h"
#import "DetailsMenuTableView13.h"
#import "DetailsMenuTableView14.h"
#import "DetailsMenuTableView15.h"
#import "NewLenderVC.h"
#import "RepaymentPlanHeadView.h"
#import "ImageBrowsingVC.h"
@interface CheckDetailsVC ()<MenuDelegate,RefreshDelegate>
{
    NSInteger selectTag;
}

@property (nonatomic , strong)DetailsMenuView *menuView;
@property (nonatomic , strong)DetailsMenuTableView1 *tableView1;
@property (nonatomic , strong)DetailsMenuTableView2 *tableView2;
@property (nonatomic , strong)MenuTableView3 *tableView3;
@property (nonatomic , strong)MenuTableView4 *tableView4;
@property (nonatomic , strong)MenuTableView5 *tableView5;
@property (nonatomic , strong)MenuTableView6 *tableView6;
@property (nonatomic , strong)MenuTableView7 *tableView7;
@property (nonatomic , strong)MenuTableView8 *tableView8;
@property (nonatomic , strong)MenuTableView9 *tableView9;
@property (nonatomic , strong)DetailsMenuTableView10 *tableView10;
@property (nonatomic , strong)DetailsMenuTableView11 *tableView11;
@property (nonatomic , strong)DetailsMenuTableView12 *tableView12;
@property (nonatomic , strong)DetailsMenuTableView13 *tableView13;
@property (nonatomic , strong)DetailsMenuTableView14 *tableView14;
@property (nonatomic , strong)DetailsMenuTableView15 *tableView15;
@property (nonatomic , strong)RepaymentPlanHeadView *headView;

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


@property (nonatomic , strong)NSArray *doorPdf;
@property (nonatomic , strong)NSArray *groupPhoto;
@property (nonatomic , strong)NSArray *houseVideo;

//车辆图
@property (nonatomic , strong)NSArray *carHead;
@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;


@property (nonatomic , strong)NSMutableArray <SurveyModel *>*gpsAry;
//@property (nonatomic , strong)NSString *regDate;
@property (nonatomic , strong)NSString *isAzGps;
@property (nonatomic , strong)NSString *regAddress;
@property (nonatomic , strong)NSString *isPublicCard;

@end

@implementation CheckDetailsVC

-(DetailsMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[DetailsMenuView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _menuView.delegate = self;
    }
    return _menuView;
}

-(RepaymentPlanHeadView *)headView
{
    if (!_headView) {
        _headView = [[RepaymentPlanHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        
    }
    return _headView;
}

-(void)initTableView
{
    self.tableView1 = [[DetailsMenuTableView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView1.refreshDelegate = self;
    self.tableView1.backgroundColor = kWhiteColor;
    self.tableView1.tag = 20100;
    [self.view addSubview:self.tableView1];
    
    self.tableView2 = [[DetailsMenuTableView2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView2.refreshDelegate = self;
    self.tableView2.backgroundColor = kWhiteColor;
    self.tableView2.tag = 20101;
    self.tableView2.isDetails = YES;
    [self.view addSubview:self.tableView2];
    
    self.tableView3 = [[MenuTableView3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView3.refreshDelegate = self;
    self.tableView3.backgroundColor = kWhiteColor;
    self.tableView3.tag = 20102;
    self.tableView3.isDetails = YES;
    [self.view addSubview:self.tableView3];
    
    
    self.tableView4 = [[MenuTableView4 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView4.refreshDelegate = self;
    self.tableView4.backgroundColor = kWhiteColor;
    self.tableView4.tag = 20103;
    self.tableView4.isDetails = YES;
    [self.view addSubview:self.tableView4];
    
    
    self.tableView5 = [[MenuTableView5 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView5.refreshDelegate = self;
    self.tableView5.backgroundColor = kWhiteColor;
    self.tableView5.tag = 20104;
    self.tableView5.isDetails = YES;
    [self.view addSubview:self.tableView5];
    
    
    self.tableView6 = [[MenuTableView6 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView6.refreshDelegate = self;
    self.tableView6.backgroundColor = kWhiteColor;
    self.tableView6.tag = 20105;
    self.tableView6.isDetails = YES;
    [self.view addSubview:self.tableView6];
    
    
    self.tableView7 = [[MenuTableView7 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView7.refreshDelegate = self;
    self.tableView7.backgroundColor = kWhiteColor;
    self.tableView7.tag = 20106;
    self.tableView7.isDetails = YES;
    [self.view addSubview:self.tableView7];
    
    self.tableView8 = [[MenuTableView8 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView8.refreshDelegate = self;
    self.tableView8.backgroundColor = kWhiteColor;
    self.tableView8.tag = 20107;
    self.tableView8.isDetails = YES;
    [self.view addSubview:self.tableView8];
    
    
    self.tableView9 = [[MenuTableView9 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView9.refreshDelegate = self;
    self.tableView9.backgroundColor = kWhiteColor;
    self.tableView9.tag = 20108;
    self.tableView9.isDetails = YES;
    [self.view addSubview:self.tableView9];
    
    self.tableView10 = [[DetailsMenuTableView10 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView10.refreshDelegate = self;
    self.tableView10.backgroundColor = kWhiteColor;
    self.tableView10.tag = 20109;
    [self.view addSubview:self.tableView10];

    self.tableView11 = [[DetailsMenuTableView11 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView11.refreshDelegate = self;
    self.tableView11.backgroundColor = kWhiteColor;
    self.tableView11.tag = 20110;
    [self.view addSubview:self.tableView11];
    
    
    self.tableView12 = [[DetailsMenuTableView12 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView12.refreshDelegate = self;
    self.tableView12.backgroundColor = kWhiteColor;
    self.tableView12.tag = 20111;
    [self.view addSubview:self.tableView12];
    
    self.tableView13 = [[DetailsMenuTableView13 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView13.refreshDelegate = self;
    self.tableView13.backgroundColor = kWhiteColor;
    self.tableView13.tag = 20112;
    [self.view addSubview:self.tableView13];

    
    self.tableView14 = [[DetailsMenuTableView14 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView14.refreshDelegate = self;
    self.tableView14.backgroundColor = kWhiteColor;
    self.tableView14.tag = 20113;
    [self.view addSubview:self.tableView14];
 
    
    self.tableView15 = [[DetailsMenuTableView15 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10000) style:(UITableViewStyleGrouped)];
    self.tableView15.refreshDelegate = self;
    self.tableView15.backgroundColor = kWhiteColor;
    self.tableView15.tag = 20114;
    [self.view addSubview:self.tableView15];
    self.tableView15.tableHeaderView = self.headView;
 
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
    
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView1.model = self.model;
        self.tableView1.saleUserId = [BaseModel convertNull:self.model.saleUserName];
        self.tableView1.loanBankCode = [BaseModel convertNull:self.model.loanBankName];
        self.tableView1.region = [BaseModel convertNull:self.model.regionName];
        self.tableView1.shopCarGarage = [BaseModel convertNull:self.model.carInfo[@"shopCarGarageName"]];
        self.tableView1.ascription = self.model.ascriptionName;
        if ([self.model.bizType isEqualToString:@"0"]) {
            self.tableView1.bizType = @"新车";
        }else if([self.model.bizType isEqualToString:@"1"])
        {
            self.tableView1.bizType = @"二手车";
        }
//        self.tableView1.carBrand = [BaseModel convertNull:self.model.carInfo[@"carBrandName"]];
//        self.tableView1.carSeries = [BaseModel convertNull:self.model.carInfo[@"carSeriesName"]];
//        self.tableView1.carModel = [BaseModel convertNull:self.model.carInfo[@"carModelName"]];
//        self.tableView1.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
//        self.tableView1.mile = [BaseModel convertNull:self.model.carInfo[@"mile"]];
//        self.tableView1.secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
        [self.tableView1 reloadData];
        
        
        self.tableView2.model = self.model;
        self.tableView2.creditUserList = self.model.creditUserList;
        [self.tableView2 reloadData];
        
        
//        self.tableView3.model = self.model;
        
        for (int i = 0; i < self.model.creditUserList.count; i ++) {
            if ([@"1" isEqualToString:self.model.creditUserList[i][@"loanRole"]]) {
                NSDictionary *creditUser = self.model.creditUserList[i];
                self.tableView3.emergencyName1 = creditUser[@"emergencyName1"];
                self.tableView3.emergencyRelation1 = creditUser[@"emergencyRelation1"];
                self.tableView3.emergencyMobile1 = creditUser[@"emergencyMobile1"];
                self.tableView3.emergencyName2 = creditUser[@"emergencyName2"];
                self.tableView3.emergencyRelation2 = creditUser[@"emergencyRelation2"];
                self.tableView3.emergencyMobile2 = creditUser[@"emergencyMobile2"];
                [self.tableView3 reloadData];
            }
        }
        
        
//        self.tableView4.model = self.model;
        self.tableView4.model = self.model;
        NSDictionary *bankLoan = self.model.bankLoan;

        self.tableView4.periods = bankLoan[@"periods"];
        self.tableView4.bankRate = bankLoan[@"bankRate"];
        self.tableView4.rateType = bankLoan[@"rateType"];
        self.tableView4.isAdvanceFund = bankLoan[@"isAdvanceFund"];
        self.tableView4.isDiscount = bankLoan[@"isDiscount"];
        self.tableView4.wanFactor = bankLoan[@"wanFactor"];
        
        [self.tableView4 reloadData];
        
        self.tableView5.model = self.model;
        [self.tableView5 reloadData];

        self.regAddress = [BaseModel convertNull:self.model.carInfo[@"regAddress"]];
        
//        self.region = [BaseModel convertNull:self.model.carInfo[@"regAddress"]];
        
        self.tableView6.regAddress = self.model.carInfo[@"regAddressName"];
        self.tableView6.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
        
        
        
//        self.driveLicense = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_license"] componentsSeparatedByString:@"||"];
        self.tableView6.driveLicense = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_license"] componentsSeparatedByString:@"||"];
        
//        self.region = [BaseModel convertNull:self.model.carInfo[@"region"]];
        self.tableView6.regAddress = [BaseModel convertNull:self.model.regionName];
        
        self.isAzGps = [BaseModel convertNull:self.model.carInfo[@"isAzGps"]];
        self.tableView6.isAzGps = self.isAzGps;
        
        self.isPublicCard = [BaseModel convertNull:self.model.carInfo[@"isPublicCard"]];
        self.tableView6.isPublicCard = self.isPublicCard;
        
        self.tableView6.model = self.model;
        
//        self.carBrand = [BaseModel convertNull:self.model.carInfo[@"carBrand"]];
        self.tableView6.carBrand = [BaseModel convertNull:self.model.carInfo[@"carBrandName"]];
//        self.carSeries = [BaseModel convertNull:self.model.carInfo[@"carSeries"]];
        self.tableView6.carSeries = [BaseModel convertNull:self.model.carInfo[@"carSeriesName"]];
//        self.carModel = [BaseModel convertNull:self.model.carInfo[@"carModel"]];
        self.tableView6.carModel = [BaseModel convertNull:self.model.carInfo[@"carModelName"]];
        self.tableView6.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
//        self.regDate = [BaseModel convertNull:self.model.carInfo[@"regDate"]];
        self.tableView6.mile = [BaseModel convertNull:self.model.carInfo[@"mile"]];
//        self.mile = [BaseModel convertNull:self.model.carInfo[@"mile"]];
        
        self.tableView6.bizType = self.model.bizType;
        
        self.tableView6.secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
//        self.secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
        
        [self.tableView6 reloadData];
        
        
        
        
        
        
        if (self.model.gpsAzList.count > 0) {
            for (int i = 0; i < self.model.gpsAzList.count; i ++) {
                [self.tableView6.gpsAry addObject:[SurveyModel mj_objectWithKeyValues:self.model.gpsAzList[i]]];
                [self.tableView6.gpsPhotoAry addObject:[self.model.gpsAzList[i][@"azPhotos"] componentsSeparatedByString:@"||"]];
            }
        }
        [self.tableView6 reloadData];
        
        
        
        self.driveCard = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"drive_card"] componentsSeparatedByString:@"||"];
        self.marryPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"marry_pdf"];
        self.divorcePdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"divorce_pdf"];
        self.singleProve = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"single_prove"];
        self.incomeProve = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"income_prove"];
        self.liveProvePdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"live_prove_pdf"];
        self.housePropertyCardPdf = [BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"single_prove"];
        self.hkBookFirstPage = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"hk_book_first_page"] componentsSeparatedByString:@"||"];
        self.bankJourFirstPage = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"bank_jour_first_page"] componentsSeparatedByString:@"||"];
        self.zfbJour = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"zfb_jour"] componentsSeparatedByString:@"||"];
        self.wxJour = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"wx_jour"] componentsSeparatedByString:@"||"];
        self.otherPdf = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"other_pdf"] componentsSeparatedByString:@"||"];
//        self.contractAwardVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"contract_award_video"] componentsSeparatedByString:@"||"];
        
        
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
        self.tableView7.contractAwardVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"contract_award_video"] componentsSeparatedByString:@"||"];
        [self.tableView7 reloadData];
        
        self.doorPdf = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"door_photo"] componentsSeparatedByString:@"||"];
        self.tableView8.doorPdf = self.doorPdf;
        self.groupPhoto = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"group_photo"] componentsSeparatedByString:@"||"];
        self.tableView8.groupPhoto = self.groupPhoto;
        self.houseVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"house_video"] componentsSeparatedByString:@"||"];
        self.tableView8.houseVideo = self.houseVideo;
//        self.companyVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"company_video"] componentsSeparatedByString:@"||"];
        self.tableView8.companyVideo = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"company_video"] componentsSeparatedByString:@"||"];
        [self.tableView8 reloadData];
        
        self.carHead = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_head"] componentsSeparatedByString:@"||"];
        self.tableView9.carHead = self.carHead;
        self.carRegisterCertificateFirst = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_register_certificate_first"] componentsSeparatedByString:@"||"];
        self.tableView9.carRegisterCertificateFirst = self.carRegisterCertificateFirst;
        
        [self.tableView9 reloadData];
        
        
        self.tableView10.model = self.model;
        
        self.tableView11.model = self.model;
        self.tableView12.model = self.model;
        self.tableView13.model = self.model;
        self.tableView14.model = self.model;
        self.tableView15.model = self.model;
        
        [self.tableView10 reloadData];
        [self.tableView11 reloadData];
        [self.tableView12 reloadData];
        [self.tableView13 reloadData];
        [self.tableView14 reloadData];
        [self.tableView15 reloadData];
        
        
        [self infoMationLoadData];
        [self RepaymentPlanLoadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [self.view bringSubviewToFront:self.tableView1];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        self.tableView1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView3.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView4.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView5.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView6.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView7.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView8.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView9.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView10.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView11.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView12.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView13.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView14.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        self.tableView15.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
    });
}


-(void)infoMationLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630196";
    http.parameters[@"code"] = self.model.teamCode;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView10.dataDic = responseObject[@"data"];
        [self.tableView10 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)RepaymentPlanLoadData
{
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630521";
    http.parameters[@"code"] = self.model.code;
    http.isShowMsg = NO;
    [http postWithSuccess:^(id responseObject) {
        
        self.tableView15.repayPlanList = responseObject[@"data"][@"repayPlanList"];
        [self.tableView15 reloadData];
        self.headView.price = responseObject[@"data"][@"restAmount"];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 10) {
//        NSString *secondCarReport = [BaseModel convertNull:self.model.carInfo[@"secondCarReport"]];
        
//    }
    
    
    if (refreshTableview.tag == 20101) {
        NewLenderVC *vc = [NewLenderVC new];
        vc.dataDic = self.tableView2.credit_user_loan_roleArray[indexPath.row];
        vc.code = self.model.code;
        vc.isDetails = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (refreshTableview.tag == 20105) {
        if ([self.model.bizType isEqualToString:@"1"]) {
            if (indexPath.row == 3) {
                if ([BaseModel isBlankString:self.tableView6.secondCarReport] == NO) {
                    WebVC *vc = [WebVC new];
                    vc.url = self.tableView6.secondCarReport;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    }
    if (refreshTableview.tag == 20109) {
        if (indexPath.section == 2) {
            if (indexPath.row == 2) {
                ImageBrowsingVC *vc = [ImageBrowsingVC new];
                NSArray *ary = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"advance_bill_pdf"] componentsSeparatedByString:@"||"];
                NSMutableArray *imageArray = [NSMutableArray array];
                for (int i = 0; i < ary.count; i ++) {
                    [imageArray addObject:[ary[i] convertImageUrl]];
                }
                vc.title = @"水单";
                vc.imageArray = imageArray;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    if (refreshTableview.tag == 20112) {
        if (indexPath.row < 4) {
            return;
        }
        NSArray *ary;
        if (indexPath.row == 4) {
            ary = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"advance_contract"] componentsSeparatedByString:@"||"];
        }
        if (indexPath.row == 5) {
            ary = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"guarantor_contract"] componentsSeparatedByString:@"||"];
        }
        if (indexPath.row == 6) {
            ary = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"pledge_contract"] componentsSeparatedByString:@"||"];
        }
        if (indexPath.row == 7) {
            ary = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"enter_other_pdf"] componentsSeparatedByString:@"||"];
        }
        ImageBrowsingVC *vc = [ImageBrowsingVC new];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < ary.count; i ++) {
            [imageArray addObject:[ary[i] convertImageUrl]];
        }
        NSArray *nameArray = @[@"入档编号",@"存放位置",@"保险公司",@"商业险",@"垫资合同",@"担保和反担保合同",@"抵押合同",@"其他资料"];
        vc.title = nameArray[indexPath.row];
        
        vc.imageArray = imageArray;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.menuView];
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
    [self credit_user_loan_roleLoadData];
}


-(void)credit_user_loan_roleLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.showView = self.view;
    http.parameters[@"parentKey"] = @"credit_user_loan_role";
    [http postWithSuccess:^(id responseObject) {
        self.tableView2.credit_user_loan_roleArray = responseObject[@"data"];
        [self.tableView2 reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)MenuSelectTag:(NSInteger)tag
{
    if (tag == 100) {
        _menuView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }else
    {
        _menuView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        UITableView *tableView = [self.view viewWithTag:tag + 20100];
        [self.view bringSubviewToFront:tableView];
        selectTag = tag;
        self.title = [MenuModel new].detailsMenuArray[tag];
    }
}


-(void)rightButtonClick
{
    
    _menuView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view bringSubviewToFront:_menuView];
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
