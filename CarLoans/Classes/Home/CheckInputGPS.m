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
    GPSArray = dic[@"ary"];
    self.tableView.gpsArray = dic[@"ary"];
    [self.tableView reloadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ChooseGPSVC *vc = [ChooseGPSVC new];
            vc.gpsArray = GPSArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
    [GPSArray removeObjectAtIndex:index];
    self.tableView.gpsArray = GPSArray;
    [self.tableView reloadData];
}


//-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
//    if ([state isEqualToString:@"delete"]) {
//        [GPSArray removeObjectAtIndex:index];
//        self.tableView.gpsArray = GPSArray;
//        [self.tableView reloadData];
//    }
//}

-(void)Confirm:(UIButton *)sender{
    NSMutableArray * array = [NSMutableArray array];
    
    UITextField * textfield = [self.view viewWithTag:400];
    if (textfield.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入审核意见"];
        return;
    }
    
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.code = @"632708";
    http1.showView = self.view;
    http1.parameters[@"useStatus"] = @"0";
    [http1 postWithSuccess:^(id responseObject) {
        NSArray *ary = responseObject[@"data"];
    
        for (int i = 0; i < ary.count; i ++) {
            for (int j = 0; j < GPSArray.count; j ++) {
                if ([ary[i][@"gpsDevNo"] isEqualToString:GPSArray[j]]) {
                    NSDictionary *dic = @{@"code":ary[i][@"code"]};
                    [array addObject:dic];
                }
            }
        }
        
        
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
        
        
    } failure:^(NSError *error) {
        
    }];

    
    
    
    
    
}
@end
