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
@interface ReferenceInputVC ()<RefreshDelegate>
@property (nonatomic , strong)ReferenceInputTableView *tableView;
@property (nonatomic , strong)NSArray *dataArray;

@property (nonatomic , strong)NSMutableArray *creditList;

@end

@implementation ReferenceInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"录入征信结果";
    [self initTableView];
    [self cdbiz_statusLoadData];
    _creditList = [NSMutableArray array];
    for (int i = 0; i < self.surveyModel.creditUserList.count; i ++) {
        [_creditList addObject:@""];
    }
    
//    [self loadData];
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
    self.tableView = [[ReferenceInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.surveyModel;
    [self.view addSubview:self.tableView];
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"录入"]) {
        ReferenceInputDetailsVC *vc = [ReferenceInputDetailsVC new];
        vc.dataDic = self.surveyModel.creditUserList[index];
        vc.creditListDic = _creditList[index];
        vc.row = index;
        vc.creditListBlock = ^(NSDictionary * _Nonnull creditListDic, NSInteger row) {
            [_creditList replaceObjectAtIndex:row withObject:creditListDic];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        for (int i = 0; i < _creditList.count; i ++) {
            if ([BaseModel isBlankDictionary:_creditList[i]] == YES) {
                [TLAlert alertWithInfo:[NSString stringWithFormat:@"请录入%@的征信结果",self.surveyModel.creditUserList[i][@"userName"]]];
                return;
            }
        }
        
//        UITextField *textField = [self.view viewWithTag:3000];
//        if ([textField.text isEqualToString:@""]) {
//            [TLAlert alertWithInfo:@"请输入说明"];
//            return;
//        }
        
        TLNetworking *http = [TLNetworking new];
        http.code = @"632111";
        http.showView = self.view;
//        http.parameters[@"approveNote"] = textField.text;
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
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    SurveyInformationVC *vc = [SurveyInformationVC new];
    vc.dataDic = self.surveyModel.creditUserList[index - 123];
    
    [self.navigationController pushViewController:vc animated:YES];
}





@end
