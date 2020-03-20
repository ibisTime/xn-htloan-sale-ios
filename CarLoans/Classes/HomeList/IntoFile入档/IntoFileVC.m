//
//  IntoFileVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "IntoFileVC.h"
#import "IntoFileTableView.h"
#import "InsuranceFormulaVC.h"
@interface IntoFileVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *syxDateStart;
    NSString *syxDateEnd;
    NSArray *enterLocationArray;
    NSString *enterLocation;
    NSArray *insuranceCompanyArray;
    NSString *insuranceCompany;
    NSInteger selectRow;
    
    NSArray *advanceContract;
    NSArray *guarantorContract;
    NSArray *pledgeContract;
    NSArray *enterOtherPdf;
    
    NSString *archivesCode;
}
@property (nonatomic , strong)IntoFileTableView *tableView;

@end

@implementation IntoFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    [self loadData];
}

-(void)loadData
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632592";
    //    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        archivesCode= responseObject[@"data"];
        self.tableView.archivesCode = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



-(void)initTableView
{
    self.tableView = [[IntoFileTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
//        @[@"垫资合同（多选）",@"担保和反担保合同（多选）",@"抵押合同（多选）",@"其他材料（多选）"]
//        NSArray *advanceContract;
//        NSArray *guarantorContract;
//        NSArray *pledgeContract;
//        NSArray *enterOtherPdf;
        if ([name isEqualToString:@"垫资合同（多选）"]) {
            advanceContract = imgAry;
        }
        if ([name isEqualToString:@"担保和反担保合同（多选）"]) {
            guarantorContract = imgAry;
        }
        if ([name isEqualToString:@"抵押合同（多选）"]) {
            pledgeContract = imgAry;
        }
        if ([name isEqualToString:@"其他材料（多选）"]) {
            enterOtherPdf = imgAry;
        }
    };
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"返回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            selectRow = indexPath.row;
            TLNetworking *http = [TLNetworking new];
            http.isShowMsg = YES;
            http.code = @"632827";
            http.showView = self.view;
            [http postWithSuccess:^(id responseObject) {
                NSArray *ary = responseObject[@"data"];
                enterLocationArray = responseObject[@"data"];
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < ary.count; i ++) {
                    [array addObject:ary[i][@"name"]];
                }
                BaseModel *baseModel = [BaseModel new];
                baseModel.ModelDelegate = self;
                [baseModel CustomBouncedView:array setState:@"100"];
            } failure:^(NSError *error) {
                
            }];
        }
        if (indexPath.row == 2) {
            selectRow = indexPath.row;
            
//            TLNetworking *http = [TLNetworking new];
//            http.isShowMsg = YES;
//            http.code = @"632046";
//            http.showView = self.view;
//            [http postWithSuccess:^(id responseObject) {
//                NSArray *ary = responseObject[@"data"];
//                insuranceCompanyArray = responseObject[@"data"];
//                NSMutableArray *array = [NSMutableArray array];
//                for (int i = 0; i < ary.count; i ++) {
//                    [array addObject:ary[i][@"name"]];
//                }
//                BaseModel *baseModel = [BaseModel new];
//                baseModel.ModelDelegate = self;
//                [baseModel CustomBouncedView:array setState:@"100"];
//            } failure:^(NSError *error) {
//
//            }];
            CarLoansWeakSelf;
            InsuranceFormulaVC *vc = [InsuranceFormulaVC new];
            vc.returnAryBlock = ^(SurveyModel *model) {
                insuranceCompany = model.code;
                weakSelf.tableView.insuranceCompany = model.name;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 3 || indexPath.row == 4) {
            WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                
                NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                if (indexPath.row == 3) {
                    syxDateStart = date;
                    self.tableView.syxDateStart = date;
                }
                else
                {
                    syxDateEnd = date;
                    self.tableView.syxDateEnd = date;
                }
                [self.tableView reloadData];
            }];
            datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
            datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
            datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
            [datepicker show];
        }
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if (selectRow == 1) {
        enterLocation = enterLocationArray[sid][@"code"];
        self.tableView.enterLocation = enterLocationArray[sid][@"name"];
    }
//    if (selectRow == 2) {
//
//    }
    [self.tableView reloadData];
}

-(void)throughBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)noThroughBtnClick
{
    
    //    UITextView
    if ([BaseModel isBlankString:enterLocation] == YES) {
        [TLAlert alertWithInfo:@"请选择档案存放位置"];
        return;
    }
    if ([BaseModel isBlankString:insuranceCompany] == YES) {
        [TLAlert alertWithInfo:@"请选择保险公司"];
        return;
    }
    if ([BaseModel isBlankString:syxDateStart] == YES) {
        [TLAlert alertWithInfo:@"请选择开始时间"];
        return;
    }
    if ([BaseModel isBlankString:syxDateEnd] == YES) {
        [TLAlert alertWithInfo:@"请选择结束时间"];
        return;
    }
    
    //        NSArray *advanceContract;
    //        NSArray *guarantorContract;
    //        NSArray *pledgeContract;
    //        NSArray *enterOtherPdf;
//    @[@"垫资合同（多选）",@"担保和反担保合同（多选）",@"抵押合同（多选）",@"其他材料（多选）"]
    if (advanceContract.count == 0) {
        [TLAlert alertWithInfo:@"请上传垫资合同"];
        return;
    }
    if (guarantorContract.count == 0) {
        [TLAlert alertWithInfo:@"请上传担保和反担保合同"];
        return;
    }
    if (pledgeContract.count == 0) {
        [TLAlert alertWithInfo:@"请上传抵押合同"];
        return;
    }
//    if (enterOtherPdf.count == 0) {
//        [TLAlert alertWithInfo:@"请上传其他材料"];
//        return;
//    }
    
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632590";
    http.parameters[@"enterCode"] =  archivesCode;
    http.parameters[@"enterLocation"] = enterLocation;
    http.parameters[@"insuranceCompany"] = insuranceCompany;
    http.parameters[@"syxDateStart"] = syxDateStart;
    http.parameters[@"syxDateEnd"] = syxDateEnd;
    http.parameters[@"advanceContract"] = [advanceContract componentsJoinedByString:@"||"];
    http.parameters[@"guarantorContract"] = [guarantorContract componentsJoinedByString:@"||"];
    http.parameters[@"pledgeContract"] = [pledgeContract componentsJoinedByString:@"||"];
    http.parameters[@"enterOtherPdf"] = [enterOtherPdf componentsJoinedByString:@"||"];
    
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.model.code;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"入档成功"];
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
