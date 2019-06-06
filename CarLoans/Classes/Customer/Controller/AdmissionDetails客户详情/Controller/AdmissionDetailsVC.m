//
//  AdmissionDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsVC.h"

#import "AdmissionDetailsTableView.h"
#import "AdmissionDetailsTableView1.h"
#import "AdmissionDetailsTableView2.h"
#import "AdmissionDetailsTableView3.h"
#import "AdmissionDetailsTableView4.h"
#import "AdmissionDetailsTableView5.h"
#import "AdmissionDetailsTableView6.h"
#import "AdmissionDetailsTableView7.h"
#import "AdmissionDetailsTableView8.h"
#import "AdmissionDetailsTableView9.h"
#import "AdmissionDetailsTableView10.h"
#import "AdmissionDetailsTableView11.h"
#import "AdmissionDetailsTableView12.h"
#import "AdmissionDetailsTableView13.h"
#import "AdmissionDetailsTableView14.h"
#import "AdmissionDetailsTableView15.h"
#import "AdmissionDetailsTableView16.h"
#import "AdmissionDetailsTableView17.h"
#import "RepaymentPlanHeadView.h"
@interface AdmissionDetailsVC ()<RefreshDelegate>
@property (nonatomic , strong)AdmissionDetailsTableView *tableView;

@property (nonatomic , strong)AdmissionDetailsTableView1 *tableView1;
@property (nonatomic , strong)AdmissionDetailsTableView2 *tableView2;
@property (nonatomic , strong)AdmissionDetailsTableView3 *tableView3;
@property (nonatomic , strong)AdmissionDetailsTableView4 *tableView4;
@property (nonatomic , strong)AdmissionDetailsTableView5 *tableView5;
@property (nonatomic , strong)AdmissionDetailsTableView6 *tableView6;
@property (nonatomic , strong)AdmissionDetailsTableView7 *tableView7;
@property (nonatomic , strong)AdmissionDetailsTableView8 *tableView8;
@property (nonatomic , strong)AdmissionDetailsTableView9 *tableView9;
@property (nonatomic , strong)AdmissionDetailsTableView10 *tableView10;
@property (nonatomic , strong)AdmissionDetailsTableView11 *tableView11;
@property (nonatomic , strong)AdmissionDetailsTableView12 *tableView12;
@property (nonatomic , strong)AdmissionDetailsTableView13 *tableView13;
@property (nonatomic , strong)AdmissionDetailsTableView14 *tableView14;
@property (nonatomic , strong)AdmissionDetailsTableView15 *tableView15;
@property (nonatomic , strong)AdmissionDetailsTableView16 *tableView16;
@property (nonatomic , strong)AdmissionDetailsTableView17 *tableView17;

@property (nonatomic,strong) RepaymentPlanHeadView * topView;
@end
@implementation AdmissionDetailsVC


- (void)viewDidLoad {
    self.title = @"征信详情";
    
    [self initNavigationController];
    [self loadData];
}

-(void)initTableView
{
    self.tableView = [[AdmissionDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.tag = 1000000;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    self.tableView1 = [[AdmissionDetailsTableView1 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView1.refreshDelegate = self;
    self.tableView1.backgroundColor = kWhiteColor;
    self.tableView1.tag = 1000001;
    self.tableView1.model = self.model;
    [self.view addSubview:self.tableView1];
    
    self.tableView2 = [[AdmissionDetailsTableView2 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView2.refreshDelegate = self;
    self.tableView2.backgroundColor = kWhiteColor;
    self.tableView2.tag = 1000002;
    self.tableView2.model = self.model;
    [self.view addSubview:self.tableView2];
    
    
    self.tableView8 = [[AdmissionDetailsTableView8 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView8.refreshDelegate = self;
    self.tableView8.backgroundColor = kWhiteColor;
    self.tableView8.tag = 1000003;
    self.tableView8.model = self.model;
    [self.view addSubview:self.tableView8];
    
    self.tableView3 = [[AdmissionDetailsTableView3 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView3.refreshDelegate = self;
    self.tableView3.backgroundColor = kWhiteColor;
    self.tableView3.tag = 1000004;
    self.tableView3.model = self.model;
    [self.view addSubview:self.tableView3];
    
    self.tableView4 = [[AdmissionDetailsTableView4 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView4.refreshDelegate = self;
    self.tableView4.backgroundColor = kWhiteColor;
    self.tableView4.tag = 1000005;
    self.tableView4.model = self.model;
    [self.view addSubview:self.tableView4];
    
    self.tableView5 = [[AdmissionDetailsTableView5 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView5.refreshDelegate = self;
    self.tableView5.backgroundColor = kWhiteColor;
    self.tableView5.tag = 1000006;
    self.tableView5.model = self.model;
    [self.view addSubview:self.tableView5];
    
    self.tableView6 = [[AdmissionDetailsTableView6 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView6.refreshDelegate = self;
    self.tableView6.backgroundColor = kWhiteColor;
    self.tableView6.tag = 1000007;
    self.tableView6.model = self.model;
    [self.view addSubview:self.tableView6];
    
    self.tableView17 = [[AdmissionDetailsTableView17 alloc]initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView17.refreshDelegate = self;
    self.tableView17.backgroundColor = kWhiteColor;
    self.tableView17.tag = 1000008;
    self.tableView17.model = self.model;
    [self.view addSubview:self.tableView17];
    
    self.tableView7 = [[AdmissionDetailsTableView7 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView7.refreshDelegate = self;
    self.tableView7.backgroundColor = kWhiteColor;
    self.tableView7.tag = 1000009;
    self.tableView7.model = self.model;
    [self.view addSubview:self.tableView7];
    
    
    
    self.tableView9 = [[AdmissionDetailsTableView9 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView9.refreshDelegate = self;
    self.tableView9.backgroundColor = kWhiteColor;
    self.tableView9.tag = 1000010;
    self.tableView9.model = self.model;
    [self.view addSubview:self.tableView9];
    
    self.tableView10 = [[AdmissionDetailsTableView10 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView10.refreshDelegate = self;
    self.tableView10.backgroundColor = kWhiteColor;
    self.tableView10.tag = 1000011;
    self.tableView10.model = self.model;
    [self.view addSubview:self.tableView10];
    
    self.tableView11 = [[AdmissionDetailsTableView11 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView11.refreshDelegate = self;
    self.tableView11.backgroundColor = kWhiteColor;
    self.tableView11.tag = 1000012;
    self.tableView11.model = self.model;
    [self.view addSubview:self.tableView11];
    
    self.tableView12 = [[AdmissionDetailsTableView12 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView12.refreshDelegate = self;
    self.tableView12.backgroundColor = kWhiteColor;
    self.tableView12.tag = 1000013;
    self.tableView12.model = self.model;
    [self.view addSubview:self.tableView12];
    
    self.tableView13 = [[AdmissionDetailsTableView13 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView13.refreshDelegate = self;
    self.tableView13.backgroundColor = kWhiteColor;
    self.tableView13.tag = 1000014;
    self.tableView13.model = self.model;
    [self.view addSubview:self.tableView13];
    
    self.tableView14 = [[AdmissionDetailsTableView14 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView14.refreshDelegate = self;
    self.tableView14.backgroundColor = kWhiteColor;
    self.tableView14.tag = 1000015;
    self.tableView14.model = self.model;
    [self.view addSubview:self.tableView14];
    
    self.tableView15 = [[AdmissionDetailsTableView15 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView15.refreshDelegate = self;
    self.tableView15.backgroundColor = kWhiteColor;
    self.tableView15.tag = 1000016;
    self.tableView15.model = self.model;
    [self.view addSubview:self.tableView15];
    
    _topView = [[RepaymentPlanHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 107, 114 + 20)];
    self.tableView15.tableHeaderView = _topView;
    
    
    self.tableView16 = [[AdmissionDetailsTableView16 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView16.refreshDelegate = self;
    self.tableView16.backgroundColor = kWhiteColor;
    self.tableView16.tag = 1000017;
    self.tableView16.model = self.model;
    [self.view addSubview:self.tableView16];
    
    

    
    [self.view bringSubviewToFront:self.tableView1];
    
}

-(void)loadData
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    if ([BaseModel isBlankString:self.code] == YES) {
        http.parameters[@"code"] = self.model.code;
    }else
    {
        http.parameters[@"code"] = self.code;
    }
    
    [http postWithSuccess:^(id responseObject) {
        
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
        
        
        self.topView.price = self.model.restAmount;
        
        for (int i = 0; i < self.model.attachments.count; i ++) {
            NSDictionary *attachment = self.model.attachments[i];
//            申请人图片
            if ([attachment[@"kname"] isEqualToString:@"id_no_front_apply"]) {
                self.tableView2.id_no_front_apply = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"id_no_reverse_apply"]) {
                self.tableView2.id_no_reverse_apply = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"auth_pdf_apply"]) {
                self.tableView2.auth_pdf_apply = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"interview_pic_apply"]) {
                self.tableView2.interview_pic_apply = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_report_apply"]) {
                self.tableView2.bank_report_apply = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"data_report_apply"]) {
                self.tableView2.data_report_apply = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
//            担保人图片
            if ([attachment[@"kname"] isEqualToString:@"id_no_front_gua0"]) {
                self.tableView2.id_no_front_gua0 = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"id_no_reverse_gua0"]) {
                self.tableView2.id_no_reverse_gua0 = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"auth_pdf_gua0"]) {
                self.tableView2.auth_pdf_gua0 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"interview_pic_gua0"]) {
                self.tableView2.interview_pic_gua0 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_report_gua0"]) {
                self.tableView2.bank_report_gua0 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"data_report_gua0"]) {
                self.tableView2.data_report_gua0 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            
            if ([attachment[@"kname"] isEqualToString:@"id_no_front_gua1"]) {
                self.tableView2.id_no_front_gua1 = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"id_no_reverse_gua1"]) {
                self.tableView2.id_no_reverse_gua1 = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"auth_pdf_gua1"]) {
                self.tableView2.auth_pdf_gua1 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"interview_pic_gua1"]) {
                self.tableView2.interview_pic_gua1 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_report_gua1"]) {
                self.tableView2.bank_report_gua1 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"data_report_gua1"]) {
                self.tableView2.data_report_gua1 = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            
//            共还人图片
            if ([attachment[@"kname"] isEqualToString:@"id_no_front_gh"]) {
                self.tableView2.id_no_front_gh = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"id_no_reverse_gh"]) {
                self.tableView2.id_no_reverse_gh = attachment[@"url"];
            }
            if ([attachment[@"kname"] isEqualToString:@"auth_pdf_gh"]) {
                self.tableView2.auth_pdf_gh = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"interview_pic_gh"]) {
                self.tableView2.interview_pic_gh = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_report_gh"]) {
                self.tableView2.bank_report_gh = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"data_report_gh"]) {
                self.tableView2.data_report_gh = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            
//            面签
            if ([attachment[@"kname"] isEqualToString:@"bank_video"]) {
                self.tableView8.bank_video = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"company_video"]) {
                self.tableView8.company_video = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"other_video"]) {
                self.tableView8.other_video = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_photo"]) {
                self.tableView8.bank_photo = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"bank_contract"]) {
                self.tableView8.bank_contract = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"company_contract"]) {
                self.tableView8.company_contract = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
                self.tableView8.advance_fund_amount_pdf = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            if ([attachment[@"kname"] isEqualToString:@"interview_other_pdf"]) {
                self.tableView8.interview_other_pdf = [attachment[@"url"] componentsSeparatedByString:@"||"];
            }
            
        }
        
        
        [self.tableView1 reloadData];
        [self.tableView2 reloadData];
        [self.tableView3 reloadData];
        [self.tableView4 reloadData];
        [self.tableView5 reloadData];
        [self.tableView6 reloadData];
        [self.tableView17 reloadData];
        [self.tableView7 reloadData];
        [self.tableView8 reloadData];
        [self.tableView9 reloadData];
        [self.tableView10 reloadData];
        [self.tableView11 reloadData];
        [self.tableView12 reloadData];
        [self.tableView13 reloadData];
        [self.tableView14 reloadData];
        [self.tableView15 reloadData];
        [self.tableView16 reloadData];


    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (refreshTableview.tag == 1000000) {
        NSLog(@"indexrow= %ld",indexPath.row);
        UITableView *tableView = [self.view viewWithTag:indexPath.row + 1000001];
        [self.view bringSubviewToFront:tableView];
        self.tableView.row = indexPath.row;
//        [self.tableView reloadData];
    }
    
}

@end
