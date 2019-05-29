//
//  CreditReviewVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditReviewVC.h"
#import "CreditReviewTableView.h"
#import "SurveyInformationVC.h"
@interface CreditReviewVC ()<RefreshDelegate>
@property (nonatomic , strong)CreditReviewTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;

//@property (nonatomic , strong)NSMutableArray *creditList;

@end

@implementation CreditReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"征信审核";
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.surveyModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.surveyModel = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
//    [self initTableView];
    [self cdbiz_statusLoadData];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)rightButtonClick
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = self.surveyModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)cdbiz_statusLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"cdbiz_status";
    [http postWithSuccess:^(id responseObject) {
        
        self.dataArray = responseObject[@"data"];
        for (int i = 0; i < self.dataArray.count; i ++) {
            if ([self.dataArray[i][@"dkey"] isEqualToString:_surveyModel.status]) {
                self.tableView.state = self.dataArray[i][@"dvalue"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)initTableView {
    self.tableView = [[CreditReviewTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.surveyModel;
    [self.view addSubview:self.tableView];
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SurveyInformationVC *vc = [SurveyInformationVC new];
    vc.dataDic = self.surveyModel.creditUserList[index - 123];
    vc.node = @"征信审核";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    
    UITextField *textField = [self.view viewWithTag:3000];
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入审核意见"];
        return;
    }
    
    NSString *approveResult;
    if (index == 100) {
        approveResult = @"1";
    }else
    {
        approveResult = @"0";
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632113";
    http.showView = self.view;
    http.parameters[@"approveNote"] = textField.text;
    http.parameters[@"creditUserList"] = _surveyModel.creditUserList;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = _surveyModel.code;
    http.parameters[@"approveResult"] = approveResult;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"审核成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

@end
