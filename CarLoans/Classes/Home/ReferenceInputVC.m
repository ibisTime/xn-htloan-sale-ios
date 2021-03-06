//
//  ReferenceInputVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ReferenceInputVC.h"
#import "ReferenceInputTableView.h"
#import "SurveyInformationVC.h"
#import "ReferenceInputDetailsVC.h"
@interface ReferenceInputVC ()<RefreshDelegate>{
    NSArray * array;
}
@property (nonatomic , strong)ReferenceInputTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;

@property (nonatomic , strong)NSMutableArray *creditList;

@end

@implementation ReferenceInputVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"632518";
    http.parameters[@"bizCode"] = self.surveyModel.code;
    http.parameters[@"start"] = @1;
    http.parameters[@"limit"] = @10;
    [http postWithSuccess:^(id responseObject) {
        array = responseObject[@"data"][@"list"];
        
        
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view._code    __NSCFString *    @"CB201905301021222019597"    0x0000000280827d50
    self.title = @"录入征信结果";
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.surveyModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.surveyModel = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        _creditList = [NSMutableArray array];
        for (int i = 0; i < self.surveyModel.creditUserList.count; i ++) {
            [_creditList addObject:self.surveyModel.creditUserList[i]];
        }
        
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
    
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
    http.showView = self.view;
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
    self.tableView = [[ReferenceInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.surveyModel;
    [self.view addSubview:self.tableView];
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"录入"]) {
        [self ReferenceInputRow:index];
        
    }else
    {
        for (int i = 0; i < _creditList.count; i ++) {
            if ([BaseModel isBlankDictionary:_creditList[i]] == YES) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"请录入%@的征信结果",self.surveyModel.creditUserList[i][@"userName"]]];
                return;
            }
            NSDictionary * dic = _creditList[i];
            if (dic.count == 11) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"请录入%@的征信结果",self.surveyModel.creditUserList[i][@"userName"]]];
                return;
            }
        }
        
        
        TLNetworking *http = [TLNetworking new];
        http.code = @"632111";
        http.showView = self.view;
        http.parameters[@"creditList"] = _creditList;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"bizCode"] = _surveyModel.code;
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"录入成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }
    
//    NSDictionary * dic = [NSDictionary 
}

-(void)ReferenceInputRow:(NSInteger)row
{
    ReferenceInputDetailsVC *vc = [ReferenceInputDetailsVC new];
//    vc.dataDic = self.surveyModel.creditUserList[row];
    vc.dataDic = array[row];
    vc.creditListDic = _creditList[row];
    vc.row = row;
    vc.creditListBlock = ^(NSDictionary * _Nonnull creditListDic, NSInteger row) {
        [_creditList replaceObjectAtIndex:row withObject:creditListDic];
    };
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

    [self ReferenceInputRow:index - 123];
}





@end
