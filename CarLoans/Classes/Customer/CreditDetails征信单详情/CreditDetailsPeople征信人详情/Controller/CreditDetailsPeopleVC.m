//
//  CreditDetailsPeopleVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsPeopleVC.h"
#import "CreditDetailsPeopleTableView.h"
@interface CreditDetailsPeopleVC ()<RefreshDelegate>

@property (nonatomic , strong)CreditDetailsPeopleTableView *tableView;

@end
@implementation CreditDetailsPeopleVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"征信人详情";
}

-(void)initTableView
{
    self.tableView = [[CreditDetailsPeopleTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataDic = self.dataDic;
    
    NSArray *authPdf= [self.dataDic[@"authPdf"] componentsSeparatedByString:@"||"];
    NSArray *interviewPic= [self.dataDic[@"interviewPic"] componentsSeparatedByString:@"||"];
    self.tableView.authPdf = authPdf;
    self.tableView.interviewPic = interviewPic;
    [self.view addSubview:self.tableView];
}

@end
