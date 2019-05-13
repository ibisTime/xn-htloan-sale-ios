//
//  AddTaskVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AddTaskVC.h"
#import "AddTaskTableView.h"
#import "InputBoxCell.h"
@interface AddTaskVC ()<RefreshDelegate>
@property (nonatomic,strong) AddTaskTableView * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@end

@implementation AddTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加任务";
    [self initTableView];
    
    self.passBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1000;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20), 50);
    [self.passBtn addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    // Do any additional setup after loading the view.
}

-(void)initTableView{
    self.tableView = [[AddTaskTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.dataDic = self.dataDic;
    self.tableView.selectRow = self.selectRow;
    self.tableView.state = self.state;
    self.tableView.isFirstEntry = self.isFirstEntry;
//    self.tableView.model= self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)confirm:(UIButton *)sender{
//     InputBoxCell  * cell1 = [self.view viewWithTag:1000];
     InputBoxCell  * cell2 = [self.view viewWithTag:1000];
     InputBoxCell  * cell3 = [self.view viewWithTag:1001];
    if (self.model) {
        NSDictionary *dataDic  = @{@"getUser":self.model.saleUserName,@"name":cell2.nameTextField.text,@"time":cell3.nameTextField.text,@"createtime":[BaseModel getCurrentTime]};
        NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:dataDic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}
@end
