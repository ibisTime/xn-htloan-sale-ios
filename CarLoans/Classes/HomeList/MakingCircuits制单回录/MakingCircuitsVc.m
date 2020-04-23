//
//  MakingCircuitsVc.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakingCircuitsVc.h"
#import "MakingCircuitsTableView.h"
@interface MakingCircuitsVc ()<RefreshDelegate,BaseModelDelegate>
{
    NSArray *advanceCardCodeAry;
    NSString *advanceCardCode;
}
@property (nonatomic , strong)MakingCircuitsTableView *tableView;

@end

@implementation MakingCircuitsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

-(void)initTableView
{
    self.tableView = [[MakingCircuitsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 75) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"退回" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:throughBtn];
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:noThroughBtn];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([self.model.isPay isEqualToString:@"1"]) {
            if (indexPath.row != 4) {
                return;
            }
        }else
        {
            if (indexPath.row != 2) {
                return;
            }
        }
        
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632007";
        http.parameters[@"type"] = @"4";
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            advanceCardCodeAry = responseObject[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < advanceCardCodeAry.count; i ++) {
                [array addObject:[NSString stringWithFormat:@"%@-%@",advanceCardCodeAry[i][@"companyName"],advanceCardCodeAry[i][@"bankName"]]];
            }
            //                _advanceCardCodeDic[@"companyName"],_advanceCardCodeDic[@"bankName"]
            BaseModel *baseModel = [BaseModel user];
            baseModel.ModelDelegate = self;
            [baseModel CustomBouncedView:array setState:@"100"];
            
            
        } failure:^(NSError *error) {
            
        }];
    }
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    advanceCardCode = advanceCardCodeAry[sid][@"code"];
    self.tableView.advanceCardCodeDic = advanceCardCodeAry[sid];
    [self.tableView reloadData];
}



-(void)throughBtnClick
{
    [TLAlert alertWithTitle:@"提示" msg:@"是否退回上一节点" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
        
    } confirm:^(UIAlertAction *action) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632553";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"approveResult"] = @"0";
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:@"退回成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }];
}

-(void)noThroughBtnClick
{
    if ([BaseModel isBlankString:advanceCardCode] == YES) {
        [TLAlert alertWithInfo:@"请选择收款账号"];
        return;
    }
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632553";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"advanceOutCardCode"] = advanceCardCode;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithSucces:@"确认制单回录"];
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
