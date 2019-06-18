//
//  TongDunVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TongDunVC.h"
#import "TongDunTableView.h"
#import "TongDunTopView.h"
@interface TongDunVC ()
@property (nonatomic,strong) TongDunTableView * tableView;
@property (nonatomic,strong) TongDunTopView * tongdunHeadView;
@end

@implementation TongDunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"同盾征信详情";
    
    self.tableView = [[TongDunTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.tag = 1000019;
    NSString * str = self.result;
    str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSDictionary * dic = [[BaseModel user]dictionaryWithJsonString:str];
    self.tableView.tongdunResult = dic[@"result_desc"];
    self.tableView.risk_items =  dic[@"result_desc"][@"ANTIFRAUD"][@"risk_items"];
    [self.view addSubview:self.tableView];
    
    _tongdunHeadView = [[TongDunTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 170)];
    _tongdunHeadView.tongdunResult = dic;
    self.tableView.tableHeaderView = _tongdunHeadView;
}


@end
