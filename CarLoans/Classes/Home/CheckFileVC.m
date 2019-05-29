//
//  CheckFileVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/13.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckFileVC.h"
#import "CheckFileTableView.h"
#import "FileModel.h"
@interface CheckFileVC ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectRow;
    NSMutableArray * FileArray;
    NSInteger selectNumber;
    NSInteger locationCode;
}
@property (nonatomic,strong) CheckFileTableView * tableView;
@property (nonatomic,strong) NSMutableArray<FileModel *> * filemodels;
@end

@implementation CheckFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认入档";
//    [self initTable];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else{
        http.parameters[@"code"] = self.model.code;
    }
    [http postWithSuccess:^(id responseObject) {
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTable];
    } failure:^(NSError *error) {
        
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:ADDADPEOPLENOTICE object:nil];
    
    //    UIButton * button = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    // Do any additional setup after loading the view.
}
- (void)InfoNotificationAction:(NSNotification *)notification
{
    [self findFile];
}

#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADDADPEOPLENOTICE object:nil];
}
-(void)initTable{
    self.tableView = [[CheckFileTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.location = [[BaseModel user]ReturnEnterNameByCode:self.model.enterLocation];
    [self findFile];
    [self.view addSubview:self.tableView];
}
-(void)findFile{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632227";
    http.parameters[@"bizCode"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        FileArray = responseObject[@"data"];
        self.filemodels = [FileModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.FileArray = FileArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
//-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"632229";
//    http.parameters[@"code"] = self.model.code;
//    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
//    http.parameters[@"enterLocation"] = self.model.enterLocation;
//    [http postWithSuccess:^(id responseObject) {
//        NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSError *error) {
//        
//    }];
//}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632229";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"enterLocation"] = self.model.enterLocation;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
