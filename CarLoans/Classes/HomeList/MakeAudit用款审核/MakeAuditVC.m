//
//  MakeAuditVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeAuditVC.h"
#import "MakeAuditTableView.h"
#import "TaskManagementVC.h"
@interface MakeAuditVC ()<RefreshDelegate,BaseModelDelegate>
{
    
    NSString *isContinueAdvance;
    NSString *isPay;
    NSInteger selectRow;
}
@property (nonatomic , strong)MakeAuditTableView *tableView;
@property (nonatomic , strong)NSArray *missionArray;
@end

@implementation MakeAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[MakeAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
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

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([BaseModel isBlankString:isPay] == YES) {
            if (indexPath.row == 1) {
                
                TaskManagementVC *vc = [TaskManagementVC new];
                CarLoansWeakSelf;
                vc.returnAryBlock1 = ^(NSArray * _Nonnull missionArray) {
                    weakSelf.missionArray = missionArray;
                };
                vc.missionList = weakSelf.missionArray;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 0 || indexPath.row == 2) {
                if (indexPath.row == 0) {
                    selectRow = 5;
                }else
                {
                    selectRow = 4;
                }
                NSMutableArray *ary = [NSMutableArray array];
                [ary addObjectsFromArray:@[@"是",@"否"]];
                BaseModel *baseModel = [BaseModel user];
                baseModel.ModelDelegate = self;
                [baseModel CustomBouncedView:ary setState:@"100"];
                
            }
        }else if ([isPay isEqualToString:@"1"]) {
            if (indexPath.row == 5) {
                
                TaskManagementVC *vc = [TaskManagementVC new];
                CarLoansWeakSelf;
                vc.returnAryBlock1 = ^(NSArray * _Nonnull missionArray) {
                    weakSelf.missionArray = missionArray;
                };
                vc.missionList = weakSelf.missionArray;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 0 || indexPath.row == 6) {
                if (indexPath.row == 0) {
                    selectRow = 5;
                }else
                {
                    selectRow = 4;
                }
                NSMutableArray *ary = [NSMutableArray array];
                [ary addObjectsFromArray:@[@"是",@"否"]];
                BaseModel *baseModel = [BaseModel user];
                baseModel.ModelDelegate = self;
                [baseModel CustomBouncedView:ary setState:@"100"];
                
            }
        }else
        {
            if (indexPath.row == 3) {
                
                TaskManagementVC *vc = [TaskManagementVC new];
                CarLoansWeakSelf;
                vc.returnAryBlock1 = ^(NSArray * _Nonnull missionArray) {
                    weakSelf.missionArray = missionArray;
                };
                vc.missionList = weakSelf.missionArray;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            if (indexPath.row == 0 || indexPath.row == 4) {
                if (indexPath.row == 0) {
                    selectRow = 5;
                }else
                {
                    selectRow = 4;
                }
                NSMutableArray *ary = [NSMutableArray array];
                [ary addObjectsFromArray:@[@"是",@"否"]];
                BaseModel *baseModel = [BaseModel user];
                baseModel.ModelDelegate = self;
                [baseModel CustomBouncedView:ary setState:@"100"];
                
            }
        }
        
//        if (indexPath.row == 4 || indexPath.row == 5) {
//            selectRow = indexPath.row;
//            NSMutableArray *ary = [NSMutableArray array];
//            [ary addObjectsFromArray:@[@"是",@"否"]];
//            BaseModel *baseModel = [BaseModel user];
//            baseModel.ModelDelegate = self;
//            [baseModel CustomBouncedView:ary setState:@"100"];
//        }
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if ([Str isEqualToString:@"是"]) {
        if (selectRow == 4) {
            isContinueAdvance = @"1";
        }else
        {
            isPay = @"1";
        }
        
    }else
    {
        if (selectRow == 4) {
            isContinueAdvance = @"0";
        }else
        {
            isPay = @"0";
        }
    }
    if (selectRow == 4) {
        self.tableView.isContinueAdvance = Str;
    }else
    {
        self.tableView.isPay = Str;
    }
    
    
    [self.tableView reloadData];
        
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
    if ([BaseModel isBlankString:isContinueAdvance] == YES) {
        [TLAlert alertWithInfo:@"请选择是否继续垫资"];
        return;
    }
    if ([BaseModel isBlankString:isPay] == YES) {
        [TLAlert alertWithInfo:@"是否同时支付车款2"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632552";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"approveResult"] = approveResult;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = textView.text;
    http.parameters[@"missionList"] = self.missionArray;
    http.parameters[@"isPay"] = isPay;
    http.parameters[@"isContinueAdvance"] = isContinueAdvance;
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
