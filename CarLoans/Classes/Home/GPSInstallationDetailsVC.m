//
//  GPSInstallationDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInstallationDetailsVC.h"
#import "GPSInstallationDetailsTableView.h"
#import "AddGPSInstallationVC.h"
@interface GPSInstallationDetailsVC ()<RefreshDelegate>
{
    NSMutableArray *listArray;
    NSMutableArray *gpsAzListArray;
    NSInteger isSelect;
}
@property (nonatomic , strong)GPSInstallationDetailsTableView *tableView;

@end

@implementation GPSInstallationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"安装回录";
    listArray = [NSMutableArray array];
    gpsAzListArray= [NSMutableArray array];
    
    
    TLNetworking * http = [TLNetworking new];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [GPSInstallationModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDGPS object:nil];
}

#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{

    NSDictionary *dic = notification.userInfo;
    if (isSelect >= 100) {
        [listArray replaceObjectAtIndex:isSelect - 100 withObject:dic[@"dic"]];
        [gpsAzListArray replaceObjectAtIndex:isSelect - 100 withObject:dic];

    }
    else
    {
        [listArray insertObject:dic[@"dic"] atIndex:0];
        [gpsAzListArray insertObject:dic atIndex:0];
//        [listArray addObject:dic[@"dic"]];
//        [gpsAzListArray addObject:dic];
    }
    self.tableView.peopleAray = gpsAzListArray;
    [self.tableView reloadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADDGPS object:nil];
}

- (void)initTableView {
    self.tableView = [[GPSInstallationDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    self.tableView.peopleAray = self.model.budgetOrderGps;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1) {
        isSelect = indexPath.row + 100;
        AddGPSInstallationVC *vc = [[AddGPSInstallationVC alloc]init];
        vc.gpsArray = listArray;
        vc.dataDic = gpsAzListArray[indexPath.row];
        vc.isSelect = isSelect;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        isSelect = indexPath.row;
        AddGPSInstallationVC *vc = [[AddGPSInstallationVC alloc]init];
        vc.gpsArray = listArray;
        
//        vc.isSelect = isSelect;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    [listArray removeObjectAtIndex:index];
    [gpsAzListArray removeObjectAtIndex:index];
    self.tableView.peopleAray = gpsAzListArray;
    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (gpsAzListArray.count == 0) {
        [TLAlert alertWithInfo:@"请添加GPS"];
        return;
    }
    
   
    TLNetworking *http = [TLNetworking new];
    http.code = @"632126";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"gpsAzList"] = listArray;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"安装成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

}

@end
