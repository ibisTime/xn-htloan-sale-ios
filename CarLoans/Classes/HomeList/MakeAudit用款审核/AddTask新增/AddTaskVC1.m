//
//  AddTaskVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddTaskVC1.h"
#import "AddTaskTableView1.h"
#import "AddTaskExecutorVC.h"
@interface AddTaskVC1 ()<RefreshDelegate,BaseModelDelegate>
{
    NSArray *saleUserIdAry;
    NSString *realName;
}
@property (nonatomic , strong)AddTaskTableView1 *tableView;

@end

@implementation AddTaskVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"新增";
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630066";
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        saleUserIdAry = responseObject[@"data"];
        
        if ([BaseModel isBlankString:_dataDic[@"name"]] == NO) {
            _tableView.name = _dataDic[@"name"];
            _tableView.time = _dataDic[@"time"];
            for (int i = 0; i < saleUserIdAry.count; i ++) {
                if ([_dataDic[@"getUser"] isEqualToString:saleUserIdAry[i][@"userId"]]) {
                    _tableView.realName = saleUserIdAry[i][@"realName"];
                    realName = saleUserIdAry[i][@"userId"];
                }
            }
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)initTableView
{
    self.tableView = [[AddTaskTableView1 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        AddTaskExecutorVC *vc = [AddTaskExecutorVC new];
        CarLoansWeakSelf;
        vc.returnAryBlock = ^(SurveyModel * _Nonnull model) {
            realName = model.userId;
            weakSelf.tableView.realName = model.realName;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
//        NSMutableArray *array = [NSMutableArray array];
//        for (int i = 0; i < saleUserIdAry.count; i ++) {
//            [array addObject:saleUserIdAry[i][@"realName"]];
//        }
//        BaseModel *baseModel = [BaseModel user];
//        baseModel.ModelDelegate = self;
//        [baseModel CustomBouncedView:array setState:@"100"];
    }
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"返回"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        
        UITextField *Tf1 = [self.view viewWithTag:100];
        UITextField *Tf2 = [self.view viewWithTag:101];
        
        if ([Tf1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入任务名称"];
            return;
        }
        if ([Tf2.text floatValue] == 0) {
            [TLAlert alertWithInfo:@"请输入任务小时"];
            return;
        }
        if ([BaseModel isBlankString:realName] == YES) {
            [TLAlert alertWithInfo:@"请选择执行人"];
            return;
        }
        
        NSDictionary *dic = @{@"name":Tf1.text,
                              @"time":Tf2.text,
                              @"getUser":realName
                              };
        self.returnAryBlock(dic, _row);
        [self.navigationController popViewControllerAnimated:YES];
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
