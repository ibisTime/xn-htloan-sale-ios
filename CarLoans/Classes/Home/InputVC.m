//
//  InputVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "InputVC.h"
#import "InputTableView.h"
#import "AddFilesVC.h"
#import "FileModel.h"
@interface InputVC ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectRow;
    NSMutableArray * FileArray;
    NSInteger selectNumber;
    NSString * locationCode;
}
@property (nonatomic,strong) InputTableView * tableView;
@property (nonatomic,strong) NSMutableArray<FileModel *> * filemodels;
@end

@implementation InputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"入档";
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];

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
    self.tableView = [[InputTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.filelocation = [[BaseModel user]ReturnEnterNameByCode:self.model.enterLocation];
    self.tableView.location = [[BaseModel user]ReturnLocationNameByCode:self.model.enterLocation];
    self.tableView.enterCode = self.model.enterCode;
    locationCode = self.model.enterLocation;
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
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectNumber = indexPath.section;
    if (indexPath.section == 1) {
        BaseModel *model = [BaseModel new];
//        [model ReturnsParentKeyAnArray:@"enter_location"];
        [model ReturnsEnterLocation:@""];
        model.ModelDelegate = self;
    }
    if (indexPath.section == 2) {
        AddFilesVC * vc = [[AddFilesVC alloc]init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    WGLog(@"%@",dic);
    if (selectNumber == 1)
    {
        _tableView.filelocation = Str;
        locationCode = [NSString stringWithFormat:@"%@",dic[@"code"]];
        NSArray * arr = [USERDEFAULTS objectForKey:ENTERLOCATION];
        _tableView.location = arr[sid][@"location"];
        
        NSLog(@"locationmmj %@",arr[sid][@"location"]);
    }
    
    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
    if (index == 102) {
        AddFilesVC *vc = [[AddFilesVC alloc]init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (index == 1234) {
        AddFilesVC *vc = [[AddFilesVC alloc]init];
        vc.model = self.model;
        vc.fileModel = self.filemodels[sender.tag - 1234];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        AddFilesVC *vc = [[AddFilesVC alloc]init];
        vc.model = self.model;
        vc.fileModel = self.filemodels[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"delect"]) {
        [self deleteFile:index];
    }
    if ([state isEqualToString:@"confirm"]) {
        [self input];
    }
}
-(void)input{
    UITextField * text = [self.view viewWithTag:3333];
    
    if (locationCode .length == 0) {
        [TLAlert alertWithMsg:@"请选择存放位置"];
        return;
    }
    if (text.text.length == 0) {
        [TLAlert alertWithMsg:@"请输入档案编号"];
        return;
    }
    
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632134";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"enterLocation"] = [NSString stringWithFormat:@"%@", locationCode];
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"enterCode"] = text.text;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)deleteFile : (NSInteger)index{
    if (self.filemodels.count > 0) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632221";
        http.parameters[@"code"] = self.filemodels[index].code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [self findFile];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}
@end

