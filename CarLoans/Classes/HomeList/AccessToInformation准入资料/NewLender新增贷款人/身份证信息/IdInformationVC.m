//
//  IdInformationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "IdInformationVC.h"
#import "IdInformationTableView.h"
@interface IdInformationVC ()<RefreshDelegate>
@property(nonatomic , strong)IdInformationTableView *tableView;
@end

@implementation IdInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"身份证信息";
    
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[IdInformationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.userName = self.userName;
    self.tableView.nation = self.nation;
    self.tableView.gender = self.gender;
    self.tableView.customerBirth = self.customerBirth;
    self.tableView.idNo = self.idNo;
    self.tableView.birthAddress = self.birthAddress;
    self.tableView.authref = self.authref;
    self.tableView.statdate = self.statdate;
    self.tableView.isDetails = self.isDetails;
    self.tableView.startDate = self.startDate;
    [self.view addSubview:self.tableView];
    if (self.isDetails == NO) {
        UIButton *_bottomBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
        _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_bottomBtn];
    }
}

-(void)bottomBtnClick
{
    UITextField *tf0 = [self.view viewWithTag:1000];
    UITextField *tf1 = [self.view viewWithTag:1001];
    UITextField *tf2 = [self.view viewWithTag:1002];
    UITextField *tf3 = [self.view viewWithTag:1003];
    UITextField *tf4 = [self.view viewWithTag:1004];
    UITextField *tf5 = [self.view viewWithTag:1005];
    UITextField *tf6 = [self.view viewWithTag:1006];
    UITextField *tf7 = [self.view viewWithTag:1007];
    UITextField *tf8 = [self.view viewWithTag:1008];
    NSDictionary *idCardInfo = @{@"userName":tf0.text,
                                 @"gender":tf1.text,
                                 @"nation":tf2.text,
                                 @"customerBirth":tf3.text,
                                 @"authref":tf4.text,
                                 @"birthAddress":tf5.text,
                                 @"startDate":tf6.text,
                                 @"statdate":tf7.text,
                                 @"idNo":tf8.text
                                 };
    self.returnAryBlock(idCardInfo);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
