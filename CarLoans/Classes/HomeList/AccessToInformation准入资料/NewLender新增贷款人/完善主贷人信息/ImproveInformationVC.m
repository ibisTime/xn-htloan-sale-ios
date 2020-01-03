//
//  ImproveInformationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ImproveInformationVC.h"
#import "ImproveInformationTableView.h"
#import "JHAddressPickView.h"
@interface ImproveInformationVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSInteger selectRow;
}
@property(nonatomic , strong)ImproveInformationTableView *tableView;
@property(nonatomic , strong)BaseModel *baseModel;
@property(nonatomic , strong)JHAddressPickView *pickView;

@property (nonatomic , strong)SurveyModel *model;

@end

@implementation ImproveInformationVC

- (JHAddressPickView *)pickView{
    if (!_pickView) {
        _pickView = [[JHAddressPickView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 350 , SCREEN_WIDTH, 350)];
        _pickView.columns = 3;
        // 关闭默认支持打开上次的结果
        MJWeakSelf;
        _pickView.pickBlock = ^(NSDictionary *dic) {
            if (selectRow == 1) {
                weakSelf.nowAddressProvince = dic[@"province"];
                weakSelf.nowAddressCity = dic[@"city"];
                weakSelf.nowAddressArea = dic[@"town"];
                weakSelf.tableView.nowAddressProvince = dic[@"province"];
                weakSelf.tableView.nowAddressCity = dic[@"city"];
                weakSelf.tableView.nowAddressArea = dic[@"town"];
            }
            if (selectRow == 9) {
                
                weakSelf.companyProvince = dic[@"province"];
                weakSelf.companyCity = dic[@"city"];
                weakSelf.companyArea = dic[@"town"];
                weakSelf.tableView.companyProvince = dic[@"province"];
                weakSelf.tableView.companyCity = dic[@"city"];
                weakSelf.tableView.companyArea = dic[@"town"];
            }
            [weakSelf.tableView reloadData];
        };
    }
    return _pickView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善主贷人信息";
    [self initTableView];
    
    _baseModel = [BaseModel user];
    _baseModel.ModelDelegate = self;

    [self loadData];
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if (selectRow == 0) {
        self.education = dic[@"dkey"];
        self.tableView.education = self.education;
    }
    if (selectRow == 5) {
        self.nowAddressState = dic[@"dkey"];
        self.tableView.nowAddressState = self.nowAddressState;
    }
    if (selectRow == 6) {
        self.marryState = dic[@"dkey"];
        self.tableView.marryState = self.marryState;
    }
    if (selectRow == 7) {
        if ([Str isEqualToString:@"自有"]) {
            self.nowHouseType = @"0";
        }else
        {
            self.nowHouseType = @"1";
        }
        self.tableView.nowHouseType = self.nowHouseType;
    }
    if (selectRow == 11) {
        self.workCompanyProperty = dic[@"dkey"];
        self.tableView.workCompanyProperty = self.workCompanyProperty;
    }
    if (selectRow == 13) {
        self.position = dic[@"dkey"];
        self.tableView.position = self.position;
    }
    if (selectRow == 16) {
        self.permanentType = dic[@"dkey"];
        self.tableView.permanentType = self.permanentType;
    }
    [self.tableView reloadData];
}

-(void)initTableView
{
    self.tableView = [[ImproveInformationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75 + 10000) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isDetails = self.isDetails;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    UIButton *_bottomBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
    [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_bottomBtn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
    });
    
}


-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        for (int i = 0; i < self.model.creditUserList.count; i ++) {
            if ([self.dataDic[@"dkey"] isEqualToString:self.model.creditUserList[i][@"loanRole"]]) {
                NSDictionary *creditUser = self.model.creditUserList[i];
                
                self.education = creditUser[@"education"];
                self.tableView.education = self.education;
                
                self.nowAddressProvince = creditUser[@"nowAddressProvince"];
                self.tableView.nowAddressProvince = self.nowAddressProvince;
                
                self.nowAddressCity = creditUser[@"nowAddressCity"];
                self.tableView.nowAddressCity = self.nowAddressCity;
                
                self.nowAddressArea = creditUser[@"nowAddressArea"];
                self.tableView.nowAddressArea = self.nowAddressArea;
                
                self.nowAddress = creditUser[@"nowAddress"];
                self.tableView.nowAddress = creditUser[@"nowAddress"];
                
                self.nowAddressMobile = creditUser[@"nowAddressMobile"];
                self.tableView.nowAddressMobile = creditUser[@"nowAddressMobile"];
                
                self.nowAddressDate = creditUser[@"nowAddressDate"];;
                self.tableView.nowAddressDate = creditUser[@"nowAddressDate"];
                
                self.nowAddressState = creditUser[@"nowAddressState"];
                self.tableView.nowAddressState = creditUser[@"nowAddressState"];
                
                self.marryState = creditUser[@"marryState"];;
                self.tableView.marryState = creditUser[@"marryState"];
                
                self.nowHouseType = creditUser[@"nowHouseType"];
                self.tableView.nowHouseType = creditUser[@"nowHouseType"];
                
                self.companyName = creditUser[@"companyName"];;
                self.tableView.companyName = creditUser[@"companyName"];
                
                self.companyProvince = creditUser[@"companyProvince"];
                self.tableView.companyProvince = creditUser[@"companyProvince"];
                
                self.companyCity = creditUser[@"companyCity"];;
                self.tableView.companyCity = creditUser[@"companyCity"];
                
                self.companyArea = creditUser[@"companyArea"];;
                self.tableView.companyArea = creditUser[@"companyArea"];
                
                self.companyAddress = creditUser[@"companyAddress"];;
                self.tableView.companyAddress = creditUser[@"companyAddress"];
                
                self.workCompanyProperty = creditUser[@"workCompanyProperty"];;
                self.tableView.workCompanyProperty = creditUser[@"workCompanyProperty"];
                
                self.workDatetime = creditUser[@"workDatetime"];;
                self.tableView.workDatetime = creditUser[@"workDatetime"];
                
                self.position = creditUser[@"position"];;
                self.tableView.position = creditUser[@"position"];
                
                self.yearIncome = creditUser[@"yearIncome"];;
                self.tableView.yearIncome = creditUser[@"yearIncome"];
                
                self.presentJobYears = creditUser[@"presentJobYears"];
                self.tableView.presentJobYears = creditUser[@"presentJobYears"];
                
                self.permanentType = creditUser[@"permanentType"];;
                self.tableView.permanentType = creditUser[@"permanentType"];
                
                [self.tableView reloadData];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)bottomBtnClick
{
    
    
    if (self.isDetails == YES) {
        return;
    }
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632530";
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.code;
    http.showView = self.view;

    UITextField *tf1 = [self.view viewWithTag:1002];
//    住宅电话
    UITextField *tf2 = [self.view viewWithTag:1003];
    UITextField *tf3 = [self.view viewWithTag:1008];
//    单位地址
    UITextField *tf4 = [self.view viewWithTag:1010];
    UITextField *tf5 = [self.view viewWithTag:1014];
    UITextField *tf6 = [self.view viewWithTag:1015];
    NSArray *creditUserList = @[@{@"loanRole":[BaseModel convertNull:_dataDic[@"dkey"]],
                                  @"education":[BaseModel convertNull:_education],
                                  @"nowAddressProvince":[BaseModel convertNull:_nowAddressProvince],
                                  @"nowAddressCity":[BaseModel convertNull:_nowAddressCity],
                                  @"nowAddressArea":[BaseModel convertNull:_nowAddressArea],
                                  @"nowAddress":tf1.text,
                                  @"nowAddressMobile":tf2.text,
                                  @"nowAddressDate":[BaseModel convertNull:_nowAddressDate],
                                  @"nowAddressState":[BaseModel convertNull:_nowAddressState],
                                  @"marryState":[BaseModel convertNull:_marryState],
                                  @"nowHouseType":[BaseModel convertNull:_nowHouseType],
                                  @"companyName":tf3.text,
                                  @"companyProvince":[BaseModel convertNull:_companyProvince],
                                  @"companyCity":[BaseModel convertNull:_companyCity],
                                  @"companyArea":[BaseModel convertNull:_companyArea],
                                  @"companyAddress":tf4.text,
                                  @"workCompanyProperty":[BaseModel convertNull:_workCompanyProperty],
                                  @"workDatetime":[BaseModel convertNull:_workDatetime],
                                  @"position":[BaseModel convertNull:_position],
                                  @"yearIncome":[BaseModel Cheng1000:tf5.text],
                                  @"presentJobYears":tf6.text,
                                  @"permanentType":[BaseModel convertNull:_permanentType],
                                  }];
    
    http.parameters[@"creditUserList"] = creditUserList;
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDetails == YES) {
        return;
    }
    selectRow = indexPath.row;
    if (indexPath.row == 0) {
        [_baseModel ReturnsParentKeyAnArray:@"education"];
    }
    if (indexPath.row == 1) {
        [self.pickView showInView:self.view];
    }
    if (indexPath.row == 4) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM"];
            self.nowAddressDate = date;
            self.tableView.nowAddressDate = date;
            [self.tableView reloadData];
        }];
        datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
        [datepicker show];
    }
    if (indexPath.row == 5) {
        [_baseModel ReturnsParentKeyAnArray:@"now_address_state"];
    }
    if (indexPath.row == 6) {
        [_baseModel ReturnsParentKeyAnArray:@"marry_state"];
    }
    if (indexPath.row == 7) {
        [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"自有",@"租用"]] setState:@"100"];
    }
    if (indexPath.row == 9) {
        [self.pickView showInView:self.view];
    }
    if (indexPath.row == 11) {
        [_baseModel ReturnsParentKeyAnArray:@"work_company_property"];
    }
    if (indexPath.row == 12) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM"];
            self.workDatetime = date;
            self.tableView.workDatetime = date;
            [self.tableView reloadData];
        }];
        datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
        [datepicker show];
    }
    if (indexPath.row == 13) {
        [_baseModel ReturnsParentKeyAnArray:@"work_profession"];
    }
    if (indexPath.row == 16) {
        [_baseModel ReturnsParentKeyAnArray:@"permanent_type"];
    }
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
