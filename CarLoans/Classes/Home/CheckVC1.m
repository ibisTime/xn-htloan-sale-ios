//
//  CheckVC1.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckVC1.h"
#import "CheckTableView1.h"
#import "InputBoxCell.h"
@interface CheckVC1 ()<RefreshDelegate>
@property (nonatomic,strong) CheckTableView1 * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) UIButton * UnpassBtn;
@end

@implementation CheckVC1

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self inittableview];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self inittableview];
    } failure:^(NSError *error) {
        
    }];
    if ([self.code isEqualToString:@"632461"]) {
        self.passBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
        self.passBtn.tag = 1001;
        self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH  / 2 - 20, 50);
        [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.passBtn];
        
        self.UnpassBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
        self.UnpassBtn.tag = 1000;
        self.UnpassBtn.frame = CGRectMake(SCREEN_WIDTH  / 2 + 10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH / 2 - 20, 50);
        [self.UnpassBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.UnpassBtn];
    }
    else{
        self.passBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
        self.passBtn.tag = 1001;
        self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 20, 50);
        [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.passBtn];
    }
    
    // Do any additional setup after loading the view.
}

-(void)inittableview{
    self.tableView = [[CheckTableView1 alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
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
    
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    if ([self.code isEqualToString:@"632461"]) {
         http.parameters[@"approveNote"] = approveNote;
        if (sender.tag == 1001) {
            http.parameters[@"approveResult"] = @"1";
        }
        else
            http.parameters[@"approveResult"] = @"0";
    }
    else
        http.parameters[@"makeBillNote"] = approveNote;
    
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

@end
