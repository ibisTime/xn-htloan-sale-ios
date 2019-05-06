//
//  CheckVC2.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckVC2.h"
#import "CheckTableView2.h"
#import "InputBoxCell.h"
#import "AddTaskVC.h"
@interface CheckVC2 ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectRow;
    NSMutableArray * TaskArray;
}
@property (nonatomic,strong) CheckTableView2 * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) UIButton * UnpassBtn;
@end

@implementation CheckVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self inittableview];
    TaskArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    self.passBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1001;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH  / 2 - 20, 50);
    [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    self.UnpassBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.UnpassBtn.tag = 1000;
    self.UnpassBtn.frame = CGRectMake((SCREEN_WIDTH - 20) / 2 + 10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20) / 2 - 20, 50);
    [self.UnpassBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.UnpassBtn];
    // Do any additional setup after loading the view.
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    if (selectRow > 1000) {
        [TaskArray replaceObjectAtIndex:selectRow - 1234 withObject:dic];
    }else
    {
        [TaskArray addObject:dic];
    }
    self.tableView.taskArray = TaskArray;
    [self.tableView reloadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADDADPEOPLENOTICE object:nil];
}
-(void)inittableview{
    self.tableView = [[CheckTableView2 alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model= self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)Confirm:(UIButton *)sender{
    InputBoxCell * cell = [self.view viewWithTag:400];
    NSString * approveNote = cell.nameTextField.text;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = self.code;
    if (sender.tag == 1001) {
        http.parameters[@"approveResult"] = @"1";
    }
    else
        http.parameters[@"approveResult"] = @"0";
    http.parameters[@"missionList"] = TaskArray;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = approveNote;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    selectRow = index;
    AddTaskVC *vc = [[AddTaskVC alloc]init];
    vc.dataDic = self.tableView.taskArray[index - 1234];
    vc.selectRow = index;
    if (index == 1234) {
        vc.isFirstEntry = YES;
    }
    vc.state = self.state;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
