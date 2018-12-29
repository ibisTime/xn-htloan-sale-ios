//
//  HomeVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTbView.h"
//资信调查
#import "SurveyVC.h"
//车辆落户
#import "CarSettledInVC.h"
//车辆抵押
#import "CarMortgageVC.h"
//#import "HomeCarVC.h"
//面签
#import "FaceSignVC.h"
#import "FaceSignHomeVC.h"
//GPS安装
#import "GPSInstallationVC.h"
#import "GPSHomeVC.h"
//客户作废
#import "CustomerInvalidVC.h"
//GPS申领
#import "GPSClaimsVC.h"
//历史客户
#import "HistoryUserVC.h"
//资料传递
#import "DataTransferVC.h"
//银行放款
#import "BankLendingVC.h"
//结清审核
#import "SettlementAuditVC.h"
@interface HomeVC ()<RefreshDelegate>
{
    NSDictionary *dataDic;
}
@property (nonatomic , strong)HomeTbView *tableView;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigativeView];
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[HomeTbView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    [self loadData];

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if ([dataDic[@"roleCode"] isEqualToString:@"SR20180000000000000ZHRY"]) {
        switch (index) {
            case 100:
            {
                SurveyVC *vc = [SurveyVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 101:
            {
                FaceSignVC *vc = [FaceSignVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 102:
            {
                BankLendingVC *vc = [BankLendingVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 103:
            {
                CarMortgageVC *vc = [CarMortgageVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 104:
            {
                SettlementAuditVC *vc = [[SettlementAuditVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1000:
            {
                DataTransferVC *vc = [DataTransferVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }else
    {
        switch (index) {
            case 100:
            {
                SurveyVC *vc = [SurveyVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 101:
            {
                FaceSignVC *vc = [FaceSignVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 102:
            {
//                if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
//                    CarSettledInVC *vc = [CarSettledInVC new];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }else
//                {
                    GPSHomeVC *vc = [GPSHomeVC new];
                    [self.navigationController pushViewController:vc animated:YES];
//                }

            }
                break;
            case 103:
            {
                CarSettledInVC *vc = [CarSettledInVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 104:
            {
                CarMortgageVC *vc = [CarMortgageVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1000:
            {
                CustomerInvalidVC *vc = [CustomerInvalidVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1001:
            {
//                if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
//                    HistoryUserVC *vc = [HistoryUserVC new];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }else
//                {
                    GPSClaimsVC *vc = [GPSClaimsVC new];
                    [self.navigationController pushViewController:vc animated:YES];
//                }

            }
                break;
            case 1002:
            {
                HistoryUserVC *vc = [HistoryUserVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10000:
            {
                DataTransferVC *vc = [DataTransferVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }


            default:
                break;
        }
    }
}

-(void)navigativeView
{
    self.title = @"车贷";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"切换账号" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)rightButtonClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退出登录" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
        LoginVC *vc = [[LoginVC alloc]init];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [USERDEFAULTS removeObjectForKey:USER_ID];
        [USERDEFAULTS removeObjectForKey:TOKEN_ID];
        window.rootViewController = vc;
    } confirm:^(UIAlertAction *action) {

    }];
}

-(void)viewWillAppear:(BOOL)animated
{

    [self updateUserInfoWithNotification];
}



- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {

        dataDic =  responseObject[@"data"];
        self.tableView.dic = dataDic;
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self RedDotPromptDic:responseObject[@"data"]];
    } failure:^(NSError *error) {
    }];
}

-(void)RedDotPromptDic:(NSDictionary *)dict
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = @"632912";
    http.parameters[@"roleCode"] = dict[@"roleCode"];
    http.parameters[@"teamCode"] = dict[@"teamCode"];
    [http postWithSuccess:^(id responseObject) {

        self.tableView.RedDotDic = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

- (void)setUserInfoWithDict:(NSDictionary *)dict
{
    [USERDEFAULTS setObject:dict forKey:USERDATA];
    [USERDEFAULTS setObject:dict[@"roleCode"] forKey:ROLECODE];
    [USERDEFAULTS setObject:dict[@"postCode"] forKey:ROSTCODE];
    [USERDEFAULTS setObject:dict[@"teamCode"] forKey:TEAMCODE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630147";
    [http postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:NODE];
    } failure:^(NSError *error) {

    }];

    TLNetworking *http1 = [TLNetworking new];
    http1.isShowMsg = NO;
    http1.code = @"630036";
    [http1 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:BOUNCEDDATA];
    } failure:^(NSError *error) {

    }];
}


@end
