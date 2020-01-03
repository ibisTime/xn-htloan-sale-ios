//
//  YeWuCheckVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/24.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "YeWuCheckVC.h"
#import "YeWuTableView.h"
@interface YeWuCheckVC ()<RefreshDelegate>
@property (nonatomic,strong) YeWuTableView * tableView;
@end

@implementation YeWuCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.model.cancelNodeCode isEqualToString:@"i1"]) {
    self.title = @"业务总监审核";
    }else
        self.title = @"财务总监审核";
    
    [self loaddetails];
    
    // Do any additional setup after loading the view.
}
-(void)loaddetails{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else
        http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",[AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]]);
        self.model = [CustomerInvalidModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self inittable];
    } failure:^(NSError *error) {
        
    }];
}
-(void)inittable{
    self.tableView = [[YeWuTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    UITextField * text = [self.view viewWithTag:400];
    TLNetworking * http = [[TLNetworking alloc]init];
    if ([self.model.cancelNodeCode isEqualToString:@"i1"]) {
        http.code = @"632191";
    }
    else{
        http.code = @"632192";
    }
    http.parameters[@"approveNote"] = text.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.model.code;
    if (index == 100) {
        http.parameters[@"approveResult"] = @"1";
    }else{
        http.parameters[@"approveResult"] = @"0";
    }
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
