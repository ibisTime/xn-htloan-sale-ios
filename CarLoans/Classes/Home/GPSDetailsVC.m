//
//  GPSDetailsVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GPSDetailsVC.h"
#import "GPSDetailsTableView.h"
#import "DataTransferModel.h"
@interface GPSDetailsVC ()<RefreshDelegate>
@property (nonatomic,strong) GPSDetailsTableView * tableView;
@property (nonatomic , strong)DataTransferModel *model;
@end

@implementation GPSDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS寄送详情";
    [self loaddata];
    
}
-(void)loaddata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632156";
    http.parameters[@"code"] = self.code;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.model = [DataTransferModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self inittable];
    } failure:^(NSError *error) {
        
    }];
}
-(void)inittable{
    self.tableView = [[GPSDetailsTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}
@end
