//
//  CheckCarVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckCarVC.h"
#import "CheckCarTableView.h"

@interface CheckCarVC ()<RefreshDelegate>
@property (nonatomic,strong) CheckCarTableView * tableView;
@end

@implementation CheckCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)inittable{
    self.tableView = [[CheckCarTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
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
