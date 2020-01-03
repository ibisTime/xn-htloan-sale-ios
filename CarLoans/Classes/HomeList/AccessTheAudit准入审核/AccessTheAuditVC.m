//
//  AccessTheAuditVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AccessTheAuditVC.h"
#import "AccessTheAuditTableView.h"
@interface AccessTheAuditVC ()<RefreshDelegate>

@property (nonatomic , strong)AccessTheAuditTableView *tableView;

@end

@implementation AccessTheAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[AccessTheAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)throughBtnClick
{
    [self loadData:@"1"];
}

-(void)noThroughBtnClick
{
    [self loadData:@"0"];
}

-(void)loadData:(NSString *)approveResult
{
    UITextView *textView = [self.view viewWithTag:1000];
    if ([textView.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入审核内容"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632540";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"approveResult"] = approveResult;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = textView.text;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {

        if ([approveResult isEqualToString:@"1"]) {
            [TLAlert alertWithSucces:@"审核通过"];
            
        }else
        {
            [TLAlert alertWithSucces:@"审核不通过"];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
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
