//
//  CheckInputGPS.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckInputGPS.h"
#import "CheckInputGPSTableView.h"
#import "ChooseGPSVC.h"
@interface CheckInputGPS ()<RefreshDelegate>
{
    NSInteger selectRow;
    NSMutableArray * GPSArray;
}
@property (nonatomic,strong) CheckInputGPSTableView * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) UIButton * UnpassBtn;
@end

@implementation CheckInputGPS

- (void)viewDidLoad {
    [super viewDidLoad];
    GPSArray = [NSMutableArray array];
    self.title = @"审核GPS";
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    self.passBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1001;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH  / 2 - 20, 50);
    [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    self.UnpassBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.UnpassBtn.tag = 1000;
    self.UnpassBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH / 2 - 20, 50);
    [self.UnpassBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.UnpassBtn];
}

- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    if (selectRow > 1000) {
        [GPSArray replaceObjectAtIndex:selectRow - 1234 withObject:dic];
    }else
    {
        for (int i = 0; i < GPSArray.count; i ++) {
            if ([dic[@"code"] isEqualToString:GPSArray[i][@"code"] ]) {
                return;
            }
        }
        
        [GPSArray addObject:dic];
        
        
    }
    self.tableView.gpsArray = GPSArray;
    [self.tableView reloadData];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADDADPEOPLENOTICE object:nil];
}
- (void)initTableView {
    self.tableView = [[CheckInputGPSTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 60) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    ChooseGPSVC * vc = [ChooseGPSVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"delete"]) {
        [GPSArray removeObjectAtIndex:index];
        self.tableView.gpsArray = GPSArray;
        [self.tableView reloadData];
    }
}

-(void)Confirm:(UIButton *)sender{
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < GPSArray.count; i++) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:GPSArray[i][@"code"] forKey:@"code"];
        [dic setObject:GPSArray[i][@"gpsType"] forKey:@"gpsType"];
        [dic setObject:GPSArray[i][@"updater"] forKey:@"updater"];
        
        [array addObject:dic];
    }
    
    UITextField * textfield = [self.view viewWithTag:400];
    TLNetworking * http = [[TLNetworking alloc]init];
    if (sender.tag == 1001) {
        if (array.count == 0) {
            [TLAlert alertWithInfo:@"请选择GPS"];
            return;
        }
        http.code = @"632711";
        http.parameters[@"gpsList"] = array;
    }
    else{
        if (textfield.text.length == 0) {
            [TLAlert alertWithInfo:@"请输入审核意见"];
            return;
        }
        http.code = @"632712";
    }
    
    
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"remark"] = textfield.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
