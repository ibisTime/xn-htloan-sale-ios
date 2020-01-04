//
//  MasterLenderInformationVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/1.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "MasterLenderInformationVC.h"
#import "MasterLenderInformationTableView.h"
@interface MasterLenderInformationVC ()<RefreshDelegate,BaseModelDelegate>
{
    BaseModel *_baseModel;
    NSInteger selectRow;
}


@property (nonatomic , strong)NSString *companyName;
@property (nonatomic , strong)NSString *position;
@property (nonatomic , strong)NSString *nowAddress;
@property (nonatomic , strong)NSString *companyAddress;
@property (nonatomic , strong)NSString *relation;

@property (nonatomic , strong)MasterLenderInformationTableView *tableView;
@property (nonatomic , strong)SurveyModel *model;
@end

@implementation MasterLenderInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"完善%@信息",_dataDic[@"dvalue"]];
    [self initTableView];
    
    _baseModel = [BaseModel user];
    _baseModel.ModelDelegate = self;
    
    [self loadData];
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    
    if (selectRow == 1) {
        _position = dic[@"dkey"];
        _tableView.position = dic[@"dkey"];
    }
    if (selectRow == 4) {
        _relation = dic[@"dkey"];
        _tableView.relation = dic[@"dkey"];
    }
    [self.tableView reloadData];
}

-(void)initTableView
{
    self.tableView = [[MasterLenderInformationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75 + 10000) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isDetails = self.isDetails;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
    
    if (self.isDetails == NO) {
        UIButton *_bottomBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
        _bottomBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 45);
        [_bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_bottomBtn];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75);
    });
    
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
    
    UITextField *tf1 = [self.view viewWithTag:1000];
    //    住宅电话
    UITextField *tf2 = [self.view viewWithTag:1002];
    UITextField *tf3 = [self.view viewWithTag:1003];
    //    单位地址

    
//    @property (nonatomic , strong)NSString *companyName;
//    @property (nonatomic , strong)NSString *position;
//    @property (nonatomic , strong)NSString *nowAddress;
//    @property (nonatomic , strong)NSString *companyAddress;
//    @property (nonatomic , strong)NSString *relation;
    NSArray *creditUserList = @[@{@"loanRole":[BaseModel convertNull:_dataDic[@"dkey"]],
                                  @"companyName":tf1.text,
                                  @"position":[BaseModel convertNull:_position],
                                  @"nowAddress":tf2.text,
                                  @"companyAddress":tf3.text,
                                  @"relation":[BaseModel convertNull:_relation]
                                  }];
    
    http.parameters[@"creditUserList"] = creditUserList;
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
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
                
                
                self.companyName = creditUser[@"companyName"];
                self.tableView.companyName = self.companyName;
        
                self.position = creditUser[@"position"];
                self.tableView.position = self.position;
                
                self.nowAddress = creditUser[@"nowAddress"];
                self.tableView.nowAddress = self.nowAddress;
                
                self.companyAddress = creditUser[@"companyAddress"];
                self.tableView.companyAddress = self.companyAddress;
                
                self.relation = creditUser[@"relation"];
                self.tableView.relation = creditUser[@"relation"];
                
                
                
                [self.tableView reloadData];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDetails == YES) {
        return;
    }
    selectRow = indexPath.row;
    if (indexPath.row == 1) {
        [_baseModel ReturnsParentKeyAnArray:@"work_profession"];
    }
    if (indexPath.row == 4) {
        [_baseModel ReturnsParentKeyAnArray:@"credit_user_relation"];
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
