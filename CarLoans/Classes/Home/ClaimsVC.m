//
//  ClaimsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ClaimsVC.h"
#import "ClaimsTableView.h"
#import "AccessSingleVC.h"
#import "GPSTeamModel.h"
@interface ClaimsVC ()<RefreshDelegate,BaseModelDelegate>{
    NSString * str;
}
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) AccessSingleModel *model;
@property (nonatomic ,strong) NSMutableArray <GPSTeamModel *>*teamArray;
@property (nonatomic ,copy) NSString *teamCode;

@end

@implementation ClaimsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申领";
    [self initTableView];
    self.teamArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ApplyForCancellation object:nil];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    
    self.tableView.model = notification.userInfo[@"userInfo"];
    self.model = self.tableView.model;
    self.tableView.isList = YES;
    [self.tableView reloadData];
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        //选择
//        BaseModel *model = [BaseModel new];
//        model.ModelDelegate = self;
//        NSMutableArray *array = [NSMutableArray array];
//        [array addObject:@"有线"];
//        [array addObject:@"无线"];
//
//        [model CustomBouncedView:array setState:@"100"];
//        return;
//    }
//    if (indexPath.section == 1) {
//        if ([self.tableView.teamStr isEqualToString:@"本部"]) {
//            if (indexPath.row == 0) {
//                AccessSingleVC *vc = [[AccessSingleVC alloc]init];
//                vc.isHidden = YES;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }else{
//            if (indexPath.row == 0) {
//              //获取团队 code
//                [self loadTeamData];
//            }
//        }
//    }
  
    //
    
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    WGLog(@"%@",dic);
    str = Str;
    _tableView.teamStr = Str;
//    if (self.tableView.teamStr) {
//
//        if ([self.tableView.teamStr isEqualToString:@"本部"]) {
//            _tableView.teamname = Str;
//            if ([Str isEqualToString:@"本部"] || [Str isEqualToString:@"分部"]) {
//                _tableView.teamStr = Str;
//
//            }
//
//
//        }else{
//            _tableView.teamname = Str;
//            if ([Str isEqualToString:@"本部"] || [Str isEqualToString:@"分部"]) {
//                _tableView.teamStr = Str;
//
//            }
//
//        }
//    }else{
//        _tableView.teamStr = Str;
//
//    }
//
//    if (self.teamArray.count >0) {
//        self.teamCode = self.teamArray[sid].code;
//    }
   
    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    NSLog(@"%ld",index);
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    UITextField *textFid3 = [self.view viewWithTag:102];

    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入申领个数"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632710";
    http.showView = self.view;
    http.parameters[@"applyWiredCount"] = textFid1.text;
    http.parameters[@"applyWirelessCount"] = textFid2.text;
//    http.parameters[@"customerName"] =self.model.applyUserName;
//    if ([self.tableView.teamStr isEqualToString:@"本部"]) {
//        http.parameters[@"applyUsername"] = self.model.applyUserName;
//
//        http.parameters[@"applyType"] =@"1";
//
//    }else{
//        http.parameters[@"applyType"] =@"2";
//        http.parameters[@"teamCode"] =self.teamCode;
//
//    }
//
//    http.parameters[@"budgetOrderCode"] = self.model.code;
    http.parameters[@"applyReason"] = textFid3.text;
    http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"type"] = [str isEqualToString:@"有线"]?@"1":@"2";
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"申领成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
- (void)loadTeamData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630197";
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.teamArray =  [GPSTeamModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%@",self.teamArray);
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        NSMutableArray *array = [NSMutableArray array];
        for (GPSTeamModel*model in self.teamArray) {
            [array addObject:model.name];
        }
        
        [model CustomBouncedView:array setState:@"100"];
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
