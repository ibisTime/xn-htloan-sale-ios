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
    [self inittable];
    
    // Do any additional setup after loading the view.
}

-(void)inittable{
    self.tableView = [[YeWuTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}

@end
